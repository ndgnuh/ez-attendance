/// Provides database, data getters etc.
library;

import '../core/database_service.dart';
import 'providers/database.dart';
import 'package:riverpod/riverpod.dart';
import '../../core/database/database.dart';
import 'package:drift/drift.dart';

export 'providers/database.dart';
export 'providers/courses.dart';
export 'providers/local_preferences.dart';

final courseClassProvider = AsyncNotifierProvider.family(
  CourseClassNotifier.new,
);

final courseProvider = AsyncNotifierProvider.family(
  CourseNotifier.new,
);

final semesterProvider = AsyncNotifierProvider.family(
  SemesterNotifier.new,
);

final courseClassIdsProvider = FutureProvider(
  (ref) async {
    final db = await ref.watch(databaseProvider.future);
    final stmt = db.courseClass.select();
    return await stmt.map((e) => e.id).get();
  },
);

class CourseClassNotifier extends AsyncNotifier<CourseClassData> {
  int courseClassId;

  CourseClassNotifier(this.courseClassId);

  @override
  Future<CourseClassData> build() async {
    final db = await ref.watch(databaseProvider.future);
    final stmt = db.courseClass.select();
    stmt.where((tbl) => tbl.id.equals(courseClassId));
    final courseClass = await stmt.getSingleOrNull();
    assert(courseClass != null, 'CourseClass with id $courseClassId not found');
    return courseClass!;
  }
}

class CourseNotifier extends AsyncNotifier<CourseData> {
  String courseId;

  CourseNotifier(this.courseId);

  @override
  Future<CourseData> build() async {
    final db = await ref.watch(databaseProvider.future);
    final stmt = db.searchCourse(id: courseId);
    final course = await stmt.getSingleOrNull();
    assert(course != null, 'Course with id $courseId not found');
    return course!;
  }
}

class SemesterNotifier extends AsyncNotifier<SemesterData> {
  int semesterId;

  SemesterNotifier(this.semesterId);

  @override
  Future<SemesterData> build() async {
    final db = await ref.watch(databaseProvider.future);
    final stmt = db.searchSemester(id: semesterId);
    final semester = await stmt.getSingleOrNull();
    assert(semester != null, 'Semester with id $semesterId not found');
    return semester!;
  }
}

final creationProvider = NotifierProvider(CreationNotifier.new);

class CreationNotifier extends Notifier<void> {
  @override
  void build() {}

  Future<SemesterData> insertSemester(String semesterName) async {
    final db = await ref.read(databaseProvider.future);
    final semesterCompanion = SemesterCompanion.insert(name: semesterName);
    return db.semester.insertReturning(
      semesterCompanion,
      onConflict: DoUpdate(
        (old) => SemesterCompanion(name: semesterCompanion.name),
      ),
    );
  }

  Future<CourseData> insertCourse({
    required String courseId,
    required String courseName,
  }) async {
    final db = await ref.read(databaseProvider.future);
    final courseCompanion = CourseCompanion.insert(
      id: courseId,
      name: courseName,
    );
    await db.course.insertOnConflictUpdate(courseCompanion);

    final stmt = db.searchCourse(id: courseId);
    final course = await stmt.getSingle();
    return course;
  }

  Future<CourseClassData> insertCourseClass({
    required SemesterData semester,
    required CourseData course,
    required String classCode,
  }) async {
    final db = await ref.read(databaseProvider.future);
    return db.courseClass.insertReturning(
      CourseClassCompanion.insert(
        semesterId: semester.id,
        courseId: course.id,
        classCode: classCode,
      ),
    );
  }
}
