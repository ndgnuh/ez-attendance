import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import './core/router.dart';
import './shared/context.dart';
import './shared/providers/local_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'vi_VN';

  // File("./db.sqlite").deleteSync();

  // final db = AppDatabase();
  // final s = await db.managers.semester.get();
  //
  // db.course.insertAll([
  //   CourseCompanion.insert(id: 'MI1111', name: 'Giải tích I'),
  //   CourseCompanion.insert(id: 'MI1112', name: 'Giải tích I'),
  //   CourseCompanion.insert(id: 'MI1113', name: 'Giải tích I'),
  //   CourseCompanion.insert(id: 'MI1114', name: 'Giải tích I'),
  //   CourseCompanion.insert(id: 'MI1111E', name: 'Giải tích I'),
  // ]);
  // print(s);

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
    final darkMode = useDarkModeAsync.when(
      data: (useDarkMode) => useDarkMode ?? false,
      loading: () => false,
      error: (e, st) => false,
    );

    final buttonShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.zero,
    );
    ThemeData theme = darkMode ? ThemeData.dark() : ThemeData.light();
    theme = theme.copyWith(
      // remove all the rounded corners
      cardTheme: theme.cardTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      dialogTheme: theme.dialogTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      buttonTheme: theme.buttonTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: buttonShape,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: buttonShape,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          shape: buttonShape,
        ),
      ),
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
