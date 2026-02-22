import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../shared/dialogs.dart';
import '../domain/dao.dart';
import 'providers.dart';
import 'widgets/add_student_button.dart';
import 'widgets/scan_mode.dart';
import 'widgets/manual_mode.dart';

class AttendanceStudentListPage extends ConsumerWidget {
  final int sessionId;

  const AttendanceStudentListPage({
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
                false => AttendanceCheckList(sessionId: sessionId),
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
