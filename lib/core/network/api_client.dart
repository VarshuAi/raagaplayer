import 'dart:convert';
import 'package:http/http.dart' as http;
import 'request_interceptor.dart';
import 'response_interceptor.dart';
import 'retry_policy.dart';

class ApiClient {
  final http.Client client;
  final List<RequestInterceptor> requestInterceptors;
  final List<ResponseInterceptor> responseInterceptors;
  final RetryPolicy retryPolicy;

  ApiClient({
    required this.client,
    this.requestInterceptors = const [],
    this.responseInterceptors = const [],
    this.retryPolicy = const RetryPolicy(),
  });

  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    return _sendWithRetry(() async {
      var requestHeaders = headers ?? <String, String>{};
      for (final interceptor in requestInterceptors) {
        requestHeaders = await interceptor.onRequest(requestHeaders);
      }
      
      var response = await client.get(url, headers: requestHeaders);
      
      for (final interceptor in responseInterceptors) {
        response = await interceptor.onResponse(response);
      }
      return response;
    });
  }

  Future<http.Response> post(Uri url, {Map<String, String>? headers, Object? body}) async {
    return _sendWithRetry(() async {
      var requestHeaders = headers ?? <String, String>{};
      for (final interceptor in requestInterceptors) {
        requestHeaders = await interceptor.onRequest(requestHeaders);
      }
      
      var response = await client.post(url, headers: requestHeaders, body: body);
      
      for (final interceptor in responseInterceptors) {
        response = await interceptor.onResponse(response);
      }
      return response;
    });
  }

  Future<http.Response> _sendWithRetry(Future<http.Response> Function() action) async {
    int attempts = 0;
    while (true) {
      try {
        attempts++;
        final response = await action();
        if (retryPolicy.shouldRetry(response) && attempts < retryPolicy.maxRetries) {
          await Future.delayed(retryPolicy.getDelay(attempts));
          continue;
        }
        return response;
      } catch (e) {
        if (attempts >= retryPolicy.maxRetries) {
          rethrow;
        }
        await Future.delayed(retryPolicy.getDelay(attempts));
      }
    }
  }
}
