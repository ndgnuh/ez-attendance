import 'package:excel/excel.dart';

import 'database/database.dart';
import 'dart:io';

CellIndex? findRowWithContent({required Sheet sheet, required String content}) {
  for (final row in sheet.rows) {
    for (final cell in row) {
      if (cell?.value.toString() == content) {
        return cell?.cellIndex;
      }
    }
  }
  return null;
}

List<List<String>> extractTableFromSheet({
  required Sheet sheet,
  required CellIndex tableStart,
  required CellIndex tableStop,
}) {
  final rows = <List<String>>[];
  for (
    var rowIndex = tableStart.rowIndex;
    rowIndex <= tableStop.rowIndex;
    rowIndex++
  ) {
    final row = <String>[];
    for (
      var colIndex = tableStart.columnIndex;
      colIndex <= tableStop.columnIndex;
      colIndex++
    ) {
      final cell = sheet.cell(
        CellIndex.indexByColumnRow(
          columnIndex: colIndex,
          rowIndex: rowIndex,
        ),
      );
      row.add(cell.value?.toString() ?? "");
    }
    rows.add(row);
  }
  return rows;
}

importCourseClassFromExcel({
  required String filePath,
}) async {
  final file = File(filePath);
  final xlsx = Excel.decodeBytes(await file.readAsBytes());
  final sheetName = xlsx.getDefaultSheet();
  assert(sheetName != null, "No default sheet found in the Excel file");
  final sheet = xlsx.sheets[sheetName]!;

  final courseName = sheet.cell(CellIndex.indexByString("B2")).value.toString();
  final courseCode = sheet.cell(CellIndex.indexByString("E2")).value.toString();
  final courseClassId =
      sheet.cell(CellIndex.indexByString("B4")).value.toString();
  print(courseName, courseCode, courseClassId);

  final tableStartIndex = findRowWithContent(
    sheet: sheet,
    content: "STT",
  );
  final tableStopIndex = CellIndex.indexByColumnRow(
    columnIndex: sheet.maxColumns,
    rowIndex: sheet.maxRows,
  );

  final rows = extractTableFromSheet(
    sheet: sheet,
    tableStart: tableStartIndex!,
    tableStop: tableStopIndex,
  );

  final teacher = rows[2][1].toString();
  final classId = rows[3][1].toString();
  final subjectId = rows[1][4].toString();
  final subjectName = rows[1][1].toString();

  // Probably wrong excel files
  //  STT MSSV	Họ và tên	Chữ ký	Ghi chú
  assert(rows[5][0] == "STT");

  // The records start at 6
  List<StudentData> students = [
    for (final row in table.rows)
      if (row[0] is int)
        Student(
          id: row[1]?.toString() ?? "",
          name: row[2]?.toString() ?? "",
          ord: int.parse(row[0].toString()), // fool proof
        ),
  ];

  // Probably wrong excel files
  assert(students.isNotEmpty);

  return Classroom(
    classId: classId,
    subjectId: subjectId,
    subjectName: subjectName,
    teacher: teacher,
    students: students,
    importSource: ImportSource.fromFamiSoHoa,
  );
}
