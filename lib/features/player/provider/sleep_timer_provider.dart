import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'playback_provider.dart';

class SleepTimerState {
  final Duration? remainingTime;
  final bool isActive;

  SleepTimerState({this.remainingTime, this.isActive = false});

  SleepTimerState copyWith({Duration? remainingTime, bool? isActive}) {
    return SleepTimerState(
      remainingTime: remainingTime ?? this.remainingTime,
      isActive: isActive ?? this.isActive,
    );
  }
}

class SleepTimerNotifier extends StateNotifier<SleepTimerState> {
  final Ref _ref;
  Timer? _timer;

  SleepTimerNotifier(this._ref) : super(SleepTimerState());

  void startTimer(Duration duration) {
    _timer?.cancel();
    state = SleepTimerState(remainingTime: duration, isActive: true);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.remainingTime == null || state.remainingTime!.inSeconds <= 0) {
        _timer?.cancel();
        _triggerSleep();
      } else {
        state = state.copyWith(
          remainingTime: state.remainingTime! - const Duration(seconds: 1),
        );
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
    state = SleepTimerState(remainingTime: null, isActive: false);
  }

  void _triggerSleep() {
    _ref.read(audioEngineProvider).pause();
    state = SleepTimerState(remainingTime: null, isActive: false);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

final sleepTimerProvider = StateNotifierProvider<SleepTimerNotifier, SleepTimerState>((ref) {
  return SleepTimerNotifier(ref);
});
