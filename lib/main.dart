import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

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

    final subThemesData = FlexSubThemesData(
      blendOnColors: true,
      inputDecoratorIsFilled: true,
      alignedDropdown: true,
      defaultRadius: context.gutterTiny,
    );

    final scheme = FlexScheme.deepBlue;

    return MaterialApp(
      title: 'Attendance Tool',
      navigatorKey: navigationKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('vi'), // French
      ],
      locale: const Locale("vi"),
      darkTheme: FlexThemeData.dark(
        scheme: scheme,
        subThemesData: subThemesData,
        keyColors: const FlexKeyColors(),
      ),
      theme: FlexThemeData.light(
        scheme: scheme,
        subThemesData: subThemesData,
        keyColors: const FlexKeyColors(),
      ),
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
