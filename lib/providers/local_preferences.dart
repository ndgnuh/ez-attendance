import 'dart:async';

import 'package:riverpod/riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final appStoragePathProvider = AsyncNotifierProvider(
  () => StringPreferenceNotifier('app_storage_path'),
);

final appDatabasePathProvider = AsyncNotifierProvider(
  () => StringPreferenceNotifier('app_database_path'),
);

final useDarkModeProvider = AsyncNotifierProvider(
  () => BoolPreferenceNotifier('use_dark_mode', false),
);

sealed class PreferenceNotifier<T> extends AsyncNotifier<T?> {
  final String name;
  final T? initialValue;
  PreferenceNotifier(this.name, [this.initialValue]);

  T? getValue(SharedPreferences prefs);
  void setValue(SharedPreferences prefs, T value);

  @override
  FutureOr<T?> build() async {
    final prefs = await SharedPreferences.getInstance();
    return getValue(prefs);
  }

  void set(T value) async {
    final prefs = await SharedPreferences.getInstance();
    setValue(prefs, value);
    state = AsyncData(value);
  }
}

class BoolPreferenceNotifier extends PreferenceNotifier<bool> {
  BoolPreferenceNotifier(super.name, [super.initialValue]);

  @override
  bool? getValue(SharedPreferences prefs) {
    return prefs.getBool(name) ?? initialValue;
  }

  @override
  void setValue(SharedPreferences prefs, bool value) {
    prefs.setBool(name, value);
  }
}

class StringPreferenceNotifier extends PreferenceNotifier<String> {
  StringPreferenceNotifier(super.name, [super.initialValue]);

  @override
  String? getValue(SharedPreferences prefs) {
    return prefs.getString(name) ?? initialValue;
  }

  @override
  void setValue(SharedPreferences prefs, String value) {
    prefs.setString(name, value);
  }
}
