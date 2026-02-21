import 'package:diacritic/diacritic.dart';

String autoEmail({required String studentName, required studentId}) {
  final studentIdShort = studentId.substring(2);
  final normalized = removeDiacritics(titlecase(studentName));

  final parts = normalized.split(" ");
  final firstName = parts.removeLast();
  final initials = parts.map((part) => part.substring(0, 1)).join();

  return "$firstName.$initials$studentIdShort@sis.hust.edu.vn";
}

List<String> autoStudentEmails({
  required List<String> studentNames,
  required List<String> studentIds,
}) {
  final emails = <String>[];
  for (final (i, studentName) in studentNames.indexed) {
    final studentId = studentIds[i];
    final studentEmail = autoEmail(
      studentName: studentName,
      studentId: studentId,
    );
    emails.add(studentEmail);
  }
  return emails;
}

/// Convert something like "JOHN SMITH" to "John Smith"
String titlecase(String name) {
  return name
      .split(' ')
      .map(
        (word) => "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}",
      )
      .join(' ');
}
