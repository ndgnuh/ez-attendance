import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

enum Gender { male, female, unknown }

class Course extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get altName => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Semester extends Table {
  TextColumn get id => text()();
  IntColumn get yearStart => integer()();
  IntColumn get yearEnd => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class CourseClass extends Table {
  IntColumn get id => integer()();
  TextColumn get courseId => text().references(Course, #id)();
  TextColumn get semester => text().references(Semester, #id)();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Student extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get gender => textEnum<Gender>()();
  TextColumn get managementGroup => text()();
  DateTimeColumn get dateOfBirth => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class CourseClassRegister extends Table {
  IntColumn get courseClassId => integer().references(CourseClass, #id)();
  IntColumn get studentId => integer().references(Student, #id)();

  @override
  Set<Column<Object>> get primaryKey => {courseClassId, studentId};
}

class CheckInSession extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get courseClassId => integer().references(CourseClass, #id)();
  IntColumn get studentId => integer().references(Student, #id)();
  DateTimeColumn get date => dateTime()();
}

class CheckInEntry extends Table {
  IntColumn get sessionId => integer().references(CheckInSession, #id)();
  IntColumn get studentId => integer().references(Student, #id)();

  @override
  Set<Column<Object>> get primaryKey => {sessionId, studentId};
}

@DriftDatabase(
  tables: [
    Course,
    Semester,
    CourseClass,
    Student,
    CourseClassRegister,
    CheckInSession,
    CheckInEntry,
  ],
)
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<SemesterData>> searchSemester(String query) {
    filter(Semester s) {
      return s.id.like('%$query%');
    }

    return (select(semester)
          ..where(filter)
          ..orderBy([(s) => OrderingTerm(expression: s.id)]))
        .get();
  }

  static QueryExecutor _openConnection() {
    print(getApplicationSupportDirectory());
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
