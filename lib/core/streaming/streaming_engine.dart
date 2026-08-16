import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'media_quality_manager.dart';
import '../../music/domain/entities/song.dart';
import '../network/network_monitor.dart';

class StreamingEngine {
  final http.Client client;
  final MediaQualityManager qualityManager;
  final NetworkMonitor networkMonitor;

  StreamingEngine({
    required this.client,
    required this.qualityManager,
    required this.networkMonitor,
  });

  Future<String> getStreamingUrl(Song song) async {
    final isConnected = await networkMonitor.isConnected;
    if (!isConnected) {
      if (song.isLocal) return song.sourceUrl;
      throw Exception('Network disconnected and no local copy is available.');
    }

    // If it's already a direct audio URL (googlevideo, etc), use it directly
    final sourceUrl = song.sourceUrl;
    if (!sourceUrl.contains('/api/stream') && !sourceUrl.contains('/api/song')) {
      return sourceUrl;
    }

    // The sourceUrl is an API endpoint - fetch it and extract the real stream URL
    try {
      final uri = Uri.parse(sourceUrl);
      final response = await client.get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // If it's our /api/stream response, get the actual URL
        if (data['url'] != null && (data['url'] as String).isNotEmpty) {
          return data['url'] as String;
        }
        // If it's /api/song/xxx/stream-url response, recurse with the real stream endpoint
        if (data['streamUrl'] != null) {
          final redirectUrl = (data['streamUrl'] as String);
          final baseUrl = uri.origin;
          final fullRedirect = redirectUrl.startsWith('http') ? redirectUrl : '$baseUrl$redirectUrl';
          final r2 = await client.get(Uri.parse(fullRedirect)).timeout(const Duration(seconds: 15));
          if (r2.statusCode == 200) {
            final d2 = json.decode(r2.body);
            if (d2['url'] != null) return d2['url'] as String;
          }
        }
      }
    } catch (e) {
      // Fall through to return the original URL as fallback
    }

    return sourceUrl;
  }

  String _getQualityString(MediaQualityProfile profile) {
    switch (profile) {
      case MediaQualityProfile.low: return 'low';
      case MediaQualityProfile.medium: return 'medium';
      case MediaQualityProfile.high: return 'high';
      case MediaQualityProfile.veryHigh: return 'very_high';
      case MediaQualityProfile.lossless: return 'lossless';
    }
  }
}

