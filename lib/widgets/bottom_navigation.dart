import 'package:flutter/material.dart';
import '../pages/routes.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: true,
      onTap: (index) {
        final navigator = Navigator.of(context);
        switch (index) {
          case 0:
            navigator.pushReplacementNamed(RouteNames.home);
            break;
          case 1:
            navigator.pushReplacementNamed(RouteNames.settingsHub);
            break;
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.class_),
          label: 'Lớp học',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Cài đặt',
        ),
      ],
    );
  }
}
