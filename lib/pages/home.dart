import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database.dart';

class CourseClassCreatePage extends StatelessWidget {
  const CourseClassCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final semesterSearchController = SearchController();
    final semesterNotifier = ValueNotifier<String?>(null);
    final courseNotifier = ValueNotifier<String?>(null);
    final classIdController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo lớp học'),
        primary: true,
      ),
      body: Center(
        child: LayoutBuilder(
          builder:
              (context, constraints) => SizedBox(
                width: constraints.maxWidth > 500 ? 500 : constraints.maxWidth,
                child: ValueListenableBuilder(
                  valueListenable: semesterNotifier,
                  builder: (context, semester, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 16,
                      children: [
                        SearchAnchor(
                          isFullScreen: false,
                          shrinkWrap: true,
                          searchController: semesterSearchController,
                          suggestionsBuilder: (context, controller) async {
                            final database = AppDatabase();
                            final semester = await database.searchSemester(
                              controller.text,
                            );
                            return [
                              for (final s in semester)
                                ListTile(
                                  title: Text(s.id),
                                  onTap: () {
                                    semesterNotifier.value = s.id;
                                    controller.closeView(s.id);
                                  },
                                ),
                            ];
                          },
                          builder: (context, controller) {
                            return TextField(
                              controller: controller,
                              decoration: const InputDecoration(
                                labelText: 'Học kỳ',
                                hintText: '20241, 20242, ...',
                              ),
                              readOnly: true,
                              onTap: () => controller.openView(),
                              onEditingComplete:
                                  () => controller.closeView(controller.text),
                            );
                          },
                        ),
                        TextField(
                          controller: classIdController,
                          decoration: const InputDecoration(
                            labelText: "Mã lớp học",
                            hintText: "Ví dụ: 192102",
                          ),
                        ),
                        TextField(
                          decoration: const InputDecoration(
                            labelText: 'Mã học phần',
                            hintText: 'MI1111, MI1112, ...',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Logic to create a class
                          },
                          child: const Text('Tạo lớp học'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Quay lại'),
                        ),
                      ],
                    );
                  },
                ),
              ),
        ),
      ),
    );
  }
}

class HomePageState extends ChangeNotifier {
  late Future<List<CourseClassData>> futureCourseClasses;

  HomePageState() {
    final database = AppDatabase();
    final managers = database.managers;
    futureCourseClasses = managers.courseClass.get();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách lớp'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome to the Home Page!',
            ),
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CourseClassCreatePage(),
                    ),
                  );
                },
                child: const Text('Go to Next Page'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
