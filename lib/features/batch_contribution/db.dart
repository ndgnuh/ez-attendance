import 'package:drift/drift.dart' show BooleanExpressionOperators;

import '../../core/database/database.dart';

enum ContributionUpdateModes {
  setToValue(label: "Đặt bằng giá trị"),
  addToValue(label: "Cộng thêm vào");

  final String label;

  const ContributionUpdateModes({required this.label});

  @override
  toString() => label;
}

sealed class ContributionUpdateMode {
  const ContributionUpdateMode();
  AttendanceData apply(AttendanceData data);

  /// Set the number of contributions to [value]. The default number
  /// of contributions is [1].
  factory ContributionUpdateMode.setToValue([int value = 1]) =>
      _SetToValue(value: value);

  /// Increase the number of contributions by [value].
  /// The default addition is [1].
  factory ContributionUpdateMode.addValue([int value = 1]) =>
      _AddValue(value: value);
}

class _SetToValue extends ContributionUpdateMode {
  final int value;

  const _SetToValue({this.value = 1});

  @override
  AttendanceData apply(AttendanceData data) {
    return data.copyWith(numContributions: value);
  }
}

class _AddValue extends ContributionUpdateMode {
  final int value;

  const _AddValue({this.value = 1});

  @override
  AttendanceData apply(AttendanceData data) {
    return data.copyWith(numContributions: value + data.numContributions);
  }
}

/// Process contributions in batch.
Future<void> batchAddContribution({
  required final AppDatabase db,
  required final int sessionId,
  required final List<String> studentIds,
  required final ContributionUpdateMode mode,
}) async {
  /// Get attendance data
  final attendanceData = await db.transaction(() async {
    final stmt = db.select(db.attendance);
    stmt.where(
      (r) => r.sessionId.equals(sessionId) & r.studentId.isIn(studentIds),
    );
    return stmt.get();
  });
  assert(attendanceData.length == studentIds.length);

  /// Update corresponding row with some mode
  await db.transaction(() async {
    for (final attendanceDatum in attendanceData) {
      final stmt = db.update(db.attendance);
      stmt.where(
        (row) =>
            row.sessionId.equals(sessionId) // Formatting comment
            &
            row.studentId.equals(attendanceDatum.studentId),
      );
      final updated = mode.apply(attendanceDatum);
      await stmt.write(updated);
    }
  });
}
