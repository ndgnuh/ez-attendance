import 'package:drift/drift.dart';
import 'package:riverpod/riverpod.dart';

import '../../../core/database_service.dart';
import '../../../core/enums.dart';
import 'models.dart';

/// Service for managing course classes
class CourseClassManagementService {
  static final provider = FutureProvider((ref) async {
    final db = await ref.watch(databaseProvider.future);
    return CourseClassManagementService(db: db);
  });

  final AppDatabase db;

  CourseClassManagementService({required this.db});

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

/// Experimental class that hides all the query from riverpod.
class CourseClassRepository {
  final AppDatabase db;
  const CourseClassRepository({required this.db});

  /// List of course class ID by semester
  Stream<List<int>> watchClassIdsBySemester({required int semesterId}) {
    final stmt = db.select(db.courseClass);
    stmt.where((r) => r.semesterId.equals(semesterId));
    final mapped = stmt.map((r) => r.id);
    return mapped.watch();
  }

  Future<void> updateClassLocation({
    required int courseClassId,
    required String newLocation,
  }) async {
    final companion = CourseClassCompanion(location: Value(newLocation));
    final stmt = db.update(db.courseClass);
    stmt.where((c) => c.id.equals(courseClassId));
    stmt.write(companion);
  }

  Future<void> updateClassSchedule({
    required int courseClassId,
    DayOfWeek? dayOfWeek,
  }) async {
    final companion = CourseClassCompanion(dayOfWeek: Value(dayOfWeek));
    final stmt = db.update(db.courseClass);
    stmt.where((c) => c.id.equals(courseClassId));
    stmt.write(companion);
  }

  /// Watch the day of week of a course class
  Stream<DayOfWeek?> watchClassDayOfWeek(int courseClassId) {
    final stmt = db.selectOnly(db.courseClass);
    stmt.addColumns({db.courseClass.dayOfWeek});
    stmt.where(db.courseClass.id.equals(courseClassId));
    final mapped = stmt.map(
      (r) => r.readWithConverter(db.courseClass.dayOfWeek),
    );
    return mapped.watchSingleOrNull();
  }

  /// Watch the location of a course class
  Stream<String?> watchClassLocation(int courseClassId) => _watchClassInfoStmt(
    courseClassId: courseClassId,
    column: db.courseClass.location,
    mapper: (r) => r.read(db.courseClass.location),
  );

  /// Get all course classes by semester
  Stream<List<CourseClassData>> watchCourseClassData({SemesterData? semester}) {
    final stmt = db.select(db.courseClass);

    /// Optional: filter by semester
    switch (semester) {
      case SemesterData semester:
        stmt.where((r) => r.semesterId.equals(semester.id));
    }

    stmt.orderBy([
      (r) => OrderingTerm.desc(r.semesterId),
      (r) => OrderingTerm(expression: r.dayOfWeek),
      (r) => OrderingTerm(expression: r.fromPeriod),
    ]);
    return stmt.watch();
  }

  Stream<T?> _watchClassInfoStmt<T extends Object>({
    required int courseClassId,
    required Expression<T> column,
    required T? Function(TypedResult) mapper,
  }) {
    final stmt = db.selectOnly(db.courseClass);
    stmt.addColumns({column});
    stmt.where(db.courseClass.id.equals(courseClassId));
    return stmt.map(mapper).watchSingleOrNull();
  }

  /// Period data of a class
  Stream<(PeriodData?, PeriodData?)?> watchClassPeriods(
    int courseClassId,
  ) {
    // table aliases
    final startP = db.alias(db.period, "start_period");
    final endP = db.alias(db.period, "end_period");

    // Join and filter
    final stmt = db.select(db.courseClass).join([
      leftOuterJoin(startP, startP.id.equalsExp(db.courseClass.fromPeriod)),
      leftOuterJoin(endP, endP.id.equalsExp(db.courseClass.toPeriod)),
    ]);
    stmt.where(db.courseClass.id.equals(courseClassId));

    // Map to return type
    final mapped = stmt.map((r) {
      final startPeriod = r.readTableOrNull(startP);
      final endPeriod = r.readTableOrNull(endP);
      return (startPeriod, endPeriod);
    });

    return mapped.watchSingleOrNull();
  }

  Future<void> updateClassPeriods({
    required final int classId,
    final PeriodData? startPeriod,
    final PeriodData? endPeriod,
  }) async {
    assert(startPeriod != null || endPeriod != null);
    final stmt = db.update(db.courseClass);
    stmt.where((r) => r.id.equals(classId));
    if (startPeriod != null) {
      stmt.write(CourseClassCompanion(fromPeriod: Value(startPeriod.id)));
    } else if (endPeriod != null) {
      stmt.write(CourseClassCompanion(toPeriod: Value(endPeriod.id)));
    }
  }
}
