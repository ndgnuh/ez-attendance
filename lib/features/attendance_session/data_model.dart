import 'package:drift/drift.dart';

import '../../core/database_service.dart';
import '../../core/enums.dart';

enum ScanningMode {
  markAttend,
  markLate,
  markContributed;

  String get label => switch (this) {
    markAttend => "Điểm danh",
    markLate => "Điểm danh (đi muộn)",
    markContributed => "Cộng điểm đóng góp",
  };
}

extension Dao on AppDatabase {
  /// Query attendance [Session] of a [CourseClass].
  /// Returns a [Selectable<SessionData>].
  Selectable<SessionData> getAttendanceSessions(int courseClassId) {
    final stmt = select(session);
    stmt.where((r) => r.courseClassId.equals(courseClassId));
    stmt.orderBy([
      (row) => OrderingTerm.asc(row.courseClassId),
      (row) => OrderingTerm.desc(row.date),
    ]);
    return stmt;
  }

  /// Create attendance session for a course class  [id]
  /// Insert all  the student from thencourse class to the attendance record
  /// The default attendance status is [absent]
  Future<Null> createAttendanceSession({
    required int courseClassId,
    required DateTime datetime,
  }) async {
    final sessionItem = SessionCompanion.insert(
      courseClassId: courseClassId,
      date: datetime,
    );

    final studentsSelect = getClassStudentList(id: courseClassId);
    return await transaction(() async {
      // Create attendance session first
      final sessionId = await into(session).insert(sessionItem);

      // Map to attendance companion
      final attendanceItems =
          await studentsSelect.map((student) {
            return AttendanceCompanion.insert(
              attendanceStatus: AttendanceStatus.absent,
              sessionId: sessionId,
              studentId: student.id,
            );
          }).get();

      // Batch insert
      for (final attendanceItem in attendanceItems) {
        await into(attendance).insertOnConflictUpdate(attendanceItem);
      }
    });
  }

  /// List students in an attendance session
  /// The student are sorted by first name and then by ID
  Selectable<(StudentData, AttendanceData)> getAttendanceList({
    required int sessionId,
    required String searchText,
  }) {
    final stmt = select(attendance).join([
      innerJoin(
        student,
        student.id.equalsExp(attendance.studentId),
      ),
    ]);

    // Filter
    stmt.where(attendance.sessionId.equals(sessionId));
    if (searchText.isNotEmpty) {
      stmt.where(student.searchKey.contains(searchText));
    }

    // Order
    stmt.orderBy([
      OrderingTerm.asc(student.firstName),
      OrderingTerm.asc(student.id),
    ]);

    return stmt.map((row) {
      final studentData = row.readTable(student);
      final attendanceData = row.readTable(attendance);
      return (studentData, attendanceData);
    });
  }

  /// Update attendance status of a single student in a single session
  /// If the student is not in the session (newly registered), then
  /// the attendance record is inserted into the db.
  Future<int> updateAttendanceStatus({
    required int sessionId,
    required String studentId,
    required AttendanceStatus status,
    int? numContributions,
  }) {
    final stmt = into(attendance);
    final entity = AttendanceCompanion.insert(
      sessionId: sessionId,
      studentId: studentId,
      attendanceStatus: status,
      numContributions: switch (numContributions) {
        int n => Value(n),
        null => Value.absent(),
      },
    );
    return stmt.insertOnConflictUpdate(entity);
  }

  /// Check if the student is in the attendance list
  /// If not, implies that the student also not in the registration list and needs to be added
  Future<AttendanceData?> checkStudentInAttendanceList({
    required String studentId,
    required int sessionId,
  }) async {
    final stmt = select(attendance);
    stmt.where(
      (row) =>
          attendance.studentId.equals(studentId) &
          attendance.sessionId.equals(sessionId),
    );
    final entry = await stmt.getSingleOrNull();
    return entry;
  }

  /// Shorthand
  Future<int> markAttendanceAs({
    required AttendanceData data,
    required AttendanceStatus status,
  }) => updateAttendanceStatus(
    sessionId: data.sessionId,
    studentId: data.studentId,
    status: status,
  );

  /// Delete attendance session, delete all the attendance records
  /// belong to the said session
  Future<void> deleteAttendanceSession(int sessionId) async {
    final stmts = [
      delete(attendance)..where((row) => row.sessionId.equals(sessionId)),
      delete(session)..where((row) => row.id.equals(sessionId)),
    ];
    await transaction(() async {
      for (final stmt in stmts) {
        await stmt.go();
      }
    });
  }

  /// Add student to an attendance session and a class
  /// The [attendanceStatus] is default to [AttendanceStatus.present],
  /// because this case is probably when the student is new in the class;
  /// the teacher met the student when he is present and add him.
  /// Return attendance data for convenience
  Future<AttendanceData> addStudent({
    required int sessionId,
    required StudentCompanion studentCompanion,
    AttendanceStatus attendanceStatus = AttendanceStatus.present,
  }) async {
    // Get the class ID
    final classIdStmt = select(session)
      ..where((row) => row.id.equals(sessionId));
    final courseClassId =
        await classIdStmt.map((row) => row.courseClassId).getSingle();

    // Insert companions
    final studentId = studentCompanion.id.value;
    final registrationCompanion = RegistrationCompanion.insert(
      courseClassId: courseClassId,
      studentId: studentId,
    );
    final attendanceCompanion = AttendanceCompanion.insert(
      attendanceStatus: attendanceStatus,
      sessionId: sessionId,
      studentId: studentId,
      numContributions: Value.absent(),
    );

    return await transaction(() async {
      await into(student).insertOnConflictUpdate(studentCompanion);
      await into(registration).insertOnConflictUpdate(registrationCompanion);
      await into(attendance).insertOnConflictUpdate(attendanceCompanion);
      return AttendanceData(
        attendanceStatus: attendanceStatus,
        numContributions: 0,
        sessionId: sessionId,
        studentId: studentId,
      );
    });
  }
}

final _studentIdPattern = RegExp(r"(20\d{6,7})");
String? matchStudentId(String scanned) {
  final match = _studentIdPattern.firstMatch(scanned);
  if (match == null) return null;
  return match.group(0)!;
}
