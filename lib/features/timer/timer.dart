/// Đếm ngược thời gian làm bài của sinh viên
library;

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';
import 'package:riverpod/riverpod.dart';

/// Provide the current [VibrationTimer].
/// Allow setting the current timer to something.
final currentTimerProvider = NotifierProvider(CurrentTimerNotifer.new);

/// Provide the current [timeLeft] of the current vibration timer
/// This is better than [StreamProvider] solution, it does not use stream, and it is instant (no weird loading time)
// final currentTimeLeftProvider = NotifierProvider(_TimeLeftNotifier.new);
final currentTimeLeftProvider = Provider((ref) {
  final timer = ref.watch(currentTimerProvider);
  final stream = timer?.updateStreamController.stream;

  // Watch for update
  final sub = stream?.listen((newTimer) {
    ref.invalidateSelf();
  });

  // Cancel subscription on update
  ref.onDispose(() => sub?.cancel());

  return timer?.timeLeft;
});

void setVibrationTimer({
  required final Ref ref,
  required final Duration duration,
}) {
  final timer = ref.read(currentTimerProvider);
  if (timer?.isActivate ?? false) {
    throw "A timer is active";
  }
}
// class _TimeLeftNotifier extends Notifier<Duration?> {
//   @override
//   Duration? build() {
//     final timer = ref.watch(currentTimerProvider);
//     timer?.updateStreamController.stream.listen((newTimer) {
//       state = newTimer.timeLeft;
//     });
//     return timer?.timeLeft;
//   }
// }

/// The timer is shared across screens
/// so it make sense to put it here
class CurrentTimerNotifer extends Notifier<VibrationTimer?> {
  @override
  VibrationTimer? build() => null;
  void set(VibrationTimer timer) => state = timer;
  void clear() => state = null;
}

/// Simple wrapper around [Timer] and [Stopwatch].
/// On mobile, vibrates if the [duration] has passed.
class VibrationTimer {
  final Duration duration;
  Timer? timer;
  Stopwatch stopwatch = Stopwatch();
  final ValueChanged<VibrationTimer>? callback;
  final StreamController<VibrationTimer> updateStreamController =
      StreamController.broadcast();

  VibrationTimer({required this.duration, this.callback});

  /// If the timer is active
  bool get isActivate => timer?.isActive ?? false;

  /// Time ellapsed
  Duration get elapsed => stopwatch.elapsed;

  /// Time left on the duration
  Duration get timeLeft => duration - elapsed;

  void start() {
    assert(timer == null, "Timer has already been started");

    /// Run the first update
    updateStreamController.add(this);

    /// Run callback every seconds
    final ticker = Timer.periodic(Duration(seconds: 1), (timer) {
      callback?.call(this);
      updateStreamController.add(this);
    });

    /// Start the thing
    /// delay the timer for 1.2 seconds so it does not jump start expectation
    Future.delayed(Duration(seconds: 1, milliseconds: 200), () {
      stopwatch.start();
      timer = Timer(duration, () async {
        stopwatch.stop();
        ticker.cancel();
        if (await Vibration.hasVibrator()) {
          Vibration.vibrate();
        } else {
          print("No vibrator");
        }
      });
    });
  }
}
