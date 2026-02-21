import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../core/database_service.dart';
import '../../core/enums.dart';
import '../../core/router.dart';
import '../../shared/dialogs.dart';
import './data_model.dart';
import './providers.dart';

final dateFormat = DateFormat("dd/MM/yyyy");

Future<void> showAttendanceSessionCreationDialog({
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

class AddStudentButton extends StatelessWidget {
  final int sessionId;

  const AddStudentButton({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final ref = ProviderScope.containerOf(context);

        final companion = await context.router.toAddStudentPage();
        if (companion == null) {
          return;
        }

        final db = await ref.read(databaseProvider.future);
        await db.addStudent(
          sessionId: sessionId,
          studentCompanion: companion,
        );
      },
      icon: Icon(Symbols.add),
    );
  }
}

class AttendanceListPage extends ConsumerWidget {
  final int sessionId;

  const AttendanceListPage({
    super.key,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanMode = ref.watch(IsScanningNotifier.provider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Điểm danh"),
        actions: [
          SessionDeleteButton(sessionId: sessionId),
          AddStudentButton(sessionId: sessionId),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(context.gutter),
        child: Column(
          spacing: context.gutter,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: switch (scanMode) {
                false => AttendanceSessionStudentListView(sessionId: sessionId),
                true => AttendanceScanner(sessionId: sessionId),
              },
            ),
            if (scanMode) ScanMessage(),
            IntrinsicHeight(
              child: Row(
                spacing: context.gutter,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: switch (scanMode) {
                      false => AttendanceSearchBar(),
                      true => AttendanceScanModePicker(),
                    },
                  ),
                  AspectRatio(aspectRatio: 1, child: AttendanceModeSwitch()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceModeSwitch extends ConsumerWidget {
  const AttendanceModeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton.filled(
      icon: Icon(Symbols.swap_horiz),
      onPressed: () {
        final isScanningMode = ref.read(IsScanningNotifier.provider);
        final notifier = ref.read(IsScanningNotifier.instance);
        notifier.set(!isScanningMode);
      },
    );
  }
}

class AttendanceScanModePicker extends ConsumerWidget {
  const AttendanceScanModePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentMode = ref.read(ScanModeNotifier.provider);
    return DropdownMenu(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ref.watch(scanningBackgroundColorProvider),
      ),
      label: Text("Chế độ"),
      expandedInsets: EdgeInsetsGeometry.zero,
      initialSelection: currentMode,
      dropdownMenuEntries: [
        for (final scanMode in ScanningMode.values)
          DropdownMenuEntry(label: scanMode.label, value: scanMode),
      ],
      onSelected: (mode) {
        ref.read(ScanModeNotifier.instance).set(mode ?? currentMode);
      },
    );
  }
}

class AttendanceScanner extends StatefulWidget {
  final int sessionId;
  const AttendanceScanner({super.key, required this.sessionId});

  @override
  State<AttendanceScanner> createState() => _AttendanceScannerState();
}

class AttendanceSearchBar extends ConsumerWidget {
  const AttendanceSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: searchTextController,
      decoration: InputDecoration(
        label: Text("Lọc sinh viên"),
        prefixIcon: Icon(Symbols.search),
      ),
      focusNode: focusNode(searchTextController),
    );
  }

  FocusNode focusNode(TextEditingController controller) {
    final focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasPrimaryFocus) {
        controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: controller.text.length,
        );
      }
    });

    return focusNode;
  }
}

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
      () => showAttendanceSessionCreationDialog(
        context: context,
        helpText: dialogHelpText,
        courseClassId: courseClassId,
        confirmText: dialogConfirmText,
      ),
    );
  }
}

class AttendanceSessionListView extends ConsumerWidget {
  final int courseClassId;

  const AttendanceSessionListView({
    super.key,
    required this.courseClassId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessionListAsync = ref.watch(
      attendanceSessionListProvider(courseClassId),
    );
    switch (sessionListAsync) {
      case AsyncLoading():
        return Center(
          child: LinearProgressIndicator(),
        );
      case AsyncError(:final error, :final stackTrace):
        if (kDebugMode) {
          print(stackTrace);
        }
        return Center(
          child: Text(error.toString()),
        );
      default:
    }

    final sessionList = sessionListAsync.value!;
    if (sessionList.isEmpty) {
      return Center(
        child: Text("không có buổi điểm danh nào"),
      );
    }
    return ListView.separated(
      separatorBuilder: (context, _) => Divider(),
      itemCount: sessionList.length,
      itemBuilder: (context, idx) {
        final router = AppRouter(context);
        final session = sessionList[idx];
        final title = "Buổi học ${dateFormat.format(session.date)}";
        return ListTile(
          title: Text(title),
          subtitle: Text("Xem chi tiết"),
          trailing: Icon(Symbols.chevron_forward),
          onTap:
              () => router.toAttendanceSessionStudentListPage(
                session.id,
              ),
        );
      },
    );
  }
}

class AttendanceSessionStudentListView extends ConsumerWidget {
  final int sessionId;

  const AttendanceSessionStudentListView({
    super.key,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceListAsync = ref.watch(
      attendanceListProvider(sessionId),
    );

    // Handle loading and errors
    switch (attendanceListAsync) {
      case AsyncLoading():
        return Center(
          child: LinearProgressIndicator(),
        );
      case AsyncError(:final error, :final stackTrace):
        if (kDebugMode) {
          print(stackTrace);
        }
        return Center(
          child: Text(error.toString()),
        );
      default:
    }

    // Empty case
    final attendanceList = attendanceListAsync.value!;
    if (attendanceList.isEmpty) {
      return Center(
        child: Text("Không có bản ghi nào"),
      );
    }

    return ListView.separated(
      itemCount: attendanceList.length,
      separatorBuilder: (context, _) => Divider(),
      itemBuilder: (context, idx) {
        final (student, attendance) = attendanceList[idx];
        final title = "${student.id} - ${student.name}";
        final attendanceStatusLabel = attendance.attendanceStatus.label;
        final subtitle =
            "$attendanceStatusLabel. Đóng góp: ${attendance.numContributions}";
        return ListTile(
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: Icon(Symbols.chevron_forward),
          onTap: () {
            showDialog(
              builder: (context) {
                return _Action(
                  student: student,
                  attendance: attendance,
                );
              },
              context: context,
            );
          },
        );
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

class SessionDeleteButton extends StatelessWidget {
  final int sessionId;

  const SessionDeleteButton({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    final ref = ProviderScope.containerOf(context);
    final navigator = Navigator.of(context);
    return IconButton(
      onPressed: () async {
        final ok = await showConfirmationDialog(
          context: context,
          titleText: "Xóa buổi điểm danh?",
          confirmText: "XÓA",
        );
        if (!ok) return;

        final db = await ref.read(databaseProvider.future);
        await db.deleteAttendanceSession(sessionId);
        navigator.pop();
      },
      icon: Icon(Symbols.delete),
    );
  }
}

class _Action extends StatelessWidget {
  final StudentData student;
  final AttendanceData attendance;

  const _Action({required this.student, required this.attendance});

  @override
  Widget build(BuildContext context) {
    final ref = ProviderScope.containerOf(context);
    final logic = ref.read(AttandanceUpdateLogic.provider(attendance));
    void pop(_) => Navigator.pop(context);
    return SimpleDialog(
      children: [
        ListTile(
          leading: Icon(Symbols.check_box),
          title: Text("Điểm danh"),
          onTap: () => logic.updateStatus(AttendanceStatus.present).then(pop),
        ),
        ListTile(
          leading: Icon(null),
          title: Text("Điểm danh (muộn)"),
          onTap: () => logic.updateStatus(AttendanceStatus.late).then(pop),
        ),
        ListTile(
          leading: Icon(Symbols.clear),
          title: Text("Vắng"),
          onTap: () => logic.updateStatus(AttendanceStatus.absent).then(pop),
        ),
        ListTile(
          leading: Icon(null),
          title: Text("Xin nghỉ"),
          onTap: () => logic.updateStatus(AttendanceStatus.excused).then(pop),
        ),
        Divider(),
        ListTile(
          leading: Icon(Symbols.plus_one),
          title: Text("Cộng điểm"),
          onTap: () => logic.changeScore(1).then(pop),
        ),
        ListTile(
          leading: Icon(null),
          title: Text("Trừ điểm"),
          onTap: () => logic.changeScore(-1).then(pop),
        ),
      ],
    );
  }
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
