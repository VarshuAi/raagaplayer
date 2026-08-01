abstract class RequestInterceptor {
  Future<Map<String, String>> onRequest(Map<String, String> headers);
}
