import 'package:shared_preferences/shared_preferences.dart';

/// This service handles app preferences
class PreferenceService {
  // Singleton
  PreferenceService._init();
  static final PreferenceService _instance = PreferenceService._init();

  // Instance getter
  PreferenceService get instance => _instance;
  factory PreferenceService() {
    return _instance;
  }

  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  /// Get database path as nullable
  /// if null then the path needs to be setup
  Future<String?> getDatabasePath() async {
    return (await prefs).getString('app_database_path');
  }

  /// Same as [getDatabasePath], but ensure the path is not null
  /// only use this function in inner screens
  Future<String> requireDatabasePath() async {
    return (await getDatabasePath()) as String;
  }

  Future<bool> getDarkMode() async {
    return (await prefs).getBool('use_dark_mode') ?? false;
  }

  Future<bool> setDarkMode(bool value) async {
    return (await prefs).setBool('use_dark_mode', value);
  }

  Future<void> toggleDarkMode() async {
    final dm = await getDarkMode();
    setDarkMode(!dm);
  }
}
