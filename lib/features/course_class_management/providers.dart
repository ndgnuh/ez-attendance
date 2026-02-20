import 'package:drift/drift.dart';
import 'package:riverpod/riverpod.dart';

import '../../core/database_service.dart';
import './data_model.dart';

final allSemesterProviders = StreamProvider((ref) async* {
  final db = await ref.watch(databaseProvider.future);
  final stmt = db.select(db.semester);

  stmt.orderBy([
    (semester) => OrderingTerm(expression: semester.name),
  ]);

  await for (final semesterList in stmt.watch()) {
    yield semesterList;
  }
});

final courseClassesProvider = StreamProvider((ref) async* {
  final db = await ref.watch(databaseProvider.future);
  final semester = ref.watch(SemesterNotifier.provider);
  final stmt = db.getCourseClasses(semester: semester);
  await for (final courseClassList in stmt.watch()) {
    yield courseClassList;
  }
});

class SemesterNotifier extends Notifier<SemesterData?> {
  static final provider = NotifierProvider(SemesterNotifier.new);
  static final instance = provider.notifier;
  @override
  SemesterData? build() => null;

  void clear() => state = null;
  void set(SemesterData semester) => state = semester;
}
