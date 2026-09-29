/// Page that list the attendance session with in a course class.
/// Export [AttendanceSessionListPage] widget (a page).
library;

import 'package:checkin_tool/core/db_consumers.dart';
import 'package:checkin_tool/features/add_session/page.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'widgets/attendance_session_list_view.dart';
import 'widgets/session_create_button.dart';

class AttendanceSessionListPage extends StatelessWidget {
  final int courseClassId;

  const AttendanceSessionListPage({
    super.key,
    required this.courseClassId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buổi học"),
        actions: [
          _PageMenu(classId: courseClassId),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddSessionPage(classId: courseClassId),
            ),
          );
        },
        icon: Icon(Symbols.add),
        label: Text("Thêm"),
      ),
      body: Padding(
        padding: EdgeInsets.all(context.gutter),
        child: Column(
          children: [
            CourseClassConsumer(
              id: courseClassId,
              builder: (context, courseClass) {
                return ListTile(
                  leading: Icon(Symbols.numbers),
                  title: Text("Mã lớp"),
                  subtitle: Text(
                    "${courseClass.classCode} - ${courseClass.courseId}",
                  ),
                );
              },
            ),
            Expanded(
              child: AttendanceSessionListView(courseClassId: courseClassId),
            ),
          ],
        ),
      ),
    );
  }
}

class _PageMenu extends StatefulWidget {
  final int classId;

  const _PageMenu({required this.classId});

  @override
  State<_PageMenu> createState() => _PageMenuState();
}

class _PageMenuState extends State<_PageMenu> {
  final MenuController controller = MenuController();
  @override
  Widget build(BuildContext context) {
    final classId = widget.classId;
    return MenuAnchor(
      consumeOutsideTap: true,
      controller: controller,
      builder: (context, controller, child) => child!,
      menuChildren: [
        ListTile(
          title: Text("Thêm buổi học"),
          leading: Icon(Symbols.add),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSessionPage(classId: classId),
              ),
            );
            controller.close();
          },
        ),
      ],
      child: IconButton(
        onPressed: () => controller.open(),
        icon: Icon(Symbols.menu),
      ),
    );
  }
}
