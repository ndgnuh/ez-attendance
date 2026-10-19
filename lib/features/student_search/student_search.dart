// Originally, this is the page for searching student
// across course classes. However, I'll repurpose
// it to be all the student searching related operation.
//
// The purpose is to have fancy stuff, like searching multiple
// student at once.
library;

import 'package:drift/drift.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/riverpod.dart';

import '../../core/database_service.dart';
import '../../core/notifiers.dart';

extension _StringHelper on String {
  static final numeric = RegExp(r"^[0-9 \n]+$");
  static final spaces = RegExp(r"[\r\n\s]");

  bool get hasOnlyNumberAndSpace => numeric.hasMatch(this);
  bool get hasNoSpace => !spaces.hasMatch(trim());
}

/// Search for student in a "smart" way.
///
/// If the query has multiple parts and all the parts are spaces,
/// Each part is considered as a student ID, and the student will match iside that ID list.
///
/// Otherwise, consider the whole text as a filter,
/// standard string matching stuff.
Selectable<StudentData> searchStudents({
  required final AppDatabase db,
  required final String searchQuery,
}) {
  final stmt = db.select(db.student);

  /// Check which mode should we
  late final bool multiStudentMode;
  if (searchQuery.hasNoSpace) {
    multiStudentMode = false;
  } else {
    multiStudentMode = searchQuery.hasOnlyNumberAndSpace;
  }

  /// Filter based on the mode
  if (multiStudentMode) {
    final students = searchQuery.trim().split(_StringHelper.spaces);
    stmt.where((r) => r.id.isIn(students));
  } else {
    stmt.where(
      (r) =>
          r.id.contains(searchQuery) |
          r.name.contains(searchQuery) |
          r.email.contains(searchQuery),
    );
  }

  /// Return the query
  return stmt;
}

class StudentSearchResultConsumer extends StatelessWidget {
  final String searchQuery;
  final Widget Function(BuildContext context, List<StudentData> students)
  builder;

  const StudentSearchResultConsumer({
    super.key,
    required this.searchQuery,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

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

final searchTextProvider = NotifierProvider(StringNotifier.new);

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
