import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../core/router.dart';
import '../../../design.dart';

class CourseClassManagementPanel extends StatelessWidget {
  const CourseClassManagementPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter(context);
    final buttons = [
      ListTile(
        leading: Icon(Symbols.add_rounded),
        title: Text('Tạo lớp'),
        subtitle: Text('Tạo lớp học mới'),
        onTap: () => router.toCourseClassCreatePage(),
      ),

      ListTile(
        leading: Icon(Symbols.upload_file_rounded),
        title: Text('Nhập lớp từ file'),
        subtitle: Text('Nhập file xlsx'),
        onTap: () => router.toCourseClassImportPage(),
      ),
    ];

    return CardSection(title: "Danh mục lớp", children: buttons);
  }
}
