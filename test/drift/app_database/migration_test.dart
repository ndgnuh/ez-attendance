// dart format width=80
// ignore_for_file: unused_local_variable, unused_import
import 'package:drift/drift.dart';
import 'package:drift_dev/api/migrations_native.dart';
import 'package:checkin_tool/core/database/database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'generated/schema.dart';

import 'generated/schema_v1.dart' as v1;
import 'generated/schema_v2.dart' as v2;

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  late SchemaVerifier verifier;

  setUpAll(() {
    verifier = SchemaVerifier(GeneratedHelper());
  });

  group('simple database migrations', () {
    // These simple tests verify all possible schema updates with a simple (no
    // data) migration. This is a quick way to ensure that written database
    // migrations properly alter the schema.
    const versions = GeneratedHelper.versions;
    for (final (i, fromVersion) in versions.indexed) {
      group('from $fromVersion', () {
        for (final toVersion in versions.skip(i + 1)) {
          test('to $toVersion', () async {
            final schema = await verifier.schemaAt(fromVersion);
            final db = AppDatabase(schema.newConnection());
            await verifier.migrateAndValidate(db, toVersion);
            await db.close();
          });
        }
      });
    }
  });

  // The following template shows how to write tests ensuring your migrations
  // preserve existing data.
  // Testing this can be useful for migrations that change existing columns
  // (e.g. by alterating their type or constraints). Migrations that only add
  // tables or columns typically don't need these advanced tests. For more
  // information, see https://drift.simonbinder.eu/migrations/tests/#verifying-data-integrity
  // TODO: This generated template shows how these tests could be written. Adopt
  // it to your own needs when testing migrations with data integrity.
  test('migration from v1 to v2 does not corrupt data', () async {
    // Add data to insert into the old database, and the expected rows after the
    // migration.
    // TODO: Fill these lists
    final oldCourseData = <v1.CourseData>[];
    final expectedNewCourseData = <v2.CourseData>[];

    final oldSemesterData = <v1.SemesterData>[];
    final expectedNewSemesterData = <v2.SemesterData>[];

    final oldCourseClassData = <v1.CourseClassData>[];
    final expectedNewCourseClassData = <v2.CourseClassData>[];

    final oldSessionData = <v1.SessionData>[];
    final expectedNewSessionData = <v2.SessionData>[];

    final oldStudentData = <v1.StudentData>[];
    final expectedNewStudentData = <v2.StudentData>[];

    final oldAttendanceData = <v1.AttendanceData>[];
    final expectedNewAttendanceData = <v2.AttendanceData>[];

    final oldRegistrationData = <v1.RegistrationData>[];
    final expectedNewRegistrationData = <v2.RegistrationData>[];

    await verifier.testWithDataIntegrity(
      oldVersion: 1,
      newVersion: 2,
      createOld: v1.DatabaseAtV1.new,
      createNew: v2.DatabaseAtV2.new,
      openTestedDatabase: AppDatabase.new,
      createItems: (batch, oldDb) {
        batch.insertAll(oldDb.course, oldCourseData);
        batch.insertAll(oldDb.semester, oldSemesterData);
        batch.insertAll(oldDb.courseClass, oldCourseClassData);
        batch.insertAll(oldDb.session, oldSessionData);
        batch.insertAll(oldDb.student, oldStudentData);
        batch.insertAll(oldDb.attendance, oldAttendanceData);
        batch.insertAll(oldDb.registration, oldRegistrationData);
      },
      validateItems: (newDb) async {
        expect(expectedNewCourseData, await newDb.select(newDb.course).get());
        expect(
          expectedNewSemesterData,
          await newDb.select(newDb.semester).get(),
        );
        expect(
          expectedNewCourseClassData,
          await newDb.select(newDb.courseClass).get(),
        );
        expect(expectedNewSessionData, await newDb.select(newDb.session).get());
        expect(expectedNewStudentData, await newDb.select(newDb.student).get());
        expect(
          expectedNewAttendanceData,
          await newDb.select(newDb.attendance).get(),
        );
        expect(
          expectedNewRegistrationData,
          await newDb.select(newDb.registration).get(),
        );
      },
    );
  });
}
