import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../../database/database.dart';
import '../../design.dart';
import '../../providers.dart';
import '../routes.dart';

class CourseClassCreatePage extends StatelessWidget {
  static const routeName = RouteNames.courseClassCreate;
  const CourseClassCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ConstrainedAppBar(
        child: AppBar(
          title: const Text('Tạo lớp học'),
          primary: true,
        ),
      ),
      body: ConstrainedBody(
        child: Padding(
          padding: EdgeInsets.all(context.gutter),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: context.gutter,
            children: [Expanded(child: _Form())],
          ),
        ),
      ),
    );
  }
}

class _Form extends HookConsumerWidget {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final semesterController = useState<SemesterData?>(null);
    final semesterFormatController = useTextEditingController();
    final courseIdController = useSearchController();
    final createNewCourse = useState(false);
    final courseNameController = useTextEditingController();
    final classCodeController = useTextEditingController();

    void setSemester(SemesterData semester) {
      semesterController.value = semester;
      semesterFormatController.text = semester.name;
    }

    void clearSemester() {
      semesterController.value = null;
      semesterFormatController.text = '';
    }

    return Form(
      key: formKey,
      child: Column(
        spacing: context.gutter,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              spacing: context.gutter,
              children: [
                /// Nhập học kỳ
                Expanded(
                  child: SearchAnchor(
                    suggestionsBuilder: (context, controller) async {
                      final db = await ref.watch(databaseProvider.future);
                      final stmt = db.searchSemester(
                        searchText: controller.text,
                      );
                      final semesters = await stmt.get();
                      final notifier = ref.read(creationProvider.notifier);

                      final createNew = ListTile(
                        leading: const Icon(Symbols.add),
                        title: const Text("Tạo mới"),
                        subtitle: Text(
                          'Tạo học kỳ với tên "${controller.text}"',
                        ),
                        onTap: () async {
                          final semester = await notifier.insertSemester(
                            controller.text,
                          );
                          controller.closeView(null);
                          setSemester(semester);
                        },
                      );

                      return [
                        for (final semester in semesters)
                          ListTile(
                            leading: Icon(null),
                            title: Text(semester.name),
                            subtitle: Text(
                              'Chọn học kỳ ${semester.name} [ID: ${semester.id}]',
                            ),
                            onTap: () {
                              controller.closeView(null);
                              setSemester(semester);
                            },
                          ),
                        if (controller.text.isNotEmpty) createNew,
                      ];
                    },
                    builder:
                        (context, controller) => TextFormField(
                          controller: semesterFormatController,
                          validator: (value) {
                            if (semesterController.value == null) {
                              return 'Vui lòng chọn học kỳ';
                            }
                            return null;
                          },
                          readOnly: true,
                          onTap: () => controller.openView(),
                          decoration: const InputDecoration(
                            labelText: 'Học kỳ',
                          ),
                        ),
                  ),
                ),

                if (semesterController.value != null)
                  TextButton.icon(
                    onPressed: clearSemester,
                    icon: const Icon(Icons.clear),
                    label: Text('Xóa'),
                  ),
              ],
            ),
          ),

          // Nhập học phần
          SearchAnchor(
            searchController: courseIdController,
            suggestionsBuilder: (context, controller) async {
              final db = await ref.watch(databaseProvider.future);
              final stmt = db.searchCourse(searchText: controller.text);
              final courses = await stmt.get();

              final createNew = ListTile(
                leading: const Icon(Symbols.add),
                title: const Text("Tạo mới"),
                subtitle: Text('Tạo học phần với mã "${controller.text}"'),
                onTap: () {
                  createNewCourse.value = true;
                  controller.closeView(controller.text.trim());
                },
              );

              return [
                if (controller.text.isNotEmpty) createNew,
                for (final course in courses)
                  ListTile(
                    title: Text(course.name),
                    subtitle: Text(course.id),
                    onTap: () {
                      courseIdController.text = course.id;
                      courseNameController.text = course.name;
                      createNewCourse.value = false;
                      Navigator.of(context).pop();
                    },
                  ),
              ];
            },
            builder: (context, controller) {
              final focusNode = FocusNode();
              focusNode.addListener(() {
                if (focusNode.hasFocus && createNewCourse.value) {
                  controller.selection = TextSelection(
                    baseOffset: 0,
                    extentOffset: controller.text.length,
                  );
                  controller.openView();
                }
              });

              return TextFormField(
                controller: courseIdController,
                readOnly: createNewCourse.value ? false : true,
                onTap: () => controller.openView(),
                focusNode: focusNode,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Vui lòng nhập mã học phần';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Mã học phần',
                ),
              );
            },
          ),

          // Tên học phần
          TextFormField(
            controller: courseNameController,
            readOnly: createNewCourse.value ? false : true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Vui lòng nhập tên học phần';
              }
              return null;
            },
            decoration: const InputDecoration(labelText: 'Tên học phần'),
          ),

          // Mã lớp học
          TextFormField(
            controller: classCodeController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Vui lòng nhập mã lớp';
              }
              return null;
            },
            decoration: const InputDecoration(
              labelText: 'Mã lớp học',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              /* Validate form fields */
              final ok = formKey.currentState?.validate() ?? false;
              if (!ok) {
                return;
              }

              final notifier = ref.read(creationProvider.notifier);

              /// Insert course if needed
              final CourseData course;
              final courseId = courseIdController.text.trim();
              switch (createNewCourse.value) {
                case true:
                  course = await notifier.insertCourse(
                    courseId: courseId,
                    courseName: courseNameController.text.trim(),
                  );
                case false:
                  course = await ref.watch(
                    courseByIdProvider(courseId).future,
                  );
              }

              final classCode = classCodeController.text.trim();
              notifier.insertCourseClass(
                semester: semesterController.value!,
                course: course,
                classCode: classCode,
              );

              Navigator.pop(context);
            },
            child: const Text('Tạo lớp học'),
          ),
        ],
      ),
    );
  }
}
