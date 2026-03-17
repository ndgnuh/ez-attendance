import 'dart:async';

import 'package:checkin_tool/shared/dialogs.dart';
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
  final scannedStudentIds = <String>{};
  String? previousId;

  bool processing = false;
  int get sessionId => widget.sessionId;

  Future<AttendanceData?> ensureAttendanceData({
    required final AppDatabase db,
    required final AppRouter router,
    required final String studentId,
  }) async {
    /// Check student ID
    /// If student ID is not available
    final attendanceData = await db.checkStudentInAttendanceList(
      studentId: studentId,
      sessionId: widget.sessionId,
    );

    /// Try to create student and attendance data
    /// If not, just return and notify that the student
    /// does ont exists.
    if (attendanceData == null) {
      /// Prompt for more information
      final studentCompanion = await router.toAddStudentPage(
        studentId: studentId,
      );

      /// User cancelled
      if (studentCompanion == null) {
        return null;
      }

      /// Insert student, store attendance data
      return await db.addStudent(
        sessionId: sessionId,
        studentCompanion: studentCompanion,
      );
    } else {
      return attendanceData;
    }
  }

  Future<void> handleScanning(
    BuildContext context,
    BarcodeCapture barcodeCapture,
  ) async {
    final router = AppRouter(context);
    final messenger = ScaffoldMessenger.of(context);

    /// Check for scanned bar code
    final barcodes = barcodeCapture.barcodes;
    if (barcodes.isEmpty) {
      return;
    }

    /// Run logic
    final ref = ProviderScope.containerOf(context);
    final db = await ref.read(databaseProvider.future);

    /// Get student Ids
    final studentIds = <String>[];
    for (final barcode in barcodes) {
      final studentId = matchStudentId(barcode.displayValue ?? "");
      if (studentId == null) {
        continue;
      }
      studentIds.add(studentId);
    }

    /// Guards: no student ID
    if (studentIds.isEmpty) {
      return;
    }

    final mode = ref.read(ScanModeNotifier.provider);

    /// If multiple student found during point addition
    if (mode == ScanningMode.markContributed && studentIds.length > 1) {
      /// Multiple detection queue is fired, we need to controll the dialog separately
      await showAlert(
        title: "Phát hiện nhiều mã sinh viên",
        description:
            "Khi cộng điểm, để tránh cộng nhầm, app chỉ cho phép cộng cho 1 sinh viên mỗi lần quét",
      );
      return;
    }

    /// Loop over student Ids
    final codesNotifier = ref.read(_ScannedCodesNotifier.notifier);
    for (final studentId in studentIds) {
      final attendanceData = await ensureAttendanceData(
        db: db,
        router: router,
        studentId: studentId,
      );
      if (attendanceData == null) continue;

      /// Update inside DB
      final command = ref.read(
        AttandanceUpdateLogic.provider(attendanceData),
      );
      switch (mode) {
        case ScanningMode.markAttend:
          await command.updateStatus(AttendanceStatus.present);
          codesNotifier.add(studentId);
        case ScanningMode.markLate:
          await command.updateStatus(AttendanceStatus.late);
          codesNotifier.add(studentId);
        case ScanningMode.markContributed:
          final ok = await showConfirmationDialog(
            titleText: "Cộng điểm cho mã sinh viên $studentId?",
          );
          if (ok) {
            await command.changeScore(1);
            codesNotifier.add(studentId);
          }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      onDetect: (barcodeCapture) async {
        print("Processing? $processing");
        if (processing) return;
        processing = true;
        await handleScanning(context, barcodeCapture);
        processing = false;
      },

      tapToFocus: true,
      overlayBuilder: (context, constraint) {
        return _ScanMessageOverlay();
      },
    );
  }
}

extension ScanningModeView on ScanningMode {
  IconData get iconData => switch (this) {
    ScanningMode.markAttend => Symbols.check_circle,
    ScanningMode.markLate => Symbols.history_toggle_off,
    ScanningMode.markContributed => Symbols.assignment_turned_in,
  };

  String get labelText => switch (this) {
    ScanningMode.markAttend => "Điểm danh",
    ScanningMode.markLate => "Điểm danh đi muộn",
    ScanningMode.markContributed => "Cộng tích cực",
  };

  Color fgColor(ColorScheme scheme) => switch (this) {
    ScanningMode.markAttend => scheme.primary,
    ScanningMode.markContributed => scheme.tertiary,
    ScanningMode.markLate => scheme.error,
  };

  Color bgColor(ColorScheme scheme) => switch (this) {
    ScanningMode.markAttend => scheme.primaryContainer,
    ScanningMode.markContributed => scheme.tertiaryContainer,
    ScanningMode.markLate => scheme.errorContainer,
  };
}

class AttendanceScanModePicker extends ConsumerWidget {
  const AttendanceScanModePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = ColorScheme.of(context);
    final currentMode = ref.watch(ScanModeNotifier.provider);

    final backgroundColor = currentMode.bgColor(scheme);
    final foregroundColor = currentMode.fgColor(scheme);
    final iconData = currentMode.iconData;
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
              scanMode.iconData,
              color: scanMode.fgColor(scheme),
            ),
          ),
      ],
      onSelected: (mode) {
        ref.read(ScanModeNotifier.instance).set(mode ?? currentMode);
      },
    );
  }
}

class _ScannedCodesNotifier extends Notifier<Set<String>> {
  static final provider = NotifierProvider(_ScannedCodesNotifier.new);
  static final notifier = provider.notifier;

  @override
  Set<String> build() {
    ref.watch(ScanModeNotifier.provider);
    return {};
  }

  void add(String code) => state = {...state, code};
  void clear() => state = {};
}

class ScannedNumberOfCodes extends ConsumerWidget {
  const ScannedNumberOfCodes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final codes = ref.watch(_ScannedCodesNotifier.provider);
    final text = "Số lượng mã đã scan: ${codes.length}";
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: context.gutter,
        children: [
          Expanded(
            child: TextField(
              readOnly: true,
              controller: TextEditingController(text: text),
            ),
          ),
          AspectRatio(
            aspectRatio: 1.0,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Symbols.save, fill: 1.0),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScanMessageOverlay extends ConsumerWidget {
  const _ScanMessageOverlay();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Number of scanned
    final codes = ref.watch(_ScannedCodesNotifier.provider);

    /// Mode, for label
    final mode = ref.watch(ScanModeNotifier.provider);
    final labelText = mode.labelText;
    final scheme = ColorScheme.of(context);

    final codesText = [for (final code in codes) "\n⋅ $code"].join("");
    final text = "$labelText: ${codes.length}$codesText";

    final style = TextStyle(
      color: mode.fgColor(scheme),
      fontWeight: FontWeight.bold,
    );
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        color: mode.bgColor(scheme),
        padding: EdgeInsets.all(context.gutterSmall),
        child: Text(
          text,
          style: style,
        ),
      ),
    );
  }
}

class ScanClearButton extends ConsumerWidget {
  const ScanClearButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /// Number of scanned
    final codesNotifier = ref.watch(_ScannedCodesNotifier.notifier);

    return OutlinedButton.icon(
      icon: Icon(Symbols.refresh),
      label: Text("Reset bộ đếm"),
      onPressed: () => codesNotifier.clear(),
    );
  }
}
