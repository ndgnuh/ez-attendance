import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';

import '../ui_model.dart';

/// Pick the day the class starts
class DayPicker extends StatelessWidget {
  const DayPicker({super.key});

  @override
  Widget build(BuildContext context) {
    final updater = AddSessionModel.getUpdater(context);
    final day = AddSessionModel.dayOf(context);
    final dayFormatted = DateFormat("EEEE, dd/MM/yyyy").format(day);

    return ListTile(
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
      leading: Icon(Symbols.event),
      title: Text("Ngày học"),
      subtitle: Text(dayFormatted),
      trailing: Icon(Symbols.edit),
    );
  }
}
