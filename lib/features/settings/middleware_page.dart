import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/router.dart';
import '../../shared/providers/local_preferences.dart';

class MiddlewarePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readyAsync = ref.watch(readyProvider);
    switch (readyAsync) {
      case AsyncLoading():
        return Center(
          child: LinearProgressIndicator(),
        );
      case AsyncError(:final error, :final stackTrace):
        print(stackTrace);
        return Center(
          child: Text(error.toString()),
        );
      default:
    }
    final ready = readyAsync.value ?? false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final router = AppRouter(context);
      if (ready) {
        router.toRealHomePage();
      } else {
        router.toInitialSetupPage();
      }
    });
    return LinearProgressIndicator();
  }
}
