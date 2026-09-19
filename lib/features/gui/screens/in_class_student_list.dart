/// Provide the page to list list of students in the class.
/// The purpose of this page is to quickly see the score
/// and states of students.
/// It should also allow features such as:
/// - Sorting from weakest (less ative) student
/// - Pick random student
library;

import 'package:material_ui/material_ui.dart';

class InClassStudentListScreen extends StatefulWidget {
  const InClassStudentListScreen({super.key});

  @override
  State<InClassStudentListScreen> createState() =>
      _InClassStudentListScreenState();
}

class _InClassStudentListScreenState extends State<InClassStudentListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
