/// Contains data models for the app.
/// Export [AttendanceStatus] and [NamedFile].
/// TODO: rename this file to models.dart
library;

import 'dart:typed_data';

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
