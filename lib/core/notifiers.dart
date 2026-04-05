/// Common state notifier, for quick creation of input fields
///
/// Exports: [StringNotifier], [IntNotifier], [DoubleNotifier], [BooleanNotifier], [NullableStateNotifier]
/// All exported the notifiers are [Notifier<T?>] (nullable).
library;

import 'package:riverpod/riverpod.dart';

class NullableStateNotifier<T> extends Notifier<T?> {
  @override
  T? build() => null;

  void setState(T? value) => state = value;
  void clearState() => state = null;
}

typedef StringNotifier<T> = NullableStateNotifier<String>;
typedef IntNotifier<T> = NullableStateNotifier<int>;
typedef DoubleNotifier<T> = NullableStateNotifier<double>;
typedef BooleanNotifier<T> = NullableStateNotifier<bool>;
