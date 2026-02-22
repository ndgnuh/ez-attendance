import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';

import '../../../../core/router.dart';
import './../../domain/dao.dart';

class AddStudentButton extends StatelessWidget {
  final int sessionId;

  const AddStudentButton({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter(context);
    return IconButton(
      onPressed: () async {
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
      icon: Icon(Symbols.add),
    );
  }
}
