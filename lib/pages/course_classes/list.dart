import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../../database.dart';
import './index.dart';
import '../../providers.dart';

final selectedSemesterNotifier = ValueNotifier<String?>(null);

class SemesterPicker extends ConsumerWidget {
  const SemesterPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text("TODO");
    // final semesterState = ref.watch(semestersProvider);
    // switch (semesterState) {
    //   case AsyncLoading():
    //     return const CircularProgressIndicator();
    //   case AsyncError():
    //     return const CircularProgressIndicator();
    //   default:
    // }
    //
    // final semesters = semesterState.value!.toList();
    //
    // return DropdownMenu(
    //   expandedInsets: EdgeInsets.zero,
    //   label: const Text('Học kỳ'),
    //   onSelected: (value) {
    //     selectedSemesterNotifier.value = value;
    //   },
    //   dropdownMenuEntries: [
    //     for (final semester in semesters)
    //       DropdownMenuEntry(
    //         value: semester,
    //         label: semester,
    //       ),
    //   ],
    // );
  }
}

// class CourseClassListView extends StatelessWidget {
//   // final List<CourseClassData> classes;
//
//   const CourseClassListView({
//     super.key,
//     required this.classes,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     if (classes.isEmpty) {
//       final textTheme = TextTheme.of(context);
//       final style = textTheme.bodyMedium?.copyWith(
//         fontSize: 24,
//         fontWeight: FontWeight.bold,
//         color: Colors.grey,
//       );
//       return Expanded(
//         child: Center(
//           child: Text(
//             "Không có lớp học",
//             style: style,
//           ),
//         ),
//       );
//     }
//     return ListView.builder(
//       itemCount: classes.length,
//       itemBuilder: (context, index) {
//         final classData = classes[index];
//         return ListTile(
//           title: Text(classData.id),
//           subtitle: Text(classData.name),
//         );
//       },
//     );
//   }
// }

class _GoToCreate extends StatelessWidget {
  const _GoToCreate();

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CourseClassCreatePage(),
          ),
        );
      },
      label: const Text('Tạo lớp học'),
    );
  }
}

class CourseClassListPage extends StatelessWidget {
  static const routeName = '/';
  const CourseClassListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách lớp'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(context.gutter),
            child: IntrinsicHeight(
              child: Row(
                spacing: context.gutter,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SemesterPicker(),
                  ),
                  _GoToCreate(),
                ],
              ),
            ),
          ),
          // CourseClassListView(classes: []),
        ],
      ),
    );
  }
}
