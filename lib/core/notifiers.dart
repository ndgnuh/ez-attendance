/// Common state notifier, for quick creation of input fields
///
/// Exports: [StringNotifier], [IntNotifier], [DoubleNotifier], [BooleanNotifier], [NullableStateNotifier]
/// All exported the notifiers above are [Notifier<T?>] (nullable).
///
/// Non-nullable variants requiring a default state: [RequiredStateNotifier],
/// [RequireStringNotifier], [RequireIntNotifier], [RequireDoubleNotifier], [RequireBooleanNotifier]
library;

import 'package:riverpod/riverpod.dart';

class NullableStateNotifier<T> extends Notifier<T?> {
  @override
  T? build() => null;

  void setState(T? value) => state = value;
  void clearState() => state = null;
}

/// A non-nullable [Notifier] whose initial state is [defaultState].
class RequiredStateNotifier<T> extends Notifier<T> {
  RequiredStateNotifier(this.defaultState);

  final T defaultState;

  @override
  T build() => defaultState;

  void setState(T value) => state = value;
  void resetState() => state = defaultState;
}

typedef StringNotifier<T> = NullableStateNotifier<String>;
typedef IntNotifier<T> = NullableStateNotifier<int>;
typedef DoubleNotifier<T> = NullableStateNotifier<double>;
typedef BooleanNotifier<T> = NullableStateNotifier<bool>;

typedef RequireStringNotifier = RequiredStateNotifier<String>;
typedef RequireIntNotifier = RequiredStateNotifier<int>;
typedef RequireDoubleNotifier = RequiredStateNotifier<double>;
typedef RequireBooleanNotifier = RequiredStateNotifier<bool>;
