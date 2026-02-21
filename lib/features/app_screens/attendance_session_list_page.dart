import 'package:checkin_tool/features/attendance_session/session_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:material_symbols_icons/symbols.dart';

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
        title: Text("Buổi điểm danh"),
      ),
      floatingActionButton: AttendanceSessionCreateButton(
        courseClassId: courseClassId,
        builder: (context, onPressed) {
          return FloatingActionButton.extended(
            onPressed: onPressed,
            icon: Icon(Symbols.add),
            label: Text("Thêm buổi"),
          );
        },
      ),
      body: Padding(
        padding: EdgeInsets.all(context.gutter),
        child: AttendanceSessionListView(courseClassId: courseClassId),
      ),
    );
  }
}
