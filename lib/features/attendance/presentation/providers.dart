import 'dart:async';
import 'dart:math' as math;

import 'package:checkin_tool/core/preference_service.dart';
import 'package:drift/drift.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/riverpod.dart';

import '../../student_search/student_search.dart' show searchStudents;
import '../domain/dao.dart';
import '../domain/data_model.dart';

final searchTextController = TextEditingController();
final searchTextProvider = Provider((ref) {
  searchTextController.addListener(() => ref.invalidateSelf());
  return searchTextController.text;
});

/// Provide the students and attendance status in an attendance session,
/// filtered by the "smart search" using [searchTextProvider].
/// All students are provided when the search query is empty.
final filteredStudentsProvider = StreamProvider.family(
  (ref, int sessionId) async* {
    final db = await ref.watch(databaseProvider.future);
    final searchText = ref.watch(searchTextProvider);
    final stmt = db.getAttendanceList(sessionId: sessionId, searchText: '');

    if (searchText.isEmpty) {
      yield* stmt.watch();
      return;
    }

    await for (final result in stmt.watch()) {
      final matches =
          await searchStudents(
            db: db,
            searchQuery: searchText,
          ).get();
      final ids = matches.map((student) => student.id).toSet();
      yield result.where((row) => ids.contains(row.$1.id)).toList();
    }
  },
);

final scanningBackgroundColorProvider = Provider((ref) {
  final isScanning = ref.watch(IsScanningNotifier.provider);
  if (!isScanning) return null;

  final mode = ref.watch(ScanModeNotifier.provider);
  return switch (mode) {
    ScanningMode.markAttend => Colors.green,
    ScanningMode.markLate => Colors.red,
    ScanningMode.markContributed => Colors.blue,
  };
});

/// Get all attendance sessions of a [courseClassId]
final attendanceSessionListProvider = StreamProvider.family(
  (ref, int courseClassId) async* {
    final db = await ref.watch(databaseProvider.future);
    final stmt = db.select(db.session);
    stmt.where((row) => row.courseClassId.equals(courseClassId));
    stmt.orderBy([
      (row) => OrderingTerm.asc(row.courseClassId),
      (row) => OrderingTerm.desc(row.startTime),
    ]);

    await for (final sessions in stmt.watch()) {
      yield sessions;
    }
  },
);

/// Scanning or manually checking mode
class IsScanningNotifier extends Notifier<bool> {
  @override
  bool build() {
    PreferenceService().getDefaultScanMode().then((value) {
      state = value;
    });
    return false;
  }

  void set(bool value) {
    PreferenceService().setDefaultScanMode(value);
    state = value;
  }

  static final provider = NotifierProvider(IsScanningNotifier.new);
  static final instance = provider.notifier;
}

class ScanModeNotifier extends Notifier<ScanningMode> {
  @override
  ScanningMode build() {
    return ScanningMode.markAttend;
  }

  void set(ScanningMode value) => state = value;

  static final provider = NotifierProvider(ScanModeNotifier.new);
  static final instance = provider.notifier;
}

class ScanMessageNotifier extends Notifier<String> {
  final TextEditingController controller = TextEditingController();
  @override
  String build() => "";
  void set(String value) {
    state = value;
    controller.text = value;
  }

  static final provider = NotifierProvider(ScanMessageNotifier.new);
  static final instance = provider.notifier;
}

class AttandanceUpdateLogic {
  final Ref ref;
  final AttendanceData attendance;
  const AttandanceUpdateLogic(this.ref, this.attendance);

  static final provider = Provider.family(AttandanceUpdateLogic.new);

  Future<void> updateStatus(AttendanceStatus status) async {
    final db = await ref.read(databaseProvider.future);
    await db.updateAttendanceStatus(
      sessionId: attendance.sessionId,
      studentId: attendance.studentId,
      status: status,
    );
  }

  Future<void> changeScore(int delta) async {
    final db = await ref.read(databaseProvider.future);
    final newValue = math.max(0, attendance.numContributions + delta);
    await db.updateAttendanceStatus(
      sessionId: attendance.sessionId,
      studentId: attendance.studentId,
      status: AttendanceStatus.present,
      numContributions: newValue,
    );
  }
}
