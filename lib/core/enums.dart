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
