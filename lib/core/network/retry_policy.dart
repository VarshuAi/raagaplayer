import 'dart:math';
import 'package:http/http.dart' as http;

class RetryPolicy {
  final int maxRetries;
  final Duration baseDelay;

  const RetryPolicy({
    this.maxRetries = 3,
    this.baseDelay = const Duration(milliseconds: 500),
  });

  bool shouldRetry(http.Response response) {
    return response.statusCode == 502 || response.statusCode == 503 || response.statusCode == 504;
  }

  Duration getDelay(int attempt) {
    final delayMs = baseDelay.inMilliseconds * pow(2, attempt);
    return Duration(milliseconds: delayMs.toInt());
  }
}
