export './../../../core/enums.dart';

enum ScanningMode {
  markAttend,
  markLate,
  markContributed;

  String get label => switch (this) {
    markAttend => "Điểm danh",
    markLate => "Điểm danh (đi muộn)",
    markContributed => "Cộng điểm đóng góp",
  };
}

final _studentIdPattern = RegExp(r"(20\d{6,7})");
String? matchStudentId(String scanned) {
  final match = _studentIdPattern.firstMatch(scanned);
  if (match == null) return null;
  return match.group(0)!;
}
