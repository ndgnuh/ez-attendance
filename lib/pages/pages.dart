import 'package:flutter/material.dart';

import 'initial_setup_page.dart';
import 'course_classes/index.dart';
import 'routes.dart';

export 'routes.dart';

MaterialPageRoute<dynamic> onGenerateRoute(RouteSettings settings) {
  final name = settings.name;

  Widget builder(BuildContext context) {
    return switch (name) {
      RouteNames.initialSetupPage => const InitialSetupPage(),
      _ => const NotFoundPage(),
    };
  }

  return MaterialPageRoute(
    builder: builder,
    settings: settings,
  );
}

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Page not found'),
      ),
    );
  }
}
