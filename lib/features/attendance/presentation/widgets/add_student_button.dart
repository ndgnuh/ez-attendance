import 'package:material_ui/material_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/router.dart';
import './../../domain/dao.dart';

class AddStudentButton extends StatelessWidget {
  final int sessionId;
  final Widget Function(BuildContext context, VoidCallback onPressed) builder;

  const AddStudentButton({
    super.key,
    required this.sessionId,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    final router = AppRouter(context);
    return builder(
      context,
      () async {
        final ref = ProviderScope.containerOf(context);

        final companion = await router.toAddStudentPage();
        if (companion == null) {
          return;
        }

        final db = await ref.read(databaseProvider.future);
        await db.addStudent(
          sessionId: sessionId,
          studentCompanion: companion,
        );
      },
    );
  }
}
