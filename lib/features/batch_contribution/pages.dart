// ───────────────────── The batch contribution page ─────────────────────
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:material_ui/material_ui.dart';

import 'models.dart';
import 'widgets.dart';

class BatchContributionPage extends StatefulWidget {
  final int sessionId;
  const BatchContributionPage({super.key, required this.sessionId});

  @override
  State<BatchContributionPage> createState() => _BatchContributionPageState();
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
                CourseClassId(sessionId: widget.sessionId),
                SessionTime(sessionId: widget.sessionId),
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
                BatchUpdateStatus(),
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
