import 'dart:async';
import 'dart:io';

class LocalAudioStreamServer {
  static final LocalAudioStreamServer _instance = LocalAudioStreamServer._internal();
  factory LocalAudioStreamServer() => _instance;
  LocalAudioStreamServer._internal();

  HttpServer? _server;
  int? _port;
  final HttpClient _httpClient = HttpClient()
    ..connectionTimeout = const Duration(seconds: 15)
    ..autoUncompress = false
    ..badCertificateCallback = ((_, __, ___) => true);

  int get port => _port ?? 0;

  Future<void> ensureStarted() async {
    if (_server != null) return;
    try {
      _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      _port = _server!.port;
      print('[LocalAudioStreamServer] Listening on http://127.0.0.1:$_port');
      _server!.listen(_handleRequest, onError: (e) {
        print('[LocalAudioStreamServer] Server error: $e');
      });
    } catch (e) {
      print('[LocalAudioStreamServer] Failed to bind local server: $e');
    }
  }

  String getStreamUrl(String remoteUrl) {
    if (_port == null) return remoteUrl;
    final encoded = Uri.encodeComponent(remoteUrl);
    return 'http://127.0.0.1:$_port/audio.mp4?url=$encoded';
  }

  Future<void> _handleRequest(HttpRequest request) async {
    final targetUrl = request.uri.queryParameters['url'];
    if (targetUrl == null || targetUrl.isEmpty) {
      request.response.statusCode = 400;
      await request.response.close();
      return;
    }

    try {
      final remoteUri = Uri.parse(targetUrl);

      var remoteReq = await _httpClient.openUrl(request.method, remoteUri);
      remoteReq.headers.set('user-agent', 'Mozilla/5.0 (Linux; Android 10; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36');
      remoteReq.headers.set('referer', 'https://music.youtube.com/');
      remoteReq.headers.set('origin', 'https://music.youtube.com');
      remoteReq.headers.set('accept', '*/*');

      // Forward Range header from ExoPlayer
      final rangeHeader = request.headers.value('range');
      if (rangeHeader != null) {
        remoteReq.headers.set('range', rangeHeader);
      }

      var remoteResp = await remoteReq.close();

      request.response.statusCode = remoteResp.statusCode;
      request.response.headers.contentType = ContentType('audio', 'mp4');
      request.response.headers.set('accept-ranges', 'bytes');
      request.response.bufferOutput = false;

      final clen = remoteResp.headers.value('content-length');
      if (clen != null) {
        final parsedLen = int.tryParse(clen);
        if (parsedLen != null) {
          request.response.contentLength = parsedLen;
        }
      }

      final crange = remoteResp.headers.value('content-range');
      if (crange != null) {
        request.response.headers.set('content-range', crange);
      }

      if (request.method == 'HEAD') {
        try {
          await request.response.close();
        } catch (_) {}
      } else {
        try {
          await remoteResp.pipe(request.response);
        } catch (_) {}
      }
    } catch (e) {
      try {
        await request.response.close();
      } catch (_) {}
    }
  }

  Future<void> stop() async {
    await _server?.close(force: true);
    _server = null;
    _port = null;
  }
}
