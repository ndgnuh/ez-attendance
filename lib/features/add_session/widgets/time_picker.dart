/// Manual time picker widget, in case one wants to pick the time manually
library;

import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

import '../../../core/database_service.dart' show PeriodDataHelper;
import '../ui_model.dart';

class TimePicker extends ConsumerWidget {
  final TimeOfDay initialValue;
  final ValueChanged<TimeOfDay> onChanged;
  final String labelText;
  final bool useStartTime;

  const TimePicker({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.labelText,
    required this.useStartTime,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final periodsAsync = ref.watch(periodsProvider);
    final initialValueFormat = initialValue.format(context);
    final title = Text(labelText);
    final subtitle = Text(initialValueFormat);

    void onLongPress() async {
      final picked = await showTimePicker(
        context: context,
        initialTime: initialValue,
      );
      if (picked == null) return;
      onChanged(picked);
    }

    switch (periodsAsync) {
      case AsyncLoading():
        return ListTile(
          leading: Icon(null),
          title: title,
          subtitle: subtitle,
          trailing: CircularProgressIndicator(),
          onTap: null,
          onLongPress: onLongPress,
        );

      case AsyncError(:final error, :final stackTrace):
        print(stackTrace);
        return ListTile(
          leading: Icon(null),
          title: title,
          subtitle: Text(error.toString()),
          trailing: CircularProgressIndicator(),
          onLongPress: onLongPress,
        );

      case AsyncValue(value: final periods):
        return ListTile(
          leading: Icon(null),
          title: title,
          subtitle: Text(initialValueFormat),
          trailing: Icon(Symbols.edit),
          onTap: () async {
            await showModalBottomSheet(
              context: context,
              useSafeArea: true,
              builder:
                  (context) => Padding(
                    padding: EdgeInsets.symmetric(vertical: context.gutter),
                    child: ListView.separated(
                      itemBuilder: (context, i) {
                        final period = periods[i];
                        final subtitleText = switch (useStartTime) {
                          true => "Bắt đầu: ${period.humanizeStartTime}",
                          false => "Kết thúc: ${period.humanizeEndTime}",
                        };
                        return ListTile(
                          title: Text("Tiết ${period.id}"),
                          subtitle: Text(subtitleText),
                          onTap: () {
                            Navigator.pop(context);
                            if (useStartTime) {
                              onChanged(period.startTime);
                            } else {
                              onChanged(period.endTime);
                            }
                          },
                        );
                      },
                      separatorBuilder: (context, _) => Divider(),
                      itemCount: periods!.length,
                    ),
                  ),
            );
          },
          onLongPress: onLongPress,
        );
    }
  }
}

/// Picker widget to pick the start of a session
class StartTimePicker extends StatelessWidget {
  const StartTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final initialValue = AddSessionModel.startTimeOf(context);
    final update = AddSessionModel.getUpdater(context);
    return TimePicker(
      initialValue: initialValue,
      onChanged: (TimeOfDay startTime) => update(startTime: startTime),
      labelText: "Bắt đầu",
      useStartTime: true,
    );
  }
}

/// Picker widget to pick the end of a session
class EndTimePicker extends StatelessWidget {
  const EndTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final initialValue = AddSessionModel.endTimeOf(context);
    final update = AddSessionModel.getUpdater(context);
    return TimePicker(
      initialValue: initialValue,
      onChanged: (TimeOfDay endTime) => update(endTime: endTime),
      labelText: "Kết thúc",
      useStartTime: false,
    );
  }
}
