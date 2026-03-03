import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/database_service.dart';
import '../../../shared/repository.dart';
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
            final newValue = await showDialog(
              context: context,
              builder:
                  (context) => _PeriodSelectionDialog(titleText: titleText),
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

class _PeriodSelectionDialog extends ConsumerWidget {
  final String titleText;

  const _PeriodSelectionDialog({required this.titleText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final periodsAsync = ref.watch(periodListProvider);

    return SimpleDialog(
      title: Text(titleText),
      children: buildChildren(context, periodsAsync),
    );
  }

  List<Widget> buildChildren(
    BuildContext context,
    AsyncValue<List<PeriodData>> periodsAsync,
  ) {
    final navigator = Navigator.of(context);
    switch (periodsAsync) {
      case AsyncLoading():
        return [CircularProgressIndicator()];

      case AsyncError(:final error, :final stackTrace):
        print(stackTrace);
        return [Text(error.toString())];

      case AsyncData(value: final periods):
        return [
          for (final period in periods)
            ListTile(
              title: Text("Tiết ${period.id}"),
              subtitle: Text(
                "${period.startTime.format(context)} - ${period.endTime.format(context)}",
              ),
              onTap: () => navigator.pop(period),
            ),
        ];
    }
  }
}
