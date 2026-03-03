import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/router.dart';
import '../../domain/dao.dart';
import '../../domain/data_model.dart';
import '../providers.dart';

class AttendanceScanner extends StatefulWidget {
  final int sessionId;
  const AttendanceScanner({super.key, required this.sessionId});

  @override
  State<AttendanceScanner> createState() => _AttendanceScannerState();
}

class _AttendanceScannerState extends State<AttendanceScanner> {
  static final cooldownDuration = Duration(seconds: 2);
  String? previousId;
  bool processing = false;

  @override
  Widget build(BuildContext context) {
    final router = context.router;
    final messenger = ScaffoldMessenger.of(context);
    final sessionId = widget.sessionId;

    return MobileScanner(
      onDetect: (barcodeCapture) async {
        // Return if we are in the middle of something
        if (processing) return;

        /// Check for scanned bar code
        final scanned = barcodeCapture.barcodes.first.displayValue;
        if (scanned == null) return;

        /// Run logic
        final ref = ProviderScope.containerOf(context);
        final db = await ref.read(databaseProvider.future);
        final message = ref.read(ScanMessageNotifier.instance);

        /// Match student ID
        final studentId = matchStudentId(scanned);
        if (studentId == null) {
          message.set("Không phải mã sinh viên");
          return;
        }

        /// If we are in the middle of something, don't process further
        if (previousId == studentId) return;
        previousId = studentId;
        Timer(cooldownDuration, () => previousId = null);

        /// Check student ID
        /// If student ID is not available
        final attendanceData = await db.checkStudentInAttendanceList(
          studentId: studentId,
          sessionId: widget.sessionId,
        );

        /// Try to create student and attendance data
        /// If not, just return and notify that the student
        /// does ont exists.
        final AttendanceData attendanceData2;
        if (attendanceData == null) {
          /// Prompt for more information
          final studentCompanion = await router.toAddStudentPage(
            studentId: studentId,
          );

          /// User cancelled
          if (studentCompanion == null) {
            message.set("MSV $studentId chưa có trong lớp");
            return;
          }

          /// Insert student, store attendance data
          attendanceData2 = await db.addStudent(
            sessionId: sessionId,
            studentCompanion: studentCompanion,
          );
        } else {
          attendanceData2 = attendanceData;
        }

        final scanMode = ref.read(ScanModeNotifier.provider);
        final command = ref.read(
          AttandanceUpdateLogic.provider(attendanceData2),
        );
        late String notification;
        switch (scanMode) {
          case ScanningMode.markAttend:
            command.updateStatus(AttendanceStatus.present);
            notification = "[Điểm danh] $studentId";
          case ScanningMode.markLate:
            command.updateStatus(AttendanceStatus.late);
            notification = "[Đi muộn] $studentId";
          case ScanningMode.markContributed:
            command.changeScore(1);
            notification = "[Cộng điểm] $studentId";
        }
        message.set(notification);
        messenger.hideCurrentSnackBar();
        messenger.showSnackBar(SnackBar(content: Text(notification)));
      },
    );
  }
}

class AttendanceScanModePicker extends ConsumerWidget {
  const AttendanceScanModePicker({super.key});

  IconData iconForScanMode(ScanningMode mode) {
    return switch (mode) {
      ScanningMode.markAttend => Symbols.check_circle,
      ScanningMode.markLate => Symbols.history_toggle_off,
      ScanningMode.markContributed => Symbols.assignment_turned_in,
    };
  }

  Color fgForScanMode(ColorScheme scheme, ScanningMode mode) {
    return switch (mode) {
      ScanningMode.markAttend => scheme.primary,
      ScanningMode.markContributed => scheme.tertiary,
      ScanningMode.markLate => scheme.error,
    };
  }

  Color bgForScanMode(ColorScheme scheme, ScanningMode mode) {
    return switch (mode) {
      ScanningMode.markAttend => scheme.primaryContainer,
      ScanningMode.markContributed => scheme.tertiaryContainer,
      ScanningMode.markLate => scheme.errorContainer,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = ColorScheme.of(context);
    final currentMode = ref.watch(ScanModeNotifier.provider);

    final backgroundColor = bgForScanMode(scheme, currentMode);
    final foregroundColor = fgForScanMode(scheme, currentMode);
    final iconData = iconForScanMode(currentMode);
    final inputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: foregroundColor, width: 2.0),
    );

    return DropdownMenu(
      textStyle: TextStyle(color: foregroundColor, fontWeight: FontWeight.bold),
      leadingIcon: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.gutterSmall),
        child: Icon(iconData, color: foregroundColor, weight: 800),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: backgroundColor,
        labelStyle: TextStyle(color: foregroundColor),
        floatingLabelStyle: TextStyle(color: foregroundColor),
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
      ),
      // label: Text("Chế độ"),
      expandedInsets: EdgeInsetsGeometry.zero,
      initialSelection: currentMode,
      dropdownMenuEntries: [
        for (final scanMode in ScanningMode.values)
          DropdownMenuEntry(
            label: scanMode.label,
            value: scanMode,
            leadingIcon: Icon(
              iconForScanMode(scanMode),
              color: fgForScanMode(scheme, scanMode),
            ),
          ),
      ],
      onSelected: (mode) {
        ref.read(ScanModeNotifier.instance).set(mode ?? currentMode);
      },
    );
  }
}

class ScanMessage extends ConsumerWidget {
  const ScanMessage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Thông tin scan sẽ hiển thị ở đây",
      ),
      readOnly: true,
      controller: ref.read(ScanMessageNotifier.instance).controller,
    );
  }
}
