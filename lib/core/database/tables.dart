import 'package:drift/drift.dart';

import '../enums.dart';

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

class Course extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// generated search key
  TextColumn get searchKey =>
      text().generatedAs(
        FunctionCallExpression("createSearchKey", [name, id]),
        stored: true,
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
      text().references(
        Course,
        #id,
        onUpdate: KeyAction.cascade,
        onDelete: KeyAction.restrict,
      )();
  IntColumn get semesterId =>
      integer().references(
        Semester,
        #id,
        onUpdate: KeyAction.cascade,
        onDelete: KeyAction.restrict,
      )();
}

class Registration extends Table {
  IntColumn get courseClassId =>
      integer().references(
        CourseClass,
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
      integer().references(
        CourseClass,
        #id,
        onUpdate: KeyAction.cascade,
        onDelete: KeyAction.cascade,
      )();
  DateTimeColumn get date => dateTime()();
}

class Student extends Table {
  TextColumn get id => text()();
  TextColumn get email => text()();
  TextColumn get name => text()();

  // Generated columns
  TextColumn get sortKey =>
      text().generatedAs(
        FunctionCallExpression("getFirstName", [name]),
        stored: true,
      )();
  TextColumn get searchKey =>
      text().generatedAs(
        FunctionCallExpression("createSearchKey", [name, id]),
        stored: true,
      )();

  @override
  Set<Column> get primaryKey => {id};
}
