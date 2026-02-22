import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

/// What the hell is this screen
class AttendanceSessionCreatePage extends StatelessWidget {
  final int courseClassId;

  const AttendanceSessionCreatePage({
    super.key,
    required this.courseClassId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tạo buổi điểm danh"),
      ),
      body: Padding(
        padding: EdgeInsets.all(context.gutter),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: context.gutter,
          children: [
            Spacer(),
            TextField(
              decoration: InputDecoration(
                labelText: "Chọn ngày học",
              ),
              onTap: () {
                showDatePicker(
                  fieldLabelText: "Chọn ngày học",
                  helpText: "Chọn ngày học",
                  context: context,
                  firstDate: DateTime(1970, 1, 1),
                  lastDate: DateTime(3000, 12, 31),
                  initialDate: DateTime.now(),
                );
              },
            ),
            FilledButton(
              onPressed: () {},
              child: Text("Thêm"),
            ),
          ],
        ),
      ),
    );
  }
}
