import 'package:riverpod/riverpod.dart';

/// This is the root provider container
final ref = ProviderContainer(
  // no retry
  retry: (count, error) {
    return null;
  },
);
