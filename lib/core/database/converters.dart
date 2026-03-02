import 'package:drift/drift.dart';
import '../enums.dart';

class DayOfWeekConverter extends TypeConverter<DayOfWeek, int> {
  static const instance = DayOfWeekConverter();
  const DayOfWeekConverter();
  @override
  DayOfWeek fromSql(int fromDb) => DayOfWeek.fromInt(fromDb);

  @override
  int toSql(DayOfWeek value) => value.index;
}

class AttendanceConverter extends TypeConverter<AttendanceStatus, String> {
  static const instance = AttendanceConverter();
  const AttendanceConverter();

  @override
  AttendanceStatus fromSql(String fromDb) {
    return AttendanceStatus.values.firstWhere(
      (e) => e.value == fromDb,
      orElse: () => AttendanceStatus.unknown,
    );
  }

  @override
  String toSql(AttendanceStatus status) => status.value;
}
