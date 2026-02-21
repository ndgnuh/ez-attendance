import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../core/router.dart';
import '../../../shared/providers/local_preferences.dart';

/// This page is just a page to check if initial setting
/// has been setup (e.g. where the database is). If not, move to
/// The initial setup screen, otherwise, move to the real home page.
class MiddlewarePage extends ConsumerWidget {
  const MiddlewarePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final readyAsync = ref.watch(readyProvider);
    switch (readyAsync) {
      case AsyncLoading():
        return Center(
          child: LinearProgressIndicator(),
        );
      case AsyncError(:final error, :final stackTrace):
        if (kDebugMode) {
          print(stackTrace);
        }
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
