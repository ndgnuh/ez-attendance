/// Trivial database queries, enum like database items.
library;

import 'package:drift/drift.dart';
import 'package:riverpod/riverpod.dart';

import '../core/database_service.dart';

final commonRepositoryProvider = FutureProvider((ref) async {
  final db = await ref.watch(databaseProvider.future);
  return CommonDataRepository(db: db);
});

final periodListProvider = StreamProvider((ref) async* {
  final repo = await ref.watch(commonRepositoryProvider.future);
  yield* repo.watchPeriodList();
});

final semesterListProvider = StreamProvider((ref) async* {
  final repo = await ref.watch(commonRepositoryProvider.future);
  final stmt = repo.watchSemesterList();
  yield* stmt;
});

class CommonDataRepository {
  final AppDatabase db;

  CommonDataRepository({required this.db});

  /// Watch list of period
  Stream<List<PeriodData>> watchPeriodList() {
    final stmt = db.select(db.period);
    stmt.orderBy([(r) => OrderingTerm.asc(r.id)]);
    return stmt.watch();
  }

  /// List all the semesters in a descend order.
  Stream<List<SemesterData>> watchSemesterList() {
    final stmt = db.select(db.semester);
    stmt.orderBy([
      (semester) => OrderingTerm.desc(semester.name),
    ]);
    return stmt.watch();
  }
}
