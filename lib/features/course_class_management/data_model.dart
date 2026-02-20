import 'package:drift/drift.dart';

import '../../core/database_service.dart';

extension CourseClassManagementDao on AppDatabase {
  Selectable<CourseClassData> getCourseClasses({
    int? courseClassId,
    String? courseClassCode,
    SemesterData? semester,
  }) {
    final stmt = select(courseClass);

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

  Future<int> deleteCourseClass(int courseClassId) async {
    final stmt = delete(courseClass)
      ..where((row) => row.id.equals(courseClassId));
    return await stmt.go();
  }
}
