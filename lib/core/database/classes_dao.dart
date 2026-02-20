import 'package:diacritic/diacritic.dart';
import 'package:drift/drift.dart';

import 'database.dart';
import 'tables.dart';

/// Infer management email from student name and student's id
String _autoEmail({required String studentName, required studentId}) {
  final studentIdShort = studentId.substring(2);
  final normalized = removeDiacritics(studentName);

  final parts = normalized.split(" ");
  final firstName = parts.last;
  final initials = parts.map((part) => part.substring(0, 0)).join();

  return "$firstName.$initials$studentIdShort@sis.hust.edu.vn";
}

extension CourseClassesDao on AppDatabase {
  /// Automatically insert course class information or update it from the imported excel file
  /// the different format import is handled by different functions. This function should
  /// only require the greatest common divisor of the two formats. The other information should
  /// be optional. Returns the upserted course class id.
  Future<int> importCourseClassOld({
    required int semesterId,
    required String courseClassCode,
    required String courseId,
    required String courseName,
    required List<String> studentIds,
    required List<String> studentNames,
    required List<String>? studentEmails,
  }) async {
    // Basic check
    final numStudents = studentIds.length;
    assert(
      numStudents == studentNames.length,
      "Danh sách tên và mã sinh viên không khớp độ dài",
    );

    // Automatically infer email list if not provided
    studentEmails ??=
        studentIds.indexed.map<String>((entry) {
          final (idx, studentId) = entry;
          final studentName = studentNames[idx];
          return _autoEmail(studentName: studentName, studentId: studentId);
        }).toList();

    // Check if the provided email list matches length (inferred list will match)
    assert(numStudents == studentEmails.length);

    // This is done in a transactional way
    return transaction(() async {
      // insert or update the course class
      final courseClassId = await into(courseClass).insertOnConflictUpdate(
        CourseClassCompanion.insert(
          classCode: courseClassCode,
          courseId: courseId,
          semesterId: semesterId,
        ),
      );

      // update the class registration
      final studentEntities = <StudentCompanion>[];
      final registrationEntities = <RegistrationCompanion>[];
      for (int idx = 0; idx < numStudents; idx++) {
        final studentName = studentNames[idx];
        final studentId = studentIds[idx];
        final studentEmail = studentEmails![idx];

        // Student entity
        final studentEntity = StudentCompanion.insert(
          id: studentId,
          email: studentEmail,
          name: studentName,
        );

        // registration entity
        final registrationEntity = RegistrationCompanion.insert(
          courseClassId: courseClassId,
          studentId: studentId,
        );

        // Store entities
        studentEntities.add(studentEntity);
        registrationEntities.add(registrationEntity);
      }

      // Upsert all the students and registrations
      await batch((batch) async {
        batch.insertAllOnConflictUpdate(student, studentEntities);
        batch.insertAllOnConflictUpdate(registration, registrationEntities);
      });

      return courseClassId;
    });
  }

  /// Get list of students based on course class [id]
  Selectable<StudentData> getClassStudentList({
    required int id,
  }) {
    final stmt = select(courseClass).join([
      innerJoin(
        registration,
        courseClass.id.equalsExp(registration.courseClassId),
      ),
      innerJoin(
        student,
        student.id.equalsExp(registration.studentId),
      ),
    ]);

    stmt.where(courseClass.id.equals(id));
    return stmt.map((row) => row.readTable(student));
  }

  /// Get all attendance session of a class with ID [id]
  Selectable<SessionData> getAttendanceSessions({
    required int id,
  }) {
    final stmt = select(session);
    stmt.where((r) => r.courseClassId.equals(id));
    return stmt;
  }

  /// Get list of student and the attendance status for a single attendance session
  /// Returns selection query of tuples of type [(StudentData, AttendanceStatus)]
  Selectable<(StudentData, AttendanceStatus)> getAttendanceSessionRecords({
    required int sessionId,
  }) {
    final stmt = select(session).join([
      innerJoin(attendance, attendance.sessionId.equalsExp(session.id)),
      innerJoin(student, student.id.equalsExp(attendance.studentId)),
    ]);
    return stmt.map((row) {
      final studentData = row.readTable(student);
      final attendanceData = row.readTable(attendance);
      return (studentData, attendanceData.attendanceStatus);
    });
  }

  /// Update attendance status of a single student in a single session
  /// If the student is not in the session (newly registered), then
  /// the attendance record is inserted into the db.
  Future<int> updateAttendanceStatus({
    required int sessionId,
    required String studentId,
    required AttendanceStatus status,
  }) {
    final stmt = into(attendance);
    final entity = AttendanceCompanion.insert(
      sessionId: sessionId,
      studentId: studentId,
      attendanceStatus: status,
    );
    return stmt.insertOnConflictUpdate(entity);
  }

  /// Create attendance session for a course class  [id]
  /// Insert all  the student from thencourse class to the attendance record
  /// The default attendance status is [absent]
  Future<Null> createAttendanceSession({
    required int classId,
    required DateTime datetime,
  }) async {
    final sessionItem = SessionCompanion.insert(
      courseClassId: classId,
      date: datetime,
    );

    final studentsSelect = getClassStudentList(id: classId);
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
      batch(
        (batch) => batch.insertAll(
          attendance,
          attendanceItems,
        ),
      );
    });
  }
}
