import 'request_interceptor.dart';

class AuthenticatedClient implements RequestInterceptor {
  String? _accessToken;

  AuthenticatedClient();

  void updateToken(String? token) {
    _accessToken = token;
  }

  @override
  Future<Map<String, String>> onRequest(Map<String, String> headers) async {
    final updatedHeaders = Map<String, String>.from(headers);
    if (_accessToken != null) {
      updatedHeaders['Authorization'] = 'Bearer $_accessToken';
    }
    return updatedHeaders;
  }
}
