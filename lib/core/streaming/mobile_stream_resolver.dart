import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// 📱 Mobile-Only Multi-Engine On-Device Stream Resolver
/// Resolves YouTube audio streams 100% on-device without any cloud hosting or PC servers.
class MobileStreamResolver {
  static final http.Client _client = http.Client();

  /// Primary Entry Point: Tries 4 independent on-device resolution methods in sequence
  static Future<String?> resolveStream(String videoId) async {
    if (videoId.isEmpty) return null;

    // ── Method 1: Direct InnerTube ANDROID_MUSIC Payload ──────────────────
    try {
      final url = await _resolveInnerTube(videoId, clientName: 'ANDROID_MUSIC', clientVersion: '6.42.52');
      if (url != null && url.isNotEmpty) {
        print('[MobileStreamResolver] Method 1 (ANDROID_MUSIC) Succeeded!');
        return url;
      }
    } catch (e) {
      print('[MobileStreamResolver] Method 1 Error: $e');
    }

    // ── Method 2: Direct InnerTube TVHTML5 Payload ────────────────────────
    try {
      final url = await _resolveInnerTube(videoId, clientName: 'TVHTML5', clientVersion: '7.20230405.08.01');
      if (url != null && url.isNotEmpty) {
        print('[MobileStreamResolver] Method 2 (TVHTML5) Succeeded!');
        return url;
      }
    } catch (e) {
      print('[MobileStreamResolver] Method 2 Error: $e');
    }

    // ── Method 3: Direct InnerTube WEB_REMIX Payload ──────────────────────
    try {
      final url = await _resolveInnerTube(videoId, clientName: 'WEB_REMIX', clientVersion: '1.20240101.01.00');
      if (url != null && url.isNotEmpty) {
        print('[MobileStreamResolver] Method 3 (WEB_REMIX) Succeeded!');
        return url;
      }
    } catch (e) {
      print('[MobileStreamResolver] Method 3 Error: $e');
    }

    // ── Method 4: On-Device YoutubeExplode Manifest Fallback ──────────────
    try {
      final ytExplode = YoutubeExplode();
      final manifest = await ytExplode.videos.streams.getManifest(
        videoId,
        ytClients: [YoutubeApiClient.android, YoutubeApiClient.mweb],
      ).timeout(const Duration(seconds: 10));

      final audioOnly = manifest.audioOnly;
      if (audioOnly.isNotEmpty) {
        final bestStream = audioOnly.withHighestBitrate();
        final url = bestStream.url.toString();
        ytExplode.close();
        if (url.isNotEmpty) {
          print('[MobileStreamResolver] Method 4 (YoutubeExplode) Succeeded!');
          return url;
        }
      }
      ytExplode.close();
    } catch (e) {
      print('[MobileStreamResolver] Method 4 Error: $e');
    }

    return null;
  }

  /// Helper: Executes raw InnerTube POST request to youtubei.googleapis.com
  static Future<String?> _resolveInnerTube(
    String videoId, {
    required String clientName,
    required String clientVersion,
  }) async {
    final uri = Uri.parse('https://youtubei.googleapis.com/youtubei/v1/player');
    final payload = {
      'context': {
        'client': {
          'clientName': clientName,
          'clientVersion': clientVersion,
          'androidSdkVersion': 34,
          'hl': 'en',
          'gl': 'US',
        }
      },
      'videoId': videoId,
    };

    final resp = await _client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'Mozilla/5.0 (Linux; Android 14; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36',
        'Referer': 'https://music.youtube.com/',
      },
      body: json.encode(payload),
    ).timeout(const Duration(seconds: 5));

    if (resp.statusCode == 200) {
      final data = json.decode(resp.body);
      final streamingData = data['streamingData'] ?? {};
      final formats = [
        ...(streamingData['adaptiveFormats'] ?? []),
        ...(streamingData['formats'] ?? [])
      ];

      for (final f in formats) {
        final streamUrl = f['url'];
        final mime = (f['mimeType'] ?? '').toString().toLowerCase();
        if (streamUrl != null &&
            (streamUrl as String).contains('googlevideo.com') &&
            (mime.contains('audio') || f['itag'] == 140 || f['itag'] == 18)) {
          return streamUrl as String;
        }
      }
    }
    return null;
  }
}
