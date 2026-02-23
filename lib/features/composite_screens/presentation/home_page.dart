import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../../../core/router.dart';
import '../../../design.dart';
import '../../course_class_management/course_class_management.dart';

class HomePage extends StatelessWidget {
  final tabs = const [
    Tab(text: "Lớp học"),
    Tab(text: "Cài đặt"),
  ];

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Trang chính"),
          bottom: TabBar(
            tabs: tabs,
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: [
            CourseClassListTabView(),
            _SettingsTab(),
          ],
        ),
      ),
    );
  }
}

class _SettingsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = AppRouter(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(context.gutter),
      child: Column(
        children: [
          CourseClassManagementPanel(),
          CardSection(
            title: "Cài đặt",
            children: [
              ListTile(
                title: Text("Cài đặt"),
                subtitle: Text("Tới trang cài đặt"),
                onTap: () {
                  router.toInitialSetupPage();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
