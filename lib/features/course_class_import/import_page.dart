import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/database_service.dart';
import './providers.dart';
import './data_model.dart';
import './logic_qldt.dart';
import './logic_sohoa.dart';

const _fromSohoaLabel = "Nhập từ Số hóa";
const _fromQldtLabel = "Nhập từ QLĐT";

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
            _SemesterSelectionButton(),
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
            Expanded(
              child: _ImportPreview(),
            ),
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

enum ImportMode {
  qldt,
  sohoa;

  static List<DropdownMenuEntry> get dropdownMenuEntries => [
    for (final option in ImportMode.values)
      DropdownMenuEntry(value: option, label: option.label),
  ];

  /// Human readable label for the enum [ImportMode]
  String get label => switch (this) {
    qldt => "Quản lý đào tạo",
    sohoa => "Số hóa",
  };
}

class ImportModeNotifier extends Notifier<ImportMode> {
  static final provider = NotifierProvider(ImportModeNotifier.new);

  static final instance = provider.notifier;
  @override
  ImportMode build() => ImportMode.qldt;
}

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
    final semester = ref.watch(SemesterNotifier.provider);
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

class _SemesterSelectionButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semesterNotifier = ref.read(SemesterNotifier.instance);

    return SearchAnchor(
      viewHintText: "Tìm kiếm học kỳ",
      suggestionsBuilder: (context, controller) async {
        // Don't do anything on empty search
        final searchText = controller.text;
        if (searchText.isEmpty) {
          return [];
        }

        // Search for semester
        final db = await ref.read(databaseProvider.future);
        final semesters = await db.searchSemester(searchText: searchText).get();

        // Build options
        final options = <ListTile>[];
        for (final semester in semesters) {
          final option = ListTile(
            title: Text(semester.name),
            subtitle: Text("Học kỳ ${semester.name} [#${semester.id}]."),
            onTap: () {
              semesterNotifier.set(semester);
              controller.closeView(null);
            },
          );
          options.add(option);
        }

        // Null option (create new one)
        if (options.isEmpty) {
          options.add(
            ListTile(
              leading: Icon(Symbols.add),
              title: Text("Tạo mới"),
              subtitle: Text("Tạo học kỳ với tên '$searchText'"),
              onTap: () async {
                final semester = await db.createSemester(
                  semesterName: searchText,
                );
                semesterNotifier.set(semester);
                controller.closeView(null);
              },
            ),
          );
        }

        return options;
      },
      builder: (context, controller) {
        final semester = ref.watch(SemesterNotifier.provider);
        return TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            labelText: "Chọn học kỳ",
            hintText: "Chưa chọn học kỳ",
            suffixIcon: switch (semester) {
              null => null,
              _ => IconButton(
                onPressed: () => semesterNotifier.clear(),
                icon: Icon(Symbols.clear),
              ),
            },
          ),
          controller: TextEditingController(text: semester?.name ?? ""),
          onTap: () {
            controller.clear();
            controller.openView();
          },
        );
      },
    );
  }
}

class _ImportPreview extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(ImportDataNotifier.provider);
    if (data == null) {
      return Center(child: Text("Chưa nhập dữ liệu lớp"));
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          ListTile(
            title: Text("Mã học phần"),
            subtitle: Text(data.courseId),
          ),
          ListTile(
            title: Text("Tên học phần"),
            subtitle: Text(data.courseName),
          ),
          ListTile(
            title: Text("Mã lớp học"),
            subtitle: Text(data.courseClassCode),
          ),
          ListTile(
            title: Text("Sinh viên đăng ký"),
            subtitle: Text(data.studentNames.length.toString()),
          ),
          Divider(),
          for (final (idx, _) in data.studentIds.indexed)
            ListTile(
              title: Text(data.studentNames[idx]),
              subtitle: Text(data.studentIds[idx]),
            ),
        ],
      ),
    );
  }
}

class _SaveButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final importedData = ref.watch(ImportDataNotifier.provider);
    final semester = ref.watch(SemesterNotifier.provider);
    final ok = importedData != null && semester != null;
    final messenger = ScaffoldMessenger.of(context);

    onPressed() async {
      final db = await ref.watch(databaseProvider.future);
      await db.importCourseClass(data: importedData!, semester: semester!);
      messenger.showSnackBar(SnackBar(content: Text("Nhập thành công")));
      ref.read(ImportDataNotifier.instance).clear();
    }

    return FilledButton(
      onPressed: ok ? onPressed : null,
      child: Text("Lưu"),
    );
  }
}

class _ClearButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return OutlinedButton(
      onPressed: () {
        ref.read(SemesterNotifier.instance).clear();
        ref.read(ImportDataNotifier.instance).clear();
      },
      child: Text("Xóa"),
    );
  }
}
