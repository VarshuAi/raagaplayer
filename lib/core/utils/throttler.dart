import 'dart:async';
import 'dart:ui';

class Throttler {
  final Duration delay;
  Timer? _timer;
  bool _isThrottled = false;

  Throttler({required this.delay});

  void run(VoidCallback action) {
    if (_isThrottled) return;

    action();
    _isThrottled = true;
    _timer = Timer(delay, () {
      _isThrottled = false;
    });
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
    _isThrottled = false;
  }
}
