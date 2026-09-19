import 'package:checkin_tool/theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import './core/router.dart';
import './shared/context.dart';
import './core/preference_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'vi_VN';

  runApp(
    ProviderScope(
      retry: (int times, exc) {
        return null;
      },
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final useDarkModeAsync = ref.watch(useDarkModeProvider);
    final themeMode = useDarkModeAsync.when(
      data:
          (useDarkMode) => switch (useDarkMode) {
            null => ThemeMode.system,
            true => ThemeMode.dark,
            false => ThemeMode.light,
          },
      loading: () => ThemeMode.system,
      error: (e, st) => ThemeMode.system,
    );

    // final scheme = FlexScheme.deepBlue;
    FlexScheme.blue;

    return MaterialApp(
      title: 'Attendance Tool',
      navigatorKey: navigationKey,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        // Locale('en', "US"), // English
        Locale('vi', "VN"), // Vietnamese
      ],
      // locale: const Locale("vi"),
      darkTheme: AppTheme.dark,
      theme: AppTheme.light,
      themeMode: themeMode,
      home: AppRouter(context).homePage(),
      builder:
          (context, child) => SafeArea(
            child: child ?? SizedBox.shrink(),
          ),
      // initialRoute: initialRoute,
      // onGenerateRoute: onGenerateRoute,
    );
  }
}
