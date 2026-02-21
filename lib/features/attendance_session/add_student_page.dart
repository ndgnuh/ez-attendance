import 'package:checkin_tool/features/attendance_session/data_model.dart';
import 'package:checkin_tool/shared/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../core/database_service.dart';
import '../../shared/utilities.dart';

Future<StudentCompanion?> showAddStudentDialog({
  required BuildContext context,
  required String? studentId,
}) async {
  return await showDialog(
    context: context,
    builder: (context) => _AddStudentDialog(studentId: studentId),
  );
}

/// This is a "multi-purpose" page. Other site navigate
/// to this page and expect a [StudentCompanion?] to be returned.
class AddStudentPage extends StatefulWidget {
  final String? studentId;
  final Widget? title;
  final String? titleText;

  const AddStudentPage({
    super.key,
    this.studentId,
    this.title,
    this.titleText,
  });

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final TextEditingController studentIdController = TextEditingController();
  final TextEditingController studentNameController = TextEditingController();
  final TextEditingController studentEmailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    studentIdController.text = widget.studentId ?? "";
    studentNameController.addListener(_autoEmail);
    studentIdController.addListener(_autoEmail);
  }

  void _autoEmail() {
    studentEmailController.text = autoEmail(
      studentName: studentName,
      studentId: studentId,
    );
  }

  @override
  void dispose() {
    studentIdController.dispose();
    studentNameController.dispose();
    super.dispose();
  }

  String get studentName => studentNameController.text;
  String get studentId => studentIdController.text;
  String get studentEmail => studentEmailController.text;
  StudentCompanion get companion => StudentCompanion.insert(
    id: studentId,
    name: studentName,
    email: studentEmail,
  );

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    final titleText = widget.titleText ?? "Thêm sinh viên";
    final title = widget.title ?? Text(titleText);

    return Scaffold(
      appBar: AppBar(title: title),
      body: Padding(
        padding: EdgeInsets.all(context.gutter),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // move the form to bottom, looks weird but good
              Spacer(),

              // The main form
              SingleChildScrollView(
                child: Column(
                  spacing: context.gutter,
                  children: [
                    TextFormField(
                      controller: studentIdController,
                      decoration: InputDecoration(
                        labelText: "Mã sinh viên",
                      ),
                    ),
                    TextFormField(
                      controller: studentNameController,
                      decoration: InputDecoration(
                        labelText: "Họ tên sinh viên",
                      ),
                    ),
                    TextFormField(
                      readOnly: true,
                      controller: studentEmailController,
                      decoration: InputDecoration(
                        labelText: "Email (tự động)",
                      ),
                    ),
                  ],
                ),
              ),

              // End main form
              SizedBox(height: context.gutter),
              FilledButton(
                onPressed: () => navigator.pop(companion),
                child: Text("Lưu"),
              ),
              OutlinedButton(
                onPressed: () => navigator.pop(),
                child: Text("Hủy"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddStudentDialog extends StatefulWidget {
  final String? studentId;
  const _AddStudentDialog({this.studentId});

  @override
  State<_AddStudentDialog> createState() => _AddStudentDialogState();
}

class _AddStudentDialogState extends State<_AddStudentDialog> {
  final TextEditingController studentNameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController studentIdController = TextEditingController();

  StudentCompanion get studentCompanion {
    final studentName = studentNameController.text;
    final studentId = studentIdController.text;
    return StudentCompanion.insert(
      id: studentId,
      email: autoEmail(studentName: studentName, studentId: studentId),
      name: studentName,
    );
  }

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    return AlertDialog(
      title: Text("Thêm sinh viên"),
      content: IntrinsicHeight(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            spacing: context.gutterSmall,
            children: [
              TextFormField(
                readOnly: widget.studentId != null,
                controller: studentIdController,
                validator: validateNotEmpty,
                decoration: InputDecoration(
                  labelText: "Mã sinh viên",
                ),
              ),
              TextFormField(
                controller: studentNameController,
                validator: validateNotEmpty,
                decoration: InputDecoration(
                  labelText: "Họ tên",
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => navigator.pop(), child: Text("Hủy")),
        TextButton(
          onPressed: () {
            if (formKey.currentState?.validate() == true) {
              navigator.pop(studentCompanion);
            }
          },
          child: Text("OK"),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    studentNameController.dispose();
    studentIdController.dispose();
    formKey.currentState?.dispose();
  }

  @override
  void initState() {
    super.initState();
    studentIdController.text = widget.studentId ?? "";
  }

  String? validateNotEmpty(String? value) {
    value ??= "";
    if (value.trim().isEmpty) {
      return "Không được bỏ trống";
    }
    return null;
  }
}
