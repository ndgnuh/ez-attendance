import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';

import '../../../core/database_service.dart';
import '../domain/dao.dart';
import '../domain/models.dart';

final courseClassRepositoryProvider = FutureProvider((ref) async {
  final db = await ref.watch(databaseProvider.future);
  return CourseClassRepository(db: db);
});

final periodListProvider = StreamProvider((ref) async* {
  final repo = await ref.watch(courseClassRepositoryProvider.future);
  yield* repo.watchPeriodList();
});

/// Provides all the semesters
final allSemesterProviders = StreamProvider((ref) async* {
  final sv = await _initService(ref);
  final stmt = sv.listSemesters();
  yield* stmt.watch();
});

/// Provides the course classes of selected semester
final courseClassesProvider = StreamProvider((ref) async* {
  final repo = await ref.watch(courseClassRepositoryProvider.future);
  final semester = ref.watch(SemesterNotifier.provider);
  yield* repo.watchCourseClassData(semester: semester);
});

/// Shorthand to not having to type out the below
Future<CourseClassManagementService> _initService(Ref ref) async {
  final sv = await ref.watch(CourseClassManagementService.provider.future);
  return sv;
}

class SemesterNotifier extends Notifier<SemesterData?> {
  static final provider = NotifierProvider(SemesterNotifier.new);
  static final providerForImportPage = NotifierProvider(SemesterNotifier.new);
  static final instance = provider.notifier;
  static final instanceForImportPage = providerForImportPage.notifier;
  @override
  SemesterData? build() => null;

  void clear() => state = null;
  void set(SemesterData semester) => state = semester;

  /// Watch the notifier to change state
  void watch(ValueNotifier<SemesterData?> notifier) {
    notifier.addListener(() {
      state = notifier.value;
    });
  }
}

class ImportDataNotifier extends Notifier<ImportData?> {
  @override
  ImportData? build() => null;
  void set(ImportData data) => state = data;
  void clear() => state = null;

  static final provider = NotifierProvider(ImportDataNotifier.new);
  static final instance = provider.notifier;
}
