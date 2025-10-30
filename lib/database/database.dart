library;

import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'tables.dart';

part 'database.g.dart';

@DriftDatabase(tables: tables)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static Future<Uint8List> createTemporaryDatabase() async {
    Future<String> getDatabasePath() async {
      final directory = await getTemporaryDirectory();
      final dbPath = '${directory.path}/attendance_database.sqlite';
      return dbPath;
    }

    final executor = driftDatabase(
      name: 'attendance_database',
      native: DriftNativeOptions(databasePath: getDatabasePath),
    );

    final db = AppDatabase(executor);
    await db.course.select().get(); // Literally anything to get the DB created
    db.close();

    final file = File(await getDatabasePath());
    final dbBytes = await file.readAsBytes();
    return dbBytes;
  }

  static AppDatabase openLocalDatabase(String path) {
    final executor = driftDatabase(
      name: 'attendance_database',
      native: DriftNativeOptions(
        databasePath: () => Future.value(path),
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
