import 'dart:developer' as developer;

class PerformanceMonitor {
  static final Map<String, Stopwatch> _stopwatches = {};
  static final List<String> _metrics = [];

  static List<String> get metrics => List.unmodifiable(_metrics);

  static void start(String operationName) {
    final sw = Stopwatch()..start();
    _stopwatches[operationName] = sw;
  }

  static void stop(String operationName) {
    final sw = _stopwatches.remove(operationName);
    if (sw != null) {
      sw.stop();
      final ms = sw.elapsedMilliseconds;
      final metricEntry = '[${DateTime.now().toIso8601String()}] $operationName took ${ms}ms';
      _metrics.add(metricEntry);
      developer.log('$operationName took ${ms}ms', name: 'Raaga.PerformanceMonitor');
    }
  }

  static void clear() {
    _metrics.clear();
  }
}
