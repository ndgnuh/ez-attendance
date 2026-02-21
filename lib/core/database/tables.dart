import 'package:drift/drift.dart';

class AttendanceConverter extends TypeConverter<AttendanceStatus, String> {
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

const tables = [
  Course,
  CourseClass,
  Session,
  Attendance,
  Registration,
  Semester,
  Student,
];

class Attendance extends Table {
  TextColumn get attendanceStatus => text().map(const AttendanceConverter())();
  IntColumn get numContributions => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {sessionId, studentId};

  IntColumn get sessionId =>
      integer().references(
        Session,
        #id,
        onUpdate: KeyAction.cascade,
        onDelete: KeyAction.cascade,
      )();

  TextColumn get studentId =>
      text().references(
        Student,
        #id,
        onUpdate: KeyAction.cascade,
        onDelete: KeyAction.cascade,
      )();
}

enum AttendanceStatus {
  unknown('00-unknown', 'Unknown'),
  present('01-present', 'Present'),
  absent('02-absent', 'Absent'),
  late('03-late', 'Late'),
  excused('04-excused', 'Excused');

  final String value;
  final String label;
  const AttendanceStatus(this.value, this.label);
}

class Course extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// generated search key
  TextColumn get searchKey =>
      text().generatedAs(
        FunctionCallExpression("createSearchKey", [name, id]),
      )();

  @override
  Set<Column> get primaryKey => {id};
}

class CourseClass extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get classCode => text()();
  IntColumn get dayOfWeek => integer().nullable()();
  IntColumn get fromPeriod => integer().nullable()();
  IntColumn get toPeriod => integer().nullable()();
  TextColumn get location => text().nullable()();

  TextColumn get courseId =>
      text().references(Course, #id, onUpdate: KeyAction.cascade)();
  IntColumn get semesterId =>
      integer().references(Semester, #id, onUpdate: KeyAction.cascade)();
}

class Registration extends Table {
  IntColumn get courseClassId =>
      integer().references(CourseClass, #id, onUpdate: KeyAction.cascade)();
  TextColumn get studentId =>
      text().references(Student, #id, onUpdate: KeyAction.cascade)();

  @override
  Set<Column> get primaryKey => {courseClassId, studentId};
}

class Semester extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class Session extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get courseClassId =>
      integer().references(CourseClass, #id, onUpdate: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
}

class Student extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  TextColumn get name => text()();

  // Generated columns
  TextColumn get firstName =>
      text().generatedAs(
        FunctionCallExpression("getFirstName", [name]),
        stored: false,
      )();
  TextColumn get searchKey =>
      text().generatedAs(
        FunctionCallExpression("createSearchKey", [name, id]),
        stored: false,
      )();

  @override
  Set<Column> get primaryKey => {id};
}
