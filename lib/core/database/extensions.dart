import 'package:flutter/material.dart' show TimeOfDay;

import './database.dart';

extension PeriodDataHelper on PeriodData {
  TimeOfDay get startTime => TimeOfDay(hour: startHour, minute: startMinute);
  TimeOfDay get endTime => TimeOfDay(hour: endHour, minute: endMinute);

  String get humanizeStartTime => "$startHour:$startMinute";
  String get humanizeEndTime => "$endHour:$endMinute";
  String get humanize => "$humanizeStartTime - $humanizeEndTime";
}
