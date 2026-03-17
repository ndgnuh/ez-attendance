/// Export [ExportSemesterAttendanceScreen] Page
/// Xuất điểm danh của cả kỳ trong một file zip.
library;

import 'package:checkin_tool/features/course_class_management/domain/export_logic.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:riverpod/experimental/mutation.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/enums.dart';
import 'providers.dart';
import 'widgets/semester_picker.dart';

final _mutation = Mutation<NamedFile>();

/// Xuất điểm danh của cả kỳ
class ExportSemesterAttendanceScreen extends StatelessWidget {
  const ExportSemesterAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Xuất điểm danh"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.gutter),
        child: Column(
          spacing: context.gutter,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SemesterPicker(),
            _ExportRunButton(),
            Divider(),
            _SaveButton(),
            _ShareButton(),
          ],
        ),
      ),
    );
  }
}

class _ExportRunButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semester = ref.watch(SemesterNotifier.provider);

    final state = ref.watch(_mutation);
    final enabled = switch (state) {
      MutationPending() => false,
      _ => semester != null,
    };

    final iconData = switch (state) {
      MutationSuccess() => Icon(Symbols.check),
      MutationIdle() => Icon(Symbols.save),
      MutationError() => Icon(Symbols.error),
      MutationPending() => CircularProgressIndicator(),
    };

    callback() async {
      _mutation.run(ref, (tsx) async {
        assert(semester != null, "Chưa chọn học kỳ");
        final provider = semesterAttendanceXlsxProvider(semester!.id).future;
        final file = await tsx.get(provider);
        return file;
      });
    }

    return FilledButton.icon(
      onPressed: enabled ? callback : null,
      icon: iconData,
      label: Text("Xuất file"),
    );
  }
}

class _SaveButton extends ConsumerWidget {
  static const title = Text("Lưu file");
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_mutation);
    switch (state) {
      case MutationSuccess(value: final file):
        return OutlinedButton(
          onPressed: () {
            FilePicker.platform.saveFile(
              fileName: file.path,
              bytes: file.bytes,
            );
          },
          child: title,
        );
      default:
        return OutlinedButton(onPressed: null, child: title);
    }
  }
}

class _ShareButton extends ConsumerWidget {
  static const title = Text("Chia sẻ");
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_mutation);
    switch (state) {
      case MutationSuccess(value: final file):
        return OutlinedButton(
          onPressed: () {
            final shareParams = ShareParams(
              fileNameOverrides: [file.path],
              files: [
                XFile.fromData(
                  file.bytes,
                  name: file.path,
                  mimeType: "application/zip",
                ),
              ],
            );
            SharePlus.instance.share(shareParams);
          },
          child: title,
        );
      default:
        return OutlinedButton(onPressed: null, child: title);
    }
  }
}
