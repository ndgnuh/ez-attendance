import 'package:checkin_tool/features/add_session/widgets/run_button.dart';
import 'package:checkin_tool/features/add_session/widgets/time_picker.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:material_symbols_icons/symbols.dart';
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
        child: Padding(
          padding: EdgeInsets.all(context.gutter),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: context.gutter,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      /// Show class code
                      CourseClassConsumer(
                        id: classId,
                        builder:
                            (context, courseClass) => ListTile(
                              leading: Icon(Symbols.numbers),
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
                              leading: Icon(null),
                              title: Text("Mã học phần"),
                              subtitle: Text(courseClass.courseId),
                            ),
                      ),

                      // Day Picker
                      Divider(),
                      DayPicker(),
                      Divider(),
                      StartTimePicker(),
                      Divider(),
                      EndTimePicker(),
                    ],
                  ),
                ),
              ),
              RunButton(),
            ],
          ),
        ),
      ),
    );
  }
}
