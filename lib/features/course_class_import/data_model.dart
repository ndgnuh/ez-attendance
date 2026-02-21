import '../../core/database/database.dart';
import '../../shared/utilities.dart';

class ImportData {
  final String courseClassCode;
  final String courseId;
  final String courseName;
  final List<String> studentIds;
  final List<String> studentNames;
  late final List<String> studentEmails;

  ImportData({
    required this.courseClassCode,
    required this.courseId,
    required this.courseName,
    required this.studentIds,
    required this.studentNames,
    List<String>? studentEmails,
  }) : studentEmails =
           studentEmails ??
           autoStudentEmails(
             studentNames: studentNames,
             studentIds: studentIds,
           );
}

extension CourseClassesImport on AppDatabase {
  Future<int> importCourseClass({
    required ImportData data,
    required SemesterData semester,
  }) async {
    // Check if the provided email list matches length (inferred list will match)
    final numStudents = data.studentIds.length;
    assert(numStudents == data.studentNames.length);
    assert(numStudents == data.studentEmails.length);

    // This is done in a transactional way
    return transaction(() async {
      // insert or update course
      final courseCompanion = CourseCompanion.insert(
        id: data.courseId,
        name: data.courseName,
      );
      into(course).insertOnConflictUpdate(courseCompanion);

      // insert or update the course class
      final courseClassId = await into(courseClass).insertOnConflictUpdate(
        CourseClassCompanion.insert(
          classCode: data.courseClassCode,
          courseId: data.courseId,
          semesterId: semester.id,
        ),
      );

      // update the class registration
      final studentEntities = <StudentCompanion>[];
      final registrationEntities = <RegistrationCompanion>[];
      for (int idx = 0; idx < numStudents; idx++) {
        final studentName = data.studentNames[idx];
        final studentId = data.studentIds[idx];
        final studentEmail = data.studentEmails[idx];

        // Student entity
        final studentEntity = StudentCompanion.insert(
          id: studentId,
          email: studentEmail,
          name: studentName,
        );

        // registration entity
        final registrationEntity = RegistrationCompanion.insert(
          courseClassId: courseClassId,
          studentId: studentId,
        );

        // Store entities
        studentEntities.add(studentEntity);
        registrationEntities.add(registrationEntity);
      }

      // Upsert all the students and registrations
      await batch((batch) async {
        batch.insertAllOnConflictUpdate(student, studentEntities);
        batch.insertAllOnConflictUpdate(registration, registrationEntities);
      });

      return courseClassId;
    });
  }
}
