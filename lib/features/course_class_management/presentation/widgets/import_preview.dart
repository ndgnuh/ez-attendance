import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers.dart';

/// Preview of import data
class ImportDataPreview extends ConsumerWidget {
  const ImportDataPreview({super.key});

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
