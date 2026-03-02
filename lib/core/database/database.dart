library;

import 'dart:io';

import 'package:diacritic/diacritic.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/common.dart' show AllowedArgumentCount, CommonDatabase;
import './../enums.dart';
import 'tables.dart';

export './classes_dao.dart';
export './semester_dao.dart';

import 'database.steps.dart';
part 'database.g.dart';

final _defaultPeriods = [
  PeriodData(id: 1, startHour: 6, startMinute: 45, endHour: 7, endMinute: 30),
  PeriodData(id: 2, startHour: 7, startMinute: 30, endHour: 8, endMinute: 15),
  PeriodData(id: 3, startHour: 8, startMinute: 25, endHour: 9, endMinute: 10),
  PeriodData(id: 4, startHour: 9, startMinute: 20, endHour: 10, endMinute: 05),
  PeriodData(id: 5, startHour: 10, startMinute: 15, endHour: 11, endMinute: 00),
  PeriodData(id: 6, startHour: 11, startMinute: 00, endHour: 11, endMinute: 45),

  // KÍP CHIỀU
  PeriodData(id: 7, startHour: 12, startMinute: 30, endHour: 13, endMinute: 15),
  PeriodData(id: 8, startHour: 13, startMinute: 15, endHour: 14, endMinute: 00),
  PeriodData(id: 9, startHour: 14, startMinute: 10, endHour: 14, endMinute: 55),
  PeriodData(
    id: 10,
    startHour: 15,
    startMinute: 05,
    endHour: 15,
    endMinute: 50,
  ),
  PeriodData(
    id: 11,
    startHour: 16,
    startMinute: 00,
    endHour: 16,
    endMinute: 45,
  ),
  PeriodData(
    id: 12,
    startHour: 16,
    startMinute: 45,
    endHour: 17,
    endMinute: 30,
  ),

  // KÍP TỐI
  PeriodData(
    id: 13,
    startHour: 17,
    startMinute: 45,
    endHour: 18,
    endMinute: 30,
  ),
  PeriodData(
    id: 14,
    startHour: 18,
    startMinute: 30,
    endHour: 19,
    endMinute: 15,
  ),
];

void setupFunction(CommonDatabase common) {
  common.select("PRAGMA foreign_keys = ON;");

  /// This function is used to sort by name
  common.createFunction(
    functionName: "getFirstName",
    argumentCount: const AllowedArgumentCount(1),
    deterministic: true,
    directOnly: false,
    function: (args) {
      final input = args[0] as String?;
      if (input == null || input.isEmpty) return null;
      final name = removeDiacritics(input);
      return name.trim().split(' ').last;
    },
  );

  /// Create search key by remove the diacritic
  /// of the first arguments, and then combine other informations
  common.createFunction(
    functionName: "createSearchKey",
    deterministic: true,
    directOnly: false,
    argumentCount: const AllowedArgumentCount.any(),
    function: (args) {
      final parts = <String>[];
      final name = (args[0] as String);
      final dname = removeDiacritics(name);
      parts.add(name);
      parts.add(dname);
      for (final arg in args.skip(1)) {
        parts.add(arg as String);
      }
      return parts.map((p) => "($p)").join();
    },
  );
}

@DriftDatabase(tables: tables)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  SimpleSelectStatement<Course, CourseData> searchCourse({
    String? id,
    String? searchText,
  }) {
    final stmt = select(course);

    switch (id) {
      case String courseId when courseId.trim().isNotEmpty:
        stmt.where((c) => c.id.equals(courseId));
    }

    switch (searchText) {
      case String text when text.trim().isNotEmpty:
        stmt.where((c) => c.name.contains(text) | c.id.contains(text));
    }

    return stmt;
  }

  static Future<Uint8List> createTemporaryDatabase() async {
    Future<String> getDatabasePath() async {
      final directory = await getTemporaryDirectory();
      final dbPath = path.join(
        directory.path,
        'attendance_database.sqlite',
      );
      return dbPath;
    }

    final executor = driftDatabase(
      name: 'attendance_database',
      native: DriftNativeOptions(
        databaseDirectory: getTemporaryDirectory,
        setup: setupFunction,
      ),
    );

    // Literally query anything to get the DB created
    final db = AppDatabase(executor);
    await db.course.select().get();
    await db.close();

    final file = File(await getDatabasePath());
    final dbBytes = await file.readAsBytes();
    return dbBytes;
  }

  static AppDatabase openLocalDatabase(String databasePath) {
    final executor = driftDatabase(
      name: 'attendance_database',
      native: DriftNativeOptions(
        databasePath: () => Future.value(databasePath),
        setup: setupFunction,
      ),
    );
    return AppDatabase(executor);
  }

  static QueryExecutor _openConnection() {
    final file = File('db.sqlite');
    final db = NativeDatabase(file);
    return db;
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: stepByStep(
        from1To2: (migrator, schema) async {
          migrator.createTable(schema.period);
          // TODO: do we need to alter the table?
          // migrator.dropColumn(schema.courseClass, "fromPeriod");
          // migrator.dropColumn(schema.courseClass, "toPeriod");
          // migrator.addColumn(schema.courseClass, Text)
        },
      ),
      beforeOpen: (details) async {
        if (details.hadUpgrade || details.wasCreated) {
          final periods = await select(period).get();
          if (periods.isEmpty) {
            await batch((b) async {
              b.insertAll(period, _defaultPeriods);
            });
          }
        }
      },
    );
  }
}
