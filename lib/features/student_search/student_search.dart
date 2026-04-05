import 'package:checkin_tool/core/notifiers.dart';
import 'package:drift/drift.dart';
import 'package:riverpod/riverpod.dart';

import '../../core/database_service.dart';

final searchTextProvider = NotifierProvider(StringNotifier.new);

final searchResultsProvider = StreamProvider<List<StudentSearchResult>?>((
  ref,
) async* {
  final db = await ref.watch(databaseProvider.future);
  final searchText = ref.watch(searchTextProvider);
  if (searchText == null) {
    final stream = Stream.value(null);
    yield* stream;
  } else {
    final result = db.searchStudentReactive(searchText: searchText);
    yield* result;
  }
});

typedef StudentSearchResult =
    ({
      StudentData studentData,
      CourseClassData courseClassData,
      SemesterData semesterData,
    });

extension StudentSearch on AppDatabase {
  /// Search for student matches search text
  /// Returns the future of result.
  Future<List<StudentSearchResult>> searchStudent({
    required String searchText,
  }) {
    final stmt = _searchStudentStmt(searchText);
    return stmt.get();
  }

  /// Search for student matches search text
  /// Watch the results and return stream of results
  Stream<List<StudentSearchResult>> searchStudentReactive({
    required String searchText,
  }) async* {
    final stmt = _searchStudentStmt(searchText);
    yield* stmt.watch();
  }

  Selectable<StudentSearchResult> _searchStudentStmt(
    final String searchKey,
  ) {
    final stmt = select(student);
    stmt.where(
      (r) => student.id.contains(searchKey) | student.name.contains(searchKey),
    );

    final joined = stmt.join([
      innerJoin(
        registration,
        registration.studentId.equalsExp(student.id),
      ),
      innerJoin(
        courseClass,
        courseClass.id.equalsExp(registration.courseClassId),
      ),
      innerJoin(
        semester,
        semester.id.equalsExp(courseClass.semesterId),
      ),
    ]);

    joined.orderBy(
      [
        OrderingTerm.desc(semester.id),
        OrderingTerm.asc(courseClass.id),
      ],
    );

    final mapped = joined.map((row) {
      final studentData = row.readTable(student);
      final courseClassData = row.readTable(courseClass);
      final semesterData = row.readTable(semester);
      return (
        studentData: studentData,
        semesterData: semesterData,
        courseClassData: courseClassData,
      );
    });

    return mapped;
  }
}
