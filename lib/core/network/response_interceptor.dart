import 'package:http/http.dart' as http;

abstract class ResponseInterceptor {
  Future<http.Response> onResponse(http.Response response);
}
