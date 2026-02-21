import 'dart:typed_data';

import 'package:excel/excel.dart';

import 'models.dart';

const _columns = (
  studentId: 1,
  studentName: 2,
);

final _rowOffset = 6;

final _indices = (
  courseName: CellIndex.indexByString("B2"),
  courseId: CellIndex.indexByString("E2"),
  courseClassCode: CellIndex.indexByString("B4"),
);

ImportData importFromSohoa({required Uint8List bytes}) {
  final excel = Excel.decodeBytes(bytes);
  final sheet = excel[excel.getDefaultSheet() as String];
  return ImportData(
    studentIds: _fetchColumn(sheet, _columns.studentId).toList(),
    studentNames: _fetchColumn(sheet, _columns.studentName).toList(),
    courseClassCode: sheet.cell(_indices.courseClassCode).value.toString(),
    courseId: sheet.cell(_indices.courseId).value.toString(),
    courseName: sheet.cell(_indices.courseName).value.toString(),
  );
}

Iterable<String> _fetchColumn(Sheet sheet, int columnIndex) sync* {
  for (int rowIndex = _rowOffset; rowIndex < sheet.maxRows; rowIndex++) {
    final cellIndex = CellIndex.indexByColumnRow(
      columnIndex: columnIndex,
      rowIndex: rowIndex,
    );
    final data = sheet.cell(cellIndex);
    yield data.value.toString();
  }
}
