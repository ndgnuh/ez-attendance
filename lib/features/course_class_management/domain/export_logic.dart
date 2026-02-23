/// This is for exporting attendance data
/// Provider the [classAttendanceXlsxProvider] provider, this is the
/// exported attendance file
library;

import 'dart:async';
import 'dart:isolate';
import 'dart:math' as math;

import 'package:drift/drift.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:riverpod/riverpod.dart';

import '../../../core/enums.dart';
import '../../attendance/domain/dao.dart';

/// Provide the exported xlsx file for the course-class's attendance data
final classAttendanceXlsxProvider = FutureProvider.family(
  (ref, int courseClassId) async {
    final data = await ref.watch(_exportDataProvider(courseClassId).future);
    final bytes = await Isolate.run(
      () => _buildCourseClassAttendanceXlsx(data: data),
    );
    final now = DateTime.now();
    final timestamp = DateFormat("yyMMddHHmm").format(now);
    final courseClass = await ref.watch(_classProvider(courseClassId).future);
    final name = "CCTC-${courseClass.classCode}-$timestamp";
    return NamedFile(name: name, bytes: bytes, extension: "xlsx");
  },
);

/// Provider [List] of [AttendanceData] that belongs to the course class
/// Use join between [SessionData].
final _attendanceProvider = StreamProvider.family(
  (ref, int courseClassId) async* {
    final db = await ref.watch(databaseProvider.future);

    /// Session Ids that belong to course class
    final stmtSessionIds = db.selectOnly(db.session);
    stmtSessionIds.where(db.session.courseClassId.equals(courseClassId));
    stmtSessionIds.addColumns({db.session.id});

    /// Get [AttendanceData] belongs to the selected sessions
    final stmt = db.select(db.attendance);
    stmt.where((r) => r.sessionId.isInQuery(stmtSessionIds));

    await for (final attendanceList in stmt.watch()) {
      yield attendanceList;
    }
  },
);

//   attendanceTable(int courseClassId) async {
//     final stmtSessionIds = select(session);
//     stmtSessionIds.where((s) => s.courseClassId.equals(courseClassId));
//     final sessionIds = await stmtSessionIds.map((s) => s.id).get();
//
//     /// Student columns
//     var stmtStudents = selectOnly(student).join([
//       innerJoin(registration, student.id.equalsExp(registration.studentId)),
//     ]);
//     stmtSessionIds.addColumns([student.id, student.name]);
//
//     for (final sessionId in sessionIds) {
//       /// Addition statement
//       final stmtAddition = selectOnly(attendance);
//       stmtAddition.where(session.id.equals(sessionId));
//       stmtAddition.addColumns({
//         attendance.studentId,
//         attendance.attendanceStatus,
//       });
//
//       stmtStudents = stmtStudents.join([leftOuterJoin(stmtAddition.table, on)]);
//     }
//   }
// }

/// Provide the course class info base on [courseClassId]
final _classProvider = StreamProvider.family(
  (ref, int courseClassId) async* {
    final db = await ref.watch(databaseProvider.future);
    final stmt = db.select(db.courseClass);
    stmt.where((row) => row.id.equals(courseClassId));

    await for (final courseClass in stmt.watchSingle()) {
      yield courseClass;
    }
  },
);

/// Provider the [_ExportedData] for the output excel
final _exportDataProvider = StreamProvider.family((
  ref,
  int courseClassId,
) async* {
  final studentListProvider = _studentsProvider(courseClassId);
  final attendanceListProvider = _attendanceProvider(courseClassId);
  final sessionListProvider = _sessionsProvider(courseClassId);

  final studentList = await ref.watch(studentListProvider.future);
  final attendanceList = await ref.watch(attendanceListProvider.future);
  final sessionList = await ref.watch(sessionListProvider.future);

  yield _ExportedData(
    studentList: studentList,
    attendanceList: attendanceList,
    sessionList: sessionList,
  );
});

/// Provide [List] of [SessionData] that belongs to a course class
/// base on the [courseClassId].
final _sessionsProvider = StreamProvider.family(
  (ref, int courseClassId) async* {
    final db = await ref.watch(databaseProvider.future);
    final stmt = db.select(db.session)..where((row) {
      return row.courseClassId.equals(courseClassId);
    });
    stmt.orderBy([(session) => OrderingTerm.asc(db.session.date)]);

    await for (final sessions in stmt.watch()) {
      yield sessions;
    }
  },
);

/// Provide [List] of [StudentData] that registered in a course class.
final _studentsProvider = StreamProvider.family(
  (ref, int courseClassId) async* {
    final db = await ref.watch(databaseProvider.future);

    /// Query for list of student ids belongs to the class
    final stmtStudentIds = db.selectOnly(db.registration);
    stmtStudentIds.addColumns({db.registration.studentId});
    stmtStudentIds.where(db.registration.courseClassId.equals(courseClassId));

    /// Query list of students in the selected IDs.
    final stmt = db.select(db.student);
    stmt.where((student) => student.id.isInQuery(stmtStudentIds));
    stmt.orderBy([
      (student) => OrderingTerm.asc(student.sortKey),
    ]);

    await for (final students in stmt.watch()) {
      yield students;
    }
  },
);

/// Provide the excel sheet for the course class
FutureOr<Uint8List> _buildCourseClassAttendanceXlsx({
  required _ExportedData data,
}) {
  /// Create the file
  final xlsx = Excel.createExcel();
  final attendanceSheet = xlsx["Điểm danh"];
  final contributionSheet = xlsx["Tích cực"];
  final sheets = {attendanceSheet, contributionSheet};

  // Base cell style
  final baseStyle = CellStyle(
    verticalAlign: VerticalAlign.Center,
    horizontalAlign: HorizontalAlign.Center,
    fontFamily: "Serif",
    fontSize: 11,
  );

  /// Map session to index
  final inverseSessionMap = data.inverseSessionById;

  /// Table of attendance data
  final attendanceByStudent = data.attendanceByStudent;

  void buildSheet(
    Sheet sheet,
    CellValue Function(AttendanceData) tableCellBuilder,
  ) {
    // Header row
    final dateFormat = DateFormat("dd-MM-yyyy");
    final headerTexts = [
      "MSSV",
      "Họ và tên",
      for (final session in data.sessionList) dateFormat.format(session.date),
    ];

    /// Write header row
    for (final (i, headerText) in headerTexts.indexed) {
      final cellIndex = CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0);
      final cell = sheet.cell(cellIndex);
      cell.value = TextCellValue(headerText);
      cell.cellStyle = baseStyle.copyWith(boldVal: true);
    }

    final columnOffset = 2;
    final rowOffset = 1;
    for (final (i, student) in data.studentList.indexed) {
      final attendanceMap = attendanceByStudent[student]!;
      final rowIndex = rowOffset + i;

      /// Write student ID
      final idCell = sheet.cell(
        CellIndex.indexByColumnRow(
          columnIndex: 0,
          rowIndex: rowIndex,
        ),
      );
      idCell.value = TextCellValue(student.id);
      idCell.cellStyle = baseStyle.copyWith(
        horizontalAlignVal: HorizontalAlign.Left,
      );

      /// Write student name
      final nameCell = sheet.cell(
        CellIndex.indexByColumnRow(
          columnIndex: 1,
          rowIndex: rowIndex,
        ),
      );
      nameCell.value = TextCellValue(student.name);
      nameCell.cellStyle = baseStyle.copyWith(
        horizontalAlignVal: HorizontalAlign.Left,
      );

      /// Write attendance data
      for (final session in data.sessionList) {
        /// Get attendance data
        final defaultAttendance = AttendanceData(
          sessionId: session.id,
          studentId: student.id,
          attendanceStatus: AttendanceStatus.unknown,
          numContributions: 0,
        );
        final attendance = attendanceMap[session] ?? defaultAttendance;

        /// Get cell index
        final columnIndex = columnOffset + inverseSessionMap[session]!;
        final cellIndex = CellIndex.indexByColumnRow(
          columnIndex: columnIndex,
          rowIndex: rowIndex,
        );

        /// Set cell data
        final cell = sheet.cell(cellIndex);
        cell.value = tableCellBuilder(attendance);
        cell.cellStyle = baseStyle;
      }
    }

    /// Auto column width
    _sheetAutoWidth(sheet, padding: 1);
    sheet.setDefaultRowHeight(18);
  }

  buildSheet(attendanceSheet, (attendance) {
    final attendanceText = switch (attendance.attendanceStatus) {
      AttendanceStatus.unknown => "?",
      AttendanceStatus.present => "Có",
      AttendanceStatus.absent => "Vắng",
      AttendanceStatus.late => "Muộn",
      AttendanceStatus.excused => "Phép",
    };
    return TextCellValue(attendanceText);
  });

  buildSheet(contributionSheet, (attendance) {
    return IntCellValue(attendance.numContributions);
  });

  /// remove unused sheets
  for (final entry in xlsx.sheets.entries) {
    if (!sheets.contains(entry.value)) {
      xlsx.delete(entry.key);
    }
  }

  /// Save xslx file
  return xlsx.save() as Uint8List;
}

/// This function is yanked from the source of excel package
double _calcAutoWidth(Data cell, {double padding = 0.08}) {
  final numChar = cell.value.toString().length;
  return ((numChar * 7.0 + 9.0) / 7.0 * 256).truncate() / 256 + padding * 2;
}

void _sheetAutoWidth(Sheet sheet, {double padding = 0.08}) {
  print(("Max rows", sheet.maxRows));
  for (int columnIndex = 0; columnIndex < sheet.maxColumns; columnIndex++) {
    double maxWidth = 0;

    for (int rowIndex = 0; rowIndex < sheet.maxRows; rowIndex++) {
      final cell = sheet.cell(
        CellIndex.indexByColumnRow(
          columnIndex: columnIndex,
          rowIndex: rowIndex,
        ),
      );
      final width = _calcAutoWidth(cell, padding: padding);

      maxWidth = math.max(maxWidth, width);
    }

    sheet.setColumnWidth(columnIndex, maxWidth);
  }
}

/// Export attendance data
class _ExportedData {
  final List<StudentData> studentList;
  final List<AttendanceData> attendanceList;
  final List<SessionData> sessionList;

  const _ExportedData({
    required this.studentList,
    required this.attendanceList,
    required this.sessionList,
  });

  /// Map [StudentData]'Ids to the [AttendanceData] for each [SessionData]
  Map<StudentData, Map<SessionData, AttendanceData>> get attendanceByStudent {
    final outputs = <StudentData, Map<SessionData, AttendanceData>>{};
    for (final student in studentList) {
      final output = <SessionData, AttendanceData>{};
      final studentAttendances = attendanceList.where(
        (r) => r.studentId == student.id,
      );
      for (final attendance in studentAttendances) {
        final session = sessionById[attendance.sessionId]!;
        output[session] = attendance;
      }
      outputs[student] = output;
    }
    return outputs;
  }

  Map<SessionData, int> get inverseSessionById => {
    for (final (idx, session) in sessionList.indexed) session: idx,
  };

  /// Map [SessionData]'s id to their data
  Map<int, SessionData> get sessionById {
    final output = <int, SessionData>{};
    for (final session in sessionList) {
      output[session.id] = session;
    }
    return output;
  }

  /// Map [StudentData]'s ID to their data
  Map<String, StudentData> get studentById {
    final output = <String, StudentData>{};
    for (final student in studentList) {
      output[student.id] = student;
    }
    return output;
  }
}
