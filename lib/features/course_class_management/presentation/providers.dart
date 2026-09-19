import 'package:material_ui/material_ui.dart';
import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/database_service.dart';
import '../domain/dao.dart';
import '../domain/models.dart';

final courseClassRepositoryProvider = FutureProvider((ref) async {
  final db = await ref.watch(databaseProvider.future);
  return CourseClassRepository(db: db);
});

/// Provides the course classes of selected semester
final courseClassesProvider = StreamProvider((ref) async* {
  final repo = await ref.watch(courseClassRepositoryProvider.future);
  final semester = ref.watch(SemesterNotifier.provider);
  yield* repo.watchCourseClassData(semester: semester);
});

final courseClassPeriodsProvider = StreamProvider.family(
  (ref, int classId) async* {
    final repo = await ref.watch(courseClassRepositoryProvider.future);
    yield* repo.watchClassPeriods(classId);
  },
);

class SemesterNotifier extends Notifier<SemesterData?> {
  static final provider = NotifierProvider(
    () => SemesterNotifier(name: "default"),
  );
  static final providerForImportPage = NotifierProvider(SemesterNotifier.new);
  static final instance = provider.notifier;
  static final instanceForImportPage = providerForImportPage.notifier;

  final String? name;

  SemesterNotifier({this.name});

  String? get key => switch (name) {
    null => null,
    String name => "input.semester-notifier-$name",
  };

  @override
  SemesterData? build() {
    switch (key) {
      case String key:
        _loadStoredSemester(key);
    }
    return null;
  }

  void _loadStoredSemester(String key) async {
    await Future.delayed(Duration(milliseconds: 30));
    final pref = await SharedPreferences.getInstance();
    final semesterId = pref.getInt(key);
    final db = await ref.read(databaseProvider.future);
    if (semesterId == null) {
      print("No semester ID, bailing");
      return;
    }
    state = await db.searchSemester(id: semesterId).getSingle();
  }

  void _storeSemester(String key, int? value) async {
    final pref = await SharedPreferences.getInstance();
    print("Set ($key) to ($value)");
    if (value == null) {
      pref.remove(key);
    } else {
      pref.setInt(key, value);
    }
  }

  void clear() {
    state = null;
    switch (key) {
      case String key:
        _storeSemester(key, null);
    }
  }

  void set(SemesterData semester) {
    state = semester;
    switch (key) {
      case String key:
        _storeSemester(key, semester.id);
    }
  }

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
