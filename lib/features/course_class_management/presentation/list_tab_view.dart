import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import './widgets/course_class_list_view.dart';
import './widgets/semester_picker.dart';

class CourseClassListTabView extends StatelessWidget {
  const CourseClassListTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.gutter),
      child: Column(
        spacing: context.gutter,
        children: [
          Expanded(child: CourseClassListView()),
          SemesterPicker(),
        ],
      ),
    );
  }
}
