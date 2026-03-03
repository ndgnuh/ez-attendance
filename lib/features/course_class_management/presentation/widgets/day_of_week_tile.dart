import 'package:checkin_tool/core/enums.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../shared/dialogs.dart';
import '../providers.dart';

/// Day of week provider
final _dowProvider = StreamProvider.family(
  (ref, int courseClassId) async* {
    final repo = await ref.watch(courseClassRepositoryProvider.future);
    yield* repo.watchClassDayOfWeek(courseClassId);
  },
);

/// Show and edit the class room (location) of a class
class DayOfWeekTile extends ConsumerWidget {
  static const titleText = "Ngày học";
  static const title = Text(titleText);
  final int courseClassId;

  const DayOfWeekTile({super.key, required this.courseClassId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = _dowProvider(courseClassId);
    final infoAsync = ref.watch(provider);
    switch (infoAsync) {
      case AsyncLoading():
        return ListTile(
          title: title,
          enabled: false,
          trailing: CircularProgressIndicator(),
        );
      case AsyncError(:final error, :final stackTrace):
        if (kDebugMode) {
          print(stackTrace);
        }
        return ListTile(
          title: title,
          subtitle: Text(error.toString()),
          trailing: Icon(Symbols.error),
          enabled: false,
        );
      case AsyncData(:final value):
        return ListTile(
          title: title,
          subtitle: Text(value?.fullName ?? "Chưa có thông tin"),
          onTap: () async {
            final newValue = await showSelectionDialog(
              title: titleText,
              values: DayOfWeek.values,
              optionBuilder: (value) {
                return Text(value.fullName);
              },
            );
            if (null == newValue) return;
            final repo = await ref.read(courseClassRepositoryProvider.future);
            await repo.updateClassSchedule(
              courseClassId: courseClassId,
              dayOfWeek: newValue,
            );
          },
        );
    }
  }
}
