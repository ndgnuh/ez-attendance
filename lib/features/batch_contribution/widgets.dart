import 'package:flutter/services.dart';
import 'package:flutter_riverpod/experimental/mutation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../core/database_service.dart';
import '../../core/db_consumers.dart';
import 'db.dart';
import 'models.dart';

class BatchContributionButton extends ConsumerWidget {
  final GlobalKey<FormState> formKey;
  final int sessionId;

  const BatchContributionButton({
    super.key,
    required this.formKey,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    final updateModeEnum = BatchUpdateModel.updateModeOf(context);
    final updateValue = BatchUpdateModel.updateValueOf(context);
    final studentIds = BatchUpdateModel.idsOf(context);

    final state = ref.watch(batchContributionMutation);

    switch (state) {
      case MutationIdle():
        return FilledButton.icon(
          onPressed: () {
            final ok = formKey.currentState?.validate() ?? false;
            if (!ok) return;

            // Get update mode
            final updateMode = switch (updateModeEnum) {
              ContributionUpdateModes.setToValue =>
                ContributionUpdateMode.setToValue(updateValue),
              ContributionUpdateModes.addToValue =>
                ContributionUpdateMode.addValue(updateValue),
            };

            batchContributionMutation.run(ref, (txn) async {
              final db = await txn.get(databaseProvider.future);

              await batchAddContribution(
                db: db,
                sessionId: sessionId,
                studentIds: studentIds,
                mode: updateMode,
              );
              navigator.pop();
              messenger.showSnackBar(
                SnackBar(content: Text("Cập nhật thành công")),
              );
            });
          },
          label: Text("Chạy"),
        );
      case MutationPending<void>():
        return FilledButton.icon(
          onPressed: null,
          icon: CircularProgressIndicator(),
          label: Text("Đang xử lý"),
        );
      case MutationError<void>(:final error, :final stackTrace):
        return Text("Lỗi :$error\n$stackTrace");
      case MutationSuccess<void>():
        return FilledButton.icon(
          onPressed: () => Navigator.pop(context),
          label: Text("Quay lại"),
        );
    }
  }
}

class BatchUpdateStatus extends StatelessWidget {
  const BatchUpdateStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final ids = BatchUpdateModel.idsOf(context);
    final updatevalue = BatchUpdateModel.updateValueOf(context);
    final updateMode = BatchUpdateModel.updateModeOf(context);
    final updateString = switch (updateMode) {
      ContributionUpdateModes.setToValue => "Đặt điểm tích cực bằng",
      ContributionUpdateModes.addToValue => "Cộng",
    };
    return ListTile(
      title: Text("Hành động"),
      subtitle: Text(
        "$updateString $updatevalue điểm cho ${ids.length} sinh viên",
      ),
    );
  }
}

class CourseClassId extends StatelessWidget {
  final int sessionId;

  const CourseClassId({super.key, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    return SessionConsumer(
      sessionId: sessionId,
      builder: (context, session) {
        return CourseClassConsumer(
          id: session.courseClassId,
          builder: (context, courseClass) {
            return ListTile(
              title: Text("Lớp"),
              subtitle: Text(courseClass.classCode),
            );
          },
        );
      },
    );
  }
}

/// [BatchContributionValueInput] is a [TextFormField] that allow inputing the value to add/to set to.
class BatchContributionValueInput extends StatefulWidget {
  const BatchContributionValueInput({super.key});

  @override
  State<BatchContributionValueInput> createState() =>
      _BatchContributionValueInputState();
}

class _BatchContributionValueInputState
    extends State<BatchContributionValueInput> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = BatchUpdateModel.updateValueOf(context);
    final valueString = value.toString();

    if (valueString != controller.text) {
      controller.text = value.toString();
    }
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(label: Text("Giá trị thay đổi")),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (String? valueText) {
        final result = int.tryParse(valueText ?? "");
        if (result == null) {
          return "Cần nhập số";
        }
        return null;
      },
      onChanged: (String valueText) {
        switch (int.tryParse(valueText)) {
          case int value:
            final actions = BatchUpdateModel.actionsOf(context);
            actions.setUpdateValue(value);
          case null:
            // Only try to correct non-empty text
            // otherwise it will be very annoying
            if (controller.text.isNotEmpty) {
              controller.text = value.toString();
            }
        }
      },
    );
  }
}

/// [BatchContributionIdsInput] is a [TextFormField] that allow inputing student ids for the bathc operation.
class BatchContributionIdsInput extends StatelessWidget {
  const BatchContributionIdsInput({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(label: Text("Nhập mã sinh viên")),
      maxLines: null,
      validator: (_) {
        final ids = BatchUpdateModel.idsOf(context);
        if (ids.isEmpty) {
          return "Chưa có MSV nào";
        }
        return null;
      },
      onChanged: (String value) {
        final ids = value.split(RegExp("[\n ,|;]+"));
        final fids = ids.where((id) => id.trim().isNotEmpty).toList();
        final actions = BatchUpdateModel.actionsOf(context);
        print(fids);
        actions.setIds(fids);
      },
    );
  }
}

/// [BatchContributionModePicker] is a dropdown that allow selecting the contribution mode in [ContributionUpdateModes].
class BatchContributionModePicker extends StatelessWidget {
  const BatchContributionModePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final dropdownMenuEntries = [
      for (final mode in ContributionUpdateModes.values)
        DropdownMenuEntry(value: mode, label: mode.toString()),
    ];
    return DropdownMenuFormField(
      expandedInsets: EdgeInsets.zero,
      onSelected: (value) {
        final actions = BatchUpdateModel.actionsOf(context);
        if (value != null) {
          actions.setUpdateMode(value);
        }
      },
      initialSelection: BatchUpdateModel.updateModeOf(context),
      dropdownMenuEntries: dropdownMenuEntries,
    );
  }
}

class SessionTime extends StatelessWidget {
  final int sessionId;

  const SessionTime({
    super.key,
    required this.sessionId,
  });

  @override
  Widget build(BuildContext context) {
    return SessionConsumer(
      sessionId: sessionId,
      builder: (context, session) {
        final timeFormat = DateFormat("HH:MM");

        final startTime = timeFormat.format(session.startTime);
        final endTime = timeFormat.format(session.endTime);
        final day = DateFormat(
          "dd/mm/yyyy",
        ).format(session.startTime);

        return ListTile(
          title: Text("Thời gian"),
          subtitle: Text("$day, $startTime - $endTime"),
        );
      },
    );
  }
}
