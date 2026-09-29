/// Manual time picker widget, in case one wants to pick the time manually
library;

import 'package:material_ui/material_ui.dart';

import '../ui_model.dart';

class TimePicker extends StatelessWidget {
  final TimeOfDay initialValue;
  final ValueChanged<TimeOfDay> onChanged;
  final String labelText;

  const TimePicker({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue.format(context),
      decoration: InputDecoration(
        labelText: labelText,
      ),
      onTap: () async {
        final picked = await showTimePicker(
          context: context,
          initialTime: initialValue,
        );

        if (picked == null) return;
        onChanged(picked);
      },
    );
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
      labelText: "Thời gian bắt đầu",
    );
  }
}

/// Picker widget to pick the end of a session
class EndTimePicker extends StatelessWidget {
  const EndTimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final initialValue = AddSessionModel.startTimeOf(context);
    final update = AddSessionModel.getUpdater(context);
    return TimePicker(
      initialValue: initialValue,
      onChanged: (TimeOfDay startTime) => update(startTime: startTime),
      labelText: "Thời gian kết thúc",
    );
  }
}
