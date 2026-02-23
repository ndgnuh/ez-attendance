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

part 'database.g.dart';

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
  int get schemaVersion => 1;

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
    db.close();

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
}
