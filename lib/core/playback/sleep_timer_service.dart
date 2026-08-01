import 'dart:async';
import 'playback_engine.dart';

class SleepTimerService {
  final PlaybackEngine _playbackEngine;
  Timer? _timer;
  Duration? _remaining;
  final _controller = StreamController<Duration?>.broadcast();

  SleepTimerService(this._playbackEngine);

  Stream<Duration?> get remainingTimeStream => _controller.stream;

  void start(Duration duration) {
    _timer?.cancel();
    _remaining = duration;
    _controller.add(_remaining);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining == null) {
        timer.cancel();
        return;
      }
      
      final next = _remaining! - const Duration(seconds: 1);
      if (next.inSeconds <= 0) {
        _remaining = null;
        _controller.add(null);
        timer.cancel();
        _triggerStop();
      } else {
        _remaining = next;
        _controller.add(_remaining);
      }
    });
  }

  void cancel() {
    _timer?.cancel();
    _remaining = null;
    _controller.add(null);
  }

  void _triggerStop() {
    _playbackEngine.pause();
  }

  void dispose() {
    _timer?.cancel();
    _controller.close();
  }
}
