import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../ui_model.dart';

/// Pick the day the class starts
class DayPicker extends StatelessWidget {
  const DayPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final updater = AddSessionModel.getUpdater(context);
    final day = AddSessionModel.dayOf(context);
    final initText = DateFormat("EEEE, dd/MM/yyyy").format(day);
    print("Init text: $initText");

    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: day,
          firstDate: DateTime(1970, 1, 1),
          lastDate: DateTime(9999),
        );
        if (picked == null) return;
        updater(day: picked);
      },
      child: InputDecorator(
        decoration: const InputDecoration(
          labelText: "Ngày học",
        ),
        child: Text(initText),
      ),
    );
  }
}
