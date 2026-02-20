import 'package:drift/drift.dart';

import './database.dart';

extension SemesterDao on AppDatabase {
  /// Create a new semester, only requires [semesterName].
  /// Returns the newly created [SemesterData].
  Future<SemesterData> createSemester({required String semesterName}) async {
    final companion = SemesterCompanion.insert(name: semesterName);
    return await into(semester).insertReturning(companion);
  }

  /// Search for a semester using a search string or an ID
  Selectable<SemesterData> searchSemester({int? id, String? searchText}) {
    final stmt = select(semester);

    switch (id) {
      case int semesterId:
        stmt.where((s) => s.id.equals(semesterId));
    }

    switch (searchText) {
      case String text when text.trim().isNotEmpty:
        stmt.where((s) => s.name.contains(text));
    }

    return stmt;
  }
}
