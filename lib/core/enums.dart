/// Contains data models for the app.
/// Export [AttendanceStatus] and [NamedFile].
/// TODO: rename this file to models.dart
library;

import 'dart:typed_data';

enum DayOfWeek implements Comparable<DayOfWeek> {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  /// Natural order based on the enum declaration (0 to 6)
  @override
  int compareTo(DayOfWeek other) => index.compareTo(other.index);

  /// Returns the enum value from an integer index (0-6).
  /// Falls back to monday if the index is out of bounds.
  factory DayOfWeek.fromInt(int index) {
    if (index < 0 || index >= DayOfWeek.values.length) {
      throw "Invalid day of week";
    }
    return DayOfWeek.values[index];
  }

  String get fullName {
    switch (this) {
      case DayOfWeek.monday:
        return 'Thứ Hai';
      case DayOfWeek.tuesday:
        return 'Thứ Ba';
      case DayOfWeek.wednesday:
        return 'Thứ Tư';
      case DayOfWeek.thursday:
        return 'Thứ Năm';
      case DayOfWeek.friday:
        return 'Thứ Sáu';
      case DayOfWeek.saturday:
        return 'Thứ Bảy';
      case DayOfWeek.sunday:
        return 'Chủ Nhật';
    }
  }

  String get shortName {
    switch (this) {
      case DayOfWeek.monday:
        return 'T2';
      case DayOfWeek.tuesday:
        return 'T3';
      case DayOfWeek.wednesday:
        return 'T4';
      case DayOfWeek.thursday:
        return 'T5';
      case DayOfWeek.friday:
        return 'T6';
      case DayOfWeek.saturday:
        return 'T7';
      case DayOfWeek.sunday:
        return 'CN';
    }
  }
}

enum AttendanceStatus {
  unknown('00-unknown', 'Không rõ'),
  present('01-present', 'Có mặt'),
  absent('02-absent', 'Vắng'),
  late('03-late', 'Đi muộn'),
  excused('04-excused', 'Nghỉ phép');

  final String value;
  final String label;
  const AttendanceStatus(this.value, this.label);
}

class NamedFile {
  final String? extension;
  final String name;
  final Uint8List bytes;

  String get path => switch (extension) {
    null => name,
    String ext => "$name.$ext",
  };

  const NamedFile({required this.name, required this.bytes, this.extension});
}
