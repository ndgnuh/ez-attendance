import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/db_consumers.dart';
import 'ui_model.dart';
import 'widgets/day_picker.dart';

class AddSessionPage extends StatelessWidget {
  final int classId;

  const AddSessionPage({super.key, required this.classId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buổi học mới"),
      ),
      body: AddSessionScope(
        classId: classId,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(context.gutter),
          child: Column(
            children: [
              /// Show class code
              CourseClassConsumer(
                id: classId,
                builder:
                    (context, courseClass) => ListTile(
                      title: Text("Mã lớp"),
                      subtitle: Text(courseClass.classCode),
                    ),
              ),

              /// Show course
              Divider(),
              CourseClassConsumer(
                id: classId,
                builder:
                    (context, courseClass) => ListTile(
                      title: Text("Mã học phần"),
                      subtitle: Text(courseClass.courseId),
                    ),
              ),

              // Day Picker
              Divider(),
              DayPicker(),
            ],
          ),
        ),
      ),
    );
  }
}
