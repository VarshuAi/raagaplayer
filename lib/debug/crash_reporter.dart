import 'dart:developer' as developer;

class CrashReporter {
  static final List<String> _logs = [];

  static List<String> get logs => List.unmodifiable(_logs);

  static void logError(String message, dynamic error, StackTrace? stackTrace) {
    final logEntry = '[${DateTime.now().toIso8601String()}] ERROR: $message\nDetail: $error\n$stackTrace';
    _logs.add(logEntry);
    developer.log(message, error: error, stackTrace: stackTrace, name: 'Raaga.CrashReporter');
  }

  static void logInfo(String message) {
    final logEntry = '[${DateTime.now().toIso8601String()}] INFO: $message';
    _logs.add(logEntry);
    developer.log(message, name: 'Raaga.CrashReporter');
  }

  static void clear() {
    _logs.clear();
  }
}
