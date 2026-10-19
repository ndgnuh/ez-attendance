// List the students in an attendance session
library;

import 'dart:async';

import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../shared/dialogs.dart';
import '../../batch_contribution/batch_contribution.dart';
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
          _ActionMenu(sessionId: sessionId),
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
            if (scanMode) ScanClearButton(),
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

class _ActionMenu extends StatefulWidget {
  const _ActionMenu({
    required this.sessionId,
  });

  final int sessionId;

  @override
  State<_ActionMenu> createState() => _ActionMenuState();
}

class _ActionMenuState extends State<_ActionMenu> {
  final MenuController controller = MenuController();

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) => child!,
      controller: controller,
      menuChildren: [
        ListTile(
          title: Text("Cộng điểm hàng loạt"),
          subtitle: Text("Cộng điểm cho nhiều sinh viên cùng một lúc"),
          leading: Icon(Symbols.batch_prediction),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => BatchContributionPage(sessionId: widget.sessionId),
              ),
            );
            controller.close();
          },
        ),
        Divider(),
        AddStudentButton(
          sessionId: widget.sessionId,
          builder: (BuildContext context, onPressed) {
            return ListTile(
              leading: Icon(Symbols.add),
              title: Text("Thêm sinh viên"),
              onTap: () {
                controller.close();
                onPressed();
              },
            );
          },
        ),
        SessionDeleteButton(
          sessionId: widget.sessionId,
          builder: (context, onPressed) {
            final scheme = ColorScheme.of(context);
            return ListTile(
              leading: Icon(Symbols.delete, color: scheme.error),
              title: Text(
                "Xóa buổi học",
                style: TextStyle(color: scheme.error),
              ),
              onTap: () {
                controller.close();
                onPressed();
              },
            );
          },
        ),
      ],
      child: IconButton(
        onPressed: () => controller.open(),
        icon: Icon(Symbols.menu_rounded),
      ),
    );
  }
}

class NewLineToSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String replacedText = newValue.text.replaceAll('\n', ' ');
    return newValue.copyWith(
      text: replacedText,
      selection: TextSelection.collapsed(offset: replacedText.length),
    );
  }
}

class AttendanceSearchBar extends ConsumerStatefulWidget {
  const AttendanceSearchBar({super.key});

  @override
  ConsumerState<AttendanceSearchBar> createState() =>
      _AttendanceSearchBarState();
}

class _AttendanceSearchBarState extends ConsumerState<AttendanceSearchBar> {
  late final searchTextController = TextEditingController(
    text: ref.read(searchTextProvider),
  );

  late final focusNode = createFocusNode(searchTextController);
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    focusNode.dispose();
    searchTextController.dispose();
    super.dispose();
  }

  /// Commits the current text to [searchTextProvider], dropping any pending
  /// debounced commit.
  void _commit() {
    _debounce?.cancel();
    ref.read(searchTextProvider.notifier).setState(searchTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchTextController,
      onChanged: (_) {
        _debounce?.cancel();
        _debounce = Timer(const Duration(milliseconds: 150), _commit);
      },
      onSubmitted: (_) => _commit(),
      inputFormatters: [NewLineToSpaceFormatter()],
      decoration: InputDecoration(
        label: Text("Lọc sinh viên"),
        prefixIcon: Icon(Symbols.search),
      ),
      maxLines: null,
      focusNode: focusNode,
    );
  }

  FocusNode createFocusNode(TextEditingController controller) {
    final focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasPrimaryFocus) {
        controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: controller.text.length,
        );
      } else if (!focusNode.hasFocus) {
        _commit();
      }
    });

    return focusNode;
  }
}

class SessionDeleteButton extends StatelessWidget {
  final int sessionId;
  final Widget Function(BuildContext context, VoidCallback onPressed) builder;

  const SessionDeleteButton({
    super.key,
    required this.sessionId,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final ref = ProviderScope.containerOf(context);
    final navigator = Navigator.of(context);
    return builder(
      context,
      () async {
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
