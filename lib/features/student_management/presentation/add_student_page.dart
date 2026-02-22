import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';

import '../../../core/database_service.dart';
import '../../../shared/utilities.dart';

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

  StudentCompanion get companion => StudentCompanion.insert(
    id: studentId,
    name: studentName,
    email: studentEmail,
  );

  String get studentEmail => studentEmailController.text;

  String get studentId => studentIdController.text;

  String get studentName => studentNameController.text;
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

  @override
  void dispose() {
    studentIdController.dispose();
    studentNameController.dispose();
    super.dispose();
  }

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
}
