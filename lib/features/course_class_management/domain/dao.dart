import 'package:drift/drift.dart';
import 'package:riverpod/riverpod.dart';

import '../../../core/database_service.dart';
import 'models.dart';

/// Service for managing course classes
class CourseClassManagementService {
  static final provider = FutureProvider((ref) async {
    final db = await ref.watch(databaseProvider.future);
    return CourseClassManagementService(db: db);
  });

  final AppDatabase db;

  CourseClassManagementService({required this.db});

  /// List all the semesters in a descend order.
  Selectable<SemesterData> listSemesters() {
    final stmt = db.select(db.semester);
    stmt.orderBy([
      (semester) => OrderingTerm.desc(semester.name),
    ]);
    return stmt;
  }

  /// Delete course class, along with all
  /// the registration and attendance session
  Future<void> deleteCourseClass(int courseClassId) async {
    // Select session ids to cascade deletion
    final sessionIdstmt = db.selectOnly(db.session);
    sessionIdstmt.where(db.session.courseClassId.equals(courseClassId));
    sessionIdstmt.addColumns([db.session.id]);

    final statements = [
      // Delete student registration
      db.delete(db.registration)
        ..where((row) => row.courseClassId.equals(courseClassId)),

      // Delete attendance records
      db.delete(db.attendance)
        ..where((row) => row.sessionId.isInQuery(sessionIdstmt)),

      // Delete session entries
      db.delete(db.session)..where((row) => row.id.isInQuery(sessionIdstmt)),

      // Delete course class
      db.delete(db.courseClass)..where(
        (row) => row.id.equals(courseClassId),
      ),
    ];

    return db.transaction(() async {
      for (final stmt in statements) {
        await stmt.go();
      }
    });
  }

  Selectable<CourseClassData> getCourseClasses({
    int? courseClassId,
    String? courseClassCode,
    SemesterData? semester,
  }) {
    final stmt = db.select(db.courseClass);

    // Optionally filter by semester
    if (semester != null) {
      stmt.where((row) => row.semesterId.equals(semester.id));
    }

    // Get by class code if possible
    if (courseClassCode != null) {
      stmt.where((row) => row.classCode.equals(courseClassCode));
    }

    // Get by natural id if possible
    if (courseClassId != null) {
      stmt.where((row) => row.id.equals(courseClassId));
    }

    return stmt;
  }

  /// Import course class from data
  Future<int> importCourseClass({
    required ImportData data,
    required SemesterData semester,
  }) async {
    // Check if the provided email list matches length (inferred list will match)
    final numStudents = data.studentIds.length;
    assert(numStudents == data.studentNames.length);
    assert(numStudents == data.studentEmails.length);

    // This is done in a transactional way
    return db.transaction(() async {
      // insert or update course
      final courseCompanion = CourseCompanion.insert(
        id: data.courseId,
        name: data.courseName,
      );
      await db.into(db.course).insertOnConflictUpdate(courseCompanion);

      // insert or update the course class
      final courseClassId = await db
          .into(db.courseClass)
          .insertOnConflictUpdate(
            CourseClassCompanion.insert(
              classCode: data.courseClassCode,
              courseId: data.courseId,
              semesterId: semester.id,
            ),
          );

      // update the class registration
      final studentEntities = <StudentCompanion>[];
      final registrationEntities = <RegistrationCompanion>[];
      for (int idx = 0; idx < numStudents; idx++) {
        final studentName = data.studentNames[idx];
        final studentId = data.studentIds[idx];
        final studentEmail = data.studentEmails[idx];

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
      await db.batch((batch) async {
        batch.insertAllOnConflictUpdate(db.student, studentEntities);
        batch.insertAllOnConflictUpdate(db.registration, registrationEntities);
      });

      return courseClassId;
    });
  }
}
