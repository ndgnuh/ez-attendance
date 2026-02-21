import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/dao.dart';
import '../domain/import_logic_qldt.dart';
import '../domain/import_logic_sohoa.dart';
import '../domain/models.dart';
import './providers.dart';
import 'widgets/import_preview.dart';
import 'widgets/semester_searcher.dart';

const _fromQldtLabel = "Nhập từ QLĐT";
const _fromSohoaLabel = "Nhập từ Số hóa";

class ImportModeNotifier extends Notifier<ImportMode> {
  static final provider = NotifierProvider(ImportModeNotifier.new);

  static final instance = provider.notifier;
  @override
  ImportMode build() => ImportMode.qldt;
}

class _ClearButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      onPressed: () {
        ref.read(SemesterNotifier.instanceForImportPage).clear();
        ref.read(ImportDataNotifier.instance).clear();
      },
      child: Text("Xóa"),
    );
  }
}

class CourseClassImportPage extends StatelessWidget {
  const CourseClassImportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nhập lớp"),
      ),
      body: Padding(
        padding: EdgeInsets.all(context.gutter),
        child: Column(
          spacing: context.gutterSmall,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SemesterSearcher(),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: context.gutterSmall,
              children: [
                Expanded(
                  flex: _fromSohoaLabel.length,
                  child: _ImportButton(
                    importHandler: (bytes) => importFromSohoa(bytes: bytes),
                    label: _fromSohoaLabel,
                  ),
                ),
                Expanded(
                  flex: _fromQldtLabel.length,
                  child: _ImportButton(
                    importHandler: (bytes) => importFromQldt(bytes: bytes),
                    label: _fromQldtLabel,
                  ),
                ),
              ],
            ),
            Divider(),
            Expanded(child: ImportDataPreview()),
            Divider(),
            Row(
              spacing: context.gutterSmall,
              children: [
                Expanded(child: _ClearButton()),
                Expanded(child: _SaveButton()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// TODO: move to widget folder
class _ImportButton extends ConsumerWidget {
  final ImportData Function(Uint8List) importHandler;
  final String label;

  const _ImportButton({
    required this.importHandler,
    required this.label,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messenger = ScaffoldMessenger.of(context);
    final semester = ref.watch(SemesterNotifier.providerForImportPage);
    onPressed() async {
      final result = await FilePicker.platform.pickFiles(withData: true);
      if (result == null) {
        return;
      }

      final notifier = ref.read(ImportDataNotifier.instance);
      final bytes = result.files.first.bytes!;
      notifier.clear();
      try {
        final importData = importHandler(bytes);
        notifier.set(importData);
      } catch (e) {
        messenger.showSnackBar(SnackBar(content: Text("Lỗi khi nhập dữ liệu")));
      }
    }

    return OutlinedButton(
      onPressed: semester == null ? null : onPressed,
      child: Text(label),
    );
  }
}

/// TODO: move to widget folder
class _SaveButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final importedData = ref.watch(ImportDataNotifier.provider);
    final semester = ref.watch(SemesterNotifier.providerForImportPage);
    final ok = importedData != null && semester != null;
    final messenger = ScaffoldMessenger.of(context);

    onPressed() async {
      final sv = await ref.watch(CourseClassManagementService.provider.future);
      await sv.importCourseClass(data: importedData!, semester: semester!);
      messenger.showSnackBar(SnackBar(content: Text("Nhập thành công")));
      ref.read(ImportDataNotifier.instance).clear();
    }

    return FilledButton(
      onPressed: ok ? onPressed : null,
      child: Text("Lưu"),
    );
  }
}
