import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

export 'routes.dart';

final initialRoute = switch (kReleaseMode) {
  true => RouteNames.initialSetupPage,
  false => "/",
};

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
