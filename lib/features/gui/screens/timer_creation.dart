import 'package:checkin_tool/core/database_service.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/dialogs.dart';
import '../../timer/timer.dart';

class TimerCreationScreen extends StatelessWidget {
  const TimerCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("Hẹn giờ"),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(context.gutter),
        child: Column(
          spacing: context.gutter,
          children: [
            TextFormField(
              controller: controller,
            ),
            FilledButton(
              onPressed: () {
                final min = int.tryParse(controller.text);
                if (min == null) {
                  showAlert(title: "Không phải số");
                  return;
                }

                final ref = ProviderScope.containerOf(context);
                final currentTimer = ref.read(currentTimerProvider);
                if (currentTimer?.isActivate ?? false) {
                  showAlert(title: "Một đồng hồ khác đang chạy");
                  return;
                }

                final notifier = ref.read(currentTimerProvider.notifier);
                final timer = VibrationTimer(duration: Duration(minutes: min));
                notifier.set(timer);
                timer.start();
              },
              child: Text("Hẹn giờ"),
            ),
            _TimeLeft(),
          ],
        ),
      ),
    );
  }
}

/// TODO: make this into a button, that shows current time left if a timer is active
/// Otherwise, it is a button to move to the timer creation page.
class _TimeLeft extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeLeft = ref.watch(currentTimeLeftProvider);
    if (timeLeft == null) {
      return Text("Không có đồng hồ đếm ngược");
    }
    final seconds = timeLeft.inSeconds;
    final minutes = (seconds / 60).floor();
    final secondsAfterMinutes = seconds - minutes * 60;
    final minuteString = minutes.toString().padLeft(2, "0");
    final secondString = secondsAfterMinutes.toString().padLeft(2, "0");
    return Text("$minuteString:$secondString");
  }
}
