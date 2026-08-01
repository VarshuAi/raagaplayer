import 'dart:async';
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

    final quality = await qualityManager.getActiveQualityProfile(
      isWifi: true,
      isRoaming: false,
    );

    final baseUri = Uri.parse(song.sourceUrl);
    final qualityParam = _getQualityString(quality);
    final Map<String, String> queryParams = Map<String, String>.from(baseUri.queryParameters);
    queryParams['quality'] = qualityParam;
    
    final streamingUri = baseUri.replace(queryParameters: queryParams);
    return streamingUri.toString();
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
