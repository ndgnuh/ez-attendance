import 'dart:typed_data';

import 'package:excel/excel.dart';

import '../../shared/utilities.dart';
import 'data_model.dart';

const _columns = (
  semester: "Học kỳ",
  courseClassCode: "Mã lớp",
  courseId: "Mã Học phần",
  courseName: "Tên Học phần",
  studentId: "MSSV",
  studentName: "Họ và tên SV",
  studentEmail: "Email",
);

ImportData importFromQldt({required Uint8List bytes}) {
  final excel = Excel.decodeBytes(bytes);
  final sheet = excel[excel.getDefaultSheet() as String];
  return ImportData(
    studentIds: _fetchColumn(sheet, _columns.studentId).toList(),
    studentNames:
        _fetchColumn(sheet, _columns.studentName).map(titlecase).toList(),
    studentEmails: _fetchColumn(sheet, _columns.studentEmail).toList(),
    courseClassCode: _fetchColumn(sheet, _columns.courseClassCode).first,
    courseId: _fetchColumn(sheet, _columns.courseId).first,
    courseName: _fetchColumn(sheet, _columns.courseName).first,
  );
}

Iterable<String> _fetchColumn(Sheet sheet, String columnName) sync* {
  final columnIndex = _getColumnIndex(sheet, columnName);
  for (int rowIndex = 1; rowIndex < sheet.maxRows; rowIndex++) {
    final cellIndex = CellIndex.indexByColumnRow(
      columnIndex: columnIndex,
      rowIndex: rowIndex,
    );
    final data = sheet.cell(cellIndex);
    yield data.value.toString();
  }
}

int _getColumnIndex(Sheet sheet, String columnName) {
  for (int columnIndex = 0; columnIndex < sheet.maxColumns; columnIndex++) {
    final idx = CellIndex.indexByColumnRow(
      columnIndex: columnIndex,
      rowIndex: 0,
    );
    final data = sheet.cell(idx);

    if (data.value.toString() == columnName) {
      return columnIndex;
    }
  }

  throw "Cannot find column name $columnName";
}
