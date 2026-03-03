import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database_service.dart';
import '../../../shared/dialogs.dart';
import 'providers.dart';

class PeriodTile extends ConsumerWidget {
  final int classId;
  final bool isStartPeriod;

  const PeriodTile({
    super.key,
    required this.classId,
    required this.isStartPeriod,
  });

  Text get title => Text(titleText);

  String get titleText => switch (isStartPeriod) {
    true => "Tiết bắt đầu",
    false => "Tiết kết thúc",
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final periodsAsync = ref.watch(courseClassPeriodsProvider(classId));
    switch (periodsAsync) {
      case AsyncLoading():
        return ListTile(
          title: title,
          subtitle: Text("Đang tải..."),
          trailing: CircularProgressIndicator(),
          enabled: false,
        );

      case AsyncError(:final error, :final stackTrace):
        if (kDebugMode) {
          print(stackTrace);
        }
        return ListTile(
          title: title,
          subtitle: Text("Lỗi: $error"),
          enabled: false,
        );

      case AsyncValue(value: final periods):
        print(periods);
        final (start, end) = periods ?? (null, null);
        final period = switch (isStartPeriod) {
          true => start,
          false => end,
        };

        final subtitleText = switch (period) {
          null => "Chưa có thông tin",
          PeriodData data => "Tiết ${data.id} (${data.humanize})",
        };

        return ListTile(
          title: title,
          subtitle: Text(subtitleText),
          onTap: () async {
            final newValue = await PeriodSelectionDialog.show(
              titleText: titleText,
            );

            final repo = await ref.read(
              courseClassRepositoryProvider.future,
            );

            if (isStartPeriod) {
              repo.updateClassPeriods(classId: classId, startPeriod: newValue);
            } else {
              repo.updateClassPeriods(classId: classId, endPeriod: newValue);
            }
          },
        );
    }
  }
}
