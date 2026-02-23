import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/export_logic.dart';

class ExportClassAttendanceButton extends ConsumerWidget {
  final int courseClassId;
  const ExportClassAttendanceButton({super.key, required this.courseClassId});

  static const title = Text("Lưu điểm danh");
  static const subtitle = Text("Lưu điểm chuyên cần, tích cực của lớp");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = classAttendanceXlsxProvider(courseClassId);
    final xlsxAsync = ref.watch(provider);

    switch (xlsxAsync) {
      case AsyncLoading():
        return ListTile(
          title: title,
          subtitle: subtitle,
          trailing: CircularProgressIndicator(),
          enabled: false,
        );

      case AsyncError(:final error, :final stackTrace):
        if (kDebugMode) {
          print(stackTrace);
        }
        return ListTile(
          title: title,
          subtitle: Text(error.toString()),
          enabled: false,
        );

      case AsyncData(value: final file):
        return ListTile(
          title: title,
          subtitle: subtitle,
          onTap: () async {
            FilePicker.platform.saveFile(
              bytes: file.bytes,
              fileName: file.path,
              allowedExtensions: [".xlsx"],
            );
          },
        );
    }
  }
}

/// A button to share attendance class
/// TODO: merge with the above button, make title and final behaviour not static
class ShareClassAttendanceButton extends ConsumerWidget {
  final int courseClassId;
  const ShareClassAttendanceButton({super.key, required this.courseClassId});

  static const title = Text("Chia sẻ điểm danh");
  static const subtitle = Text("Chia sẻ điểm chuyên cần, tích cực của lớp");

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = classAttendanceXlsxProvider(courseClassId);
    final xlsxAsync = ref.watch(provider);

    switch (xlsxAsync) {
      case AsyncLoading():
        return ListTile(
          title: title,
          subtitle: subtitle,
          trailing: CircularProgressIndicator(),
          enabled: false,
        );

      case AsyncError(:final error, :final stackTrace):
        if (kDebugMode) {
          print(stackTrace);
        }
        return ListTile(
          title: title,
          subtitle: Text(error.toString()),
          enabled: false,
        );

      case AsyncData(value: final file):
        return ListTile(
          title: title,
          subtitle: subtitle,
          onTap: () async {
            final shareParams = ShareParams(
              fileNameOverrides: [file.path],
              files: [
                XFile.fromData(
                  file.bytes,
                  name: file.name,
                  mimeType:
                      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                ),
              ],
            );
            SharePlus.instance.share(shareParams);
          },
        );
    }
  }
}
