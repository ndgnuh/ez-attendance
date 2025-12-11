import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'pages/pages.dart';
import 'providers/local_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  runApp(const ProviderScope(child: MyApp()));
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

    final theme = darkMode ? ThemeData.dark() : ThemeData.light();

    return MaterialApp(
      title: 'Attendance Tool',
      theme: theme,
      initialRoute: RouteNames.home,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
