/// TODO: merge with class management
library;

import 'package:checkin_tool/shared/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
  final ref = ProviderScope.containerOf(context);

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
  final startPeriod = await PeriodSelectionDialog.show(
    titleText: "Tiết bắt đầu",
  );
  if (startPeriod == null) return;

  final endPeriod = await PeriodSelectionDialog.show(
    titleText: "Tiết kết thúc",
  );
  if (endPeriod == null) return;

  // Create and return date time
  final startTime = DateTime(
    date.year,
    date.month,
    date.day,
    startPeriod.startHour,
    startPeriod.startMinute,
  );

  final endTime = DateTime(
    date.year,
    date.month,
    date.day,
    endPeriod.endHour,
    endPeriod.endMinute,
  );

  final db = await ref.read(databaseProvider.future);
  return await db.createAttendanceSession(
    courseClassId: courseClassId,
    startTime: startTime,
    endTime: endTime,
  );
}
