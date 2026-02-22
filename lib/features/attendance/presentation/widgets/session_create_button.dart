import 'package:flutter/material.dart';

import '../../../../core/database_service.dart';
import '../../domain/dao.dart';

class AttendanceSessionCreateButton extends StatelessWidget {
  final int courseClassId;
  final String? dialogHelpText;
  final String? dialogConfirmText;
  final Function(BuildContext context, VoidCallback) builder;

  const AttendanceSessionCreateButton({
    super.key,
    required this.courseClassId,
    required this.builder,
    this.dialogHelpText,
    this.dialogConfirmText,
  });

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      () => _showAttendanceSessionCreationDialog(
        context: context,
        helpText: dialogHelpText,
        courseClassId: courseClassId,
        confirmText: dialogConfirmText,
      ),
    );
  }
}

Future<void> _showAttendanceSessionCreationDialog({
  required BuildContext context,
  required int courseClassId,
  String? helpText,
  String? confirmText,
}) async {
  helpText ??= "Chọn ngày học";
  confirmText ??= "Tạo buổi điểm danh";
  final currentDate = DateTime.now();
  final currentTime = TimeOfDay.now();

  // Prompt for date
  final date = await showDatePicker(
    context: context,
    firstDate: DateTime(1970, 1, 1),
    lastDate: DateTime(3000, 12, 31),
    initialDate: currentDate,
    helpText: helpText,
    confirmText: confirmText,
  );
  if (date == null || !context.mounted) return;

  // Prompt for time
  final time = await showTimePicker(context: context, initialTime: currentTime);
  if (time == null || !context.mounted) return;

  // Create and return date time
  final db = await context.appDatabase;
  final datetime = DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
  return await db.createAttendanceSession(
    courseClassId: courseClassId,
    datetime: datetime,
  );
}
