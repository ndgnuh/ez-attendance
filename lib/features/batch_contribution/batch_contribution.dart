/// Tính năng: add điểm tích cực hàng loạt (thường là bài tập về nhà)
library;

import 'package:checkin_tool/features/attendance/domain/dao.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';
import 'package:riverpod/experimental/mutation.dart';

import '../../core/db_consumers.dart';
import 'db.dart';

export 'db.dart' show ContributionUpdateMode, batchAddContribution;

// ─────────────────────────────── States ────────────────────────────
final _mut = Mutation<void>();

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

    final state = ref.watch(_mut);

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

            _mut.run(ref, (txn) async {
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

// ───────────────────── The batch contribution page ─────────────────────
class BatchContributionPage extends StatefulWidget {
  final int sessionId;
  const BatchContributionPage({super.key, required this.sessionId});

  @override
  State<BatchContributionPage> createState() => _BatchContributionPageState();
}

/// [BatchContributionValueInput] is a [TextFormField] that allow inputing the value to add/to set to.
class BatchContributionValueInput extends StatefulWidget {
  const BatchContributionValueInput({super.key});

  @override
  State<BatchContributionValueInput> createState() =>
      _BatchContributionValueInputState();
}

// Data model fields
enum BatchUpdateAspect { updateValue, updateMode, ids }

class BatchUpdateModel extends InheritedModel<BatchUpdateAspect> {
  final List<String> ids;
  final ContributionUpdateModes updateMode;
  final int updateValue;
  // ignore: library_private_types_in_public_api
  final _BatchUpdateScopeState state;

  const BatchUpdateModel({
    super.key,
    required super.child,
    required this.ids,
    required this.updateMode,
    // ignore: library_private_types_in_public_api
    required this.state,
    this.updateValue = 1,
  });

  @override
  bool updateShouldNotify(covariant BatchUpdateModel oldWidget) {
    return oldWidget.ids != ids ||
        oldWidget.updateMode != updateMode ||
        updateValue != oldWidget.updateValue;
  }

  @override
  bool updateShouldNotifyDependent(
    covariant BatchUpdateModel oldWidget,
    Set<BatchUpdateAspect> dependencies,
  ) {
    if (oldWidget.ids != ids && dependencies.contains(BatchUpdateAspect.ids)) {
      return true;
    }

    if (oldWidget.updateMode != updateMode &&
        dependencies.contains(BatchUpdateAspect.updateMode)) {
      return true;
    }

    if (oldWidget.updateValue != updateValue &&
        dependencies.contains(BatchUpdateAspect.updateValue)) {
      return true;
    }

    return false;
  }

  // ignore: library_private_types_in_public_api
  static _BatchUpdateScopeState actionsOf(BuildContext context) {
    final model = context.getInheritedWidgetOfExactType<BatchUpdateModel>();
    return model!.state;
  }

  static List<String> idsOf(BuildContext context) {
    return InheritedModel.inheritFrom<BatchUpdateModel>(
      context,
      aspect: BatchUpdateAspect.ids,
    )!.ids;
  }

  static ContributionUpdateModes updateModeOf(BuildContext context) {
    return InheritedModel.inheritFrom<BatchUpdateModel>(
      context,
      aspect: BatchUpdateAspect.updateMode,
    )!.updateMode;
  }

  static int updateValueOf(BuildContext context) {
    return InheritedModel.inheritFrom<BatchUpdateModel>(
      context,
      aspect: BatchUpdateAspect.updateValue,
    )!.updateValue;
  }
}

class BatchUpdateScope extends StatefulWidget {
  final Widget child;
  const BatchUpdateScope({super.key, required this.child});

  @override
  State<BatchUpdateScope> createState() => _BatchUpdateScopeState();
}

class _BatchContributionPageState extends State<BatchContributionPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: Text("Cộng điểm hàng loạt"),
      ),
      body: BatchUpdateScope(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(context.gutter),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _CourseClassId(sessionId: widget.sessionId),
                SessionConsumer(
                  sessionId: widget.sessionId,
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
                ),
                Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        BatchContributionIdsInput(),
                      ],
                    ),
                  ),
                ),
                IntrinsicHeight(
                  child: Flex(
                    direction: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: context.gutterSmall,
                    children: [
                      Flexible(
                        fit: FlexFit.tight,
                        child: BatchContributionModePicker(),
                      ),
                      Flexible(
                        fit: FlexFit.tight,
                        child: BatchContributionValueInput(),
                      ),
                    ],
                  ),
                ),
                _BatchUpdateStatus(),
                BatchContributionButton(
                  formKey: formKey,
                  sessionId: widget.sessionId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
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

class _BatchUpdateScopeState extends State<BatchUpdateScope> {
  List<String> ids = [];
  int updateValue = 1;
  ContributionUpdateModes updateMode = ContributionUpdateModes.addToValue;

  @override
  Widget build(BuildContext context) {
    return BatchUpdateModel(
      ids: ids,
      updateMode: updateMode,
      updateValue: updateValue,
      state: this,
      child: widget.child,
    );
  }

  void setIds(List<String> ids) => setState(() {
    this.ids = ids;
  });

  void setUpdateMode(ContributionUpdateModes updateMode) => setState(() {
    this.updateMode = updateMode;
  });

  void setUpdateValue(int updateValue) => setState(() {
    this.updateValue = updateValue;
  });
}

// ─────────────────────────────── Widgets ───────────────────────────────

class _BatchUpdateStatus extends StatelessWidget {
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

class _CourseClassId extends StatelessWidget {
  final int sessionId;

  const _CourseClassId({required this.sessionId});

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
