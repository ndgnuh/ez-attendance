import 'package:drift/drift.dart';

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
  IntColumn get sessionId => integer().references(Session, #id)();

  TextColumn get studentId => text().references(Student, #id)();
}

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

  @override
  Set<Column> get primaryKey => {id};
}

class CourseClass extends Table {
  TextColumn get code => text()();
  TextColumn get courseId => text().references(Course, #id)();
  IntColumn get dayOfWeek => integer()();
  IntColumn get fromPeriod => integer()();
  IntColumn get id => integer().autoIncrement()();
  TextColumn get location => text()();

  IntColumn get semesterId => integer().references(Semester, #id)();
  IntColumn get toPeriod => integer()();
}

class Registration extends Table {
  IntColumn get courseClassId => integer().references(CourseClass, #id)();
  @override
  Set<Column> get primaryKey => {courseClassId, studentId};

  TextColumn get studentId => text().references(Student, #id)();
}

class Semester extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
}

class Session extends Table {
  IntColumn get courseClassId => integer().references(CourseClass, #id)();
  DateTimeColumn get date => dateTime()();
  IntColumn get id => integer().autoIncrement()();
}

class Student extends Table {
  TextColumn get email => text()();
  TextColumn get id => text()();
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}
