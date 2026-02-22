import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cài đặt"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(context.gutter),
        child: Column(
          children: [
            SwitchListTile(
              title: Text("Dark mode"),
              subtitle: Text("Đang sử dụng giao diện tối"),
              value: true,
              onChanged: (_) {},
            ),
            ListTile(
              title: Text("CSDL"),
              subtitle: Text("Chọn cơ sở dữ liệu"),
            ),
            ListTile(
              title: Text("Cấp quyền camera"),
              subtitle: Text("Sử dụng camera để quét mã"),
            ),
          ],
        ),
      ),
    );
  }
}
