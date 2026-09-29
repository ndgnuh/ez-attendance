import 'package:material_ui/material_ui.dart' show TimeOfDay;

import './database.dart';

extension _Zpad on int {
  String get zpad => toString().padLeft(2, '0');
}

extension PeriodDataHelper on PeriodData {
  TimeOfDay get startTime => TimeOfDay(hour: startHour, minute: startMinute);
  TimeOfDay get endTime => TimeOfDay(hour: endHour, minute: endMinute);

  String get humanizeStartTime => "${startHour.zpad}:${startMinute.zpad}";
  String get humanizeEndTime => "${endHour.zpad}:${endMinute.zpad}";
  String get humanize => "$humanizeStartTime - $humanizeEndTime";
}
