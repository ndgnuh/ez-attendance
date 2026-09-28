import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../ui_model.dart';

/// Pick the day the class starts
class DayPicker extends StatefulWidget {
  const DayPicker({super.key});

  @override
  State<DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final day = AddSessionModel.dayOf(context);
    final updater = AddSessionModel.getUpdater(context);
    controller.text = DateFormat("dd/mm/YYYY").format(day);
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: "Ngày học",
      ),
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          firstDate: DateTime(1970, 1, 1),
          lastDate: DateTime(9999),
        );
        if (picked == null) return;
        updater(day: day);
      },
    );
  }
}
