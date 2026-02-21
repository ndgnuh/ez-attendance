import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database_service.dart';
import '../../../shared/utilities.dart';

/// Mode of imports
enum ImportMode {
  qldt,
  sohoa;

  /// Human readable label for the enum [ImportMode]
  String get label => switch (this) {
    qldt => "Quản lý đào tạo",
    sohoa => "Số hóa",
  };
}

/// View model for course class
class CourseClassViewModel {
  final CourseData course;
  final SemesterData semester;
  final CourseClassData courseClass;
  const CourseClassViewModel({
    required this.course,
    required this.semester,
    required this.courseClass,
  });

  static final provider = StreamProvider.family(
    (ref, int id) async* {
      final db = await ref.watch(databaseProvider.future);

      // Select statement
      final joins = [
        innerJoin(
          db.course,
          db.course.id.equalsExp(db.courseClass.courseId),
        ),
        innerJoin(
          db.semester,
          db.semester.id.equalsExp(db.courseClass.semesterId),
        ),
      ];
      final stmt = db.select(db.courseClass).join(joins);
      stmt.where(db.courseClass.id.equals(id));

      final mapped = stmt.map((result) {
        final course = result.readTable(db.course);
        final semester = result.readTable(db.semester);
        final courseClass = result.readTable(db.courseClass);
        return CourseClassViewModel(
          course: course,
          semester: semester,
          courseClass: courseClass,
        );
      });

      /// Yield results
      await for (final result in mapped.watchSingle()) {
        yield result;
      }
    },
  );
}

/// Data model for course class
class ImportData {
  final String courseClassCode;
  final String courseId;
  final String courseName;
  final List<String> studentIds;
  final List<String> studentNames;
  late final List<String> studentEmails;

  ImportData({
    required this.courseClassCode,
    required this.courseId,
    required this.courseName,
    required this.studentIds,
    required this.studentNames,
    List<String>? studentEmails,
  }) : studentEmails =
           studentEmails ??
           autoStudentEmails(
             studentNames: studentNames,
             studentIds: studentIds,
           );
}
