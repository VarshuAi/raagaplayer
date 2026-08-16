import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/// Single shared YoutubeExplode instance to reuse HTTP sockets and prevent connection timeouts/starvation.
final ytExplode = YoutubeExplode();

/// Upgrades standard YouTube/YouTube Music low-resolution thumbnails to premium high-resolution images.
String upgradeToHighResArtwork(String url) {
  if (url.isEmpty) return url;
  
  if (url.contains('googleusercontent.com') || url.contains('ggpht.com')) {
    final upgraded = url
        .replaceAll(RegExp(r'=w\d+-h\d+[^=]*$'), '=w544-h544-l90-rj')
        .replaceAll(RegExp(r'=s\d+[^=]*$'), '=s512');
    return upgraded;
  }
  
  if (url.contains('ytimg.com/vi/')) {
    final idMatch = RegExp(r'/vi/([^/]+)/').firstMatch(url);
    if (idMatch != null) {
      final videoId = idMatch.group(1);
      return 'https://i.ytimg.com/vi/$videoId/maxresdefault.jpg';
    }
  }
  
  return url;
}

/// YouTube Music InnerTube client config (WEB_REMIX).
const ytMusicContext = {
  "client": {
    "clientName": "WEB_REMIX",
    "clientVersion": "1.20240918.01.00",
    "hl": "en",
    "gl": "IN",
  }
};
const ytMusicApiKey = 'AIzaSyC9XL3ZjWddXya6X74dJoCTL-NKNELL6OA';
const ytMusicBase = 'https://music.youtube.com/youtubei/v1';

const _ytMusicHeaders = {
  'Content-Type': 'application/json',
  'X-YouTube-Client-Name': '67',
  'X-YouTube-Client-Version': '1.20240918.01.00',
  'Origin': 'https://music.youtube.com',
  'Referer': 'https://music.youtube.com/',
  'User-Agent':
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36',
};

/// POST to the YouTube Music InnerTube API.
Future<Map<String, dynamic>?> ytMusicPost(
  String endpoint,
  Map<String, dynamic> body, {
  http.Client? client,
}) async {
  final uri = Uri.parse('$ytMusicBase/$endpoint?key=$ytMusicApiKey');
  final payload = json.encode({"context": ytMusicContext, ...body});
  final c = client ?? http.Client();
  try {
    final response = await c
        .post(uri, headers: _ytMusicHeaders, body: payload)
        .timeout(const Duration(seconds: 10));
    if (response.statusCode == 200) {
      return json.decode(response.body) as Map<String, dynamic>;
    }
    print('[YTMusic] $endpoint → HTTP ${response.statusCode}');
  } catch (e) {
    print('[YTMusic] POST $endpoint failed: $e');
  }
  return null;
}

/// Safely navigate nested maps/lists by a mixed key path.
dynamic ytNav(dynamic obj, List<dynamic> path) {
  dynamic cur = obj;
  for (final key in path) {
    if (cur == null) return null;
    if (key is int) {
      if (cur is List && cur.length > key) {
        cur = cur[key];
      } else {
        return null;
      }
    } else {
      if (cur is Map) {
        cur = cur[key];
      } else {
        return null;
      }
    }
  }
  return cur;
}

/// Parse a YouTube Music list item renderer into a map of song fields.
/// Returns null if the item doesn't look like a playable song.
Map<String, dynamic>? parseMusicItem(dynamic item) {
  try {
    final renderer = item['musicResponsiveListItemRenderer'] ??
        item['musicTwoRowItemRenderer'];
    if (renderer == null) return null;

    // ── Video ID ────────────────────────────────────────────────────────────
    String? videoId;
    videoId ??= ytNav(renderer, [
          'overlay',
          'musicItemThumbnailOverlayRenderer',
          'content',
          'musicPlayButtonRenderer',
          'playNavigationEndpoint',
          'watchEndpoint',
          'videoId'
        ]) as String?;
    videoId ??= ytNav(renderer,
        ['navigationEndpoint', 'watchEndpoint', 'videoId']) as String?;

    if (videoId == null) {
      final cols = renderer['flexColumns'] as List?;
      if (cols != null) {
        outer:
        for (final col in cols) {
          final runs = ytNav(col, [
            'musicResponsiveListItemFlexColumnRenderer',
            'text',
            'runs'
          ]) as List?;
          if (runs != null) {
            for (final run in runs) {
              videoId = ytNav(run,
                  ['navigationEndpoint', 'watchEndpoint', 'videoId']) as String?;
              if (videoId != null) break outer;
            }
          }
        }
      }
    }
    if (videoId == null || videoId.length != 11) return null;

    // ── Title ───────────────────────────────────────────────────────────────
    String title = '';
    final cols = renderer['flexColumns'] as List?;
    if (cols != null && cols.isNotEmpty) {
      final runs = ytNav(cols[0], [
        'musicResponsiveListItemFlexColumnRenderer',
        'text',
        'runs'
      ]) as List?;
      title = (runs != null && runs.isNotEmpty)
          ? (runs[0]['text'] as String? ?? '')
          : '';
    }
    title = title.isEmpty
        ? (ytNav(renderer, ['title', 'runs', 0, 'text']) as String? ?? 'Unknown')
        : title;
    if (title.isEmpty) return null;

    // ── Artist ──────────────────────────────────────────────────────────────
    String artist = 'Unknown Artist';
    if (cols != null && cols.length > 1) {
      final runs = ytNav(cols[1], [
        'musicResponsiveListItemFlexColumnRenderer',
        'text',
        'runs'
      ]) as List?;
      if (runs != null && runs.isNotEmpty) {
        artist = (runs[0]['text'] as String? ?? 'Unknown Artist');
      }
    }
    artist = artist
        .replaceAll(RegExp(r'\s*-\s*Topic$', caseSensitive: false), '')
        .replaceAll(RegExp(r'\s*VEVO$', caseSensitive: false), '')
        .trim();

    // ── Thumbnail ───────────────────────────────────────────────────────────
    final thumbnails = ytNav(renderer, [
      'thumbnail',
      'musicThumbnailRenderer',
      'thumbnail',
      'thumbnails'
    ]) as List?;
    String artworkUrl = '';
    if (thumbnails != null && thumbnails.isNotEmpty) {
      artworkUrl = upgradeToHighResArtwork(thumbnails.last['url'] as String? ?? '');
    }

    // ── Duration ────────────────────────────────────────────────────────────
    int durationSeconds = 210; // default 3:30
    final fixedCols = renderer['fixedColumns'] as List?;
    if (fixedCols != null && fixedCols.isNotEmpty) {
      final dRuns = ytNav(fixedCols[0], [
        'musicResponsiveListItemFixedColumnRenderer',
        'text',
        'runs'
      ]) as List?;
      if (dRuns != null && dRuns.isNotEmpty) {
        final dStr = dRuns[0]['text'] as String? ?? '';
        final parts = dStr.split(':');
        if (parts.length == 2) {
          durationSeconds =
              (int.tryParse(parts[0]) ?? 0) * 60 + (int.tryParse(parts[1]) ?? 0);
        } else if (parts.length == 3) {
          durationSeconds = (int.tryParse(parts[0]) ?? 0) * 3600 +
              (int.tryParse(parts[1]) ?? 0) * 60 +
              (int.tryParse(parts[2]) ?? 0);
        }
      }
    }

    return {
      'id': videoId,
      'title': title,
      'artist': artist,
      'artworkUrl': artworkUrl,
      'durationSeconds': durationSeconds,
    };
  } catch (_) {
    return null;
  }
}

/// Parse a playlistPanelVideoRenderer into a map of song fields.
Map<String, dynamic>? parsePlaylistPanelVideo(dynamic item) {
  try {
    final r = item['playlistPanelVideoRenderer'];
    if (r == null) return null;

    final videoId = r['videoId'] as String?;
    if (videoId == null || videoId.length != 11) return null;

    final title = ytNav(r, ['title', 'runs', 0, 'text']) as String? ?? '';
    if (title.isEmpty) return null;

    // Artists runs are normally first in longBylineText
    final artist = ytNav(r, ['longBylineText', 'runs', 0, 'text']) as String? ?? 'Unknown Artist';

    final thumbnails = ytNav(r, ['thumbnail', 'thumbnails']) as List?;
    final artworkUrl = (thumbnails != null && thumbnails.isNotEmpty)
        ? upgradeToHighResArtwork(thumbnails.last['url'] as String? ?? '')
        : '';

    int durationSeconds = 210;
    final lengthText = ytNav(r, ['lengthText', 'runs', 0, 'text']) as String?;
    if (lengthText != null) {
      final parts = lengthText.split(':');
      if (parts.length == 2) {
        durationSeconds = (int.tryParse(parts[0]) ?? 0) * 60 + (int.tryParse(parts[1]) ?? 0);
      } else if (parts.length == 3) {
        durationSeconds = (int.tryParse(parts[0]) ?? 0) * 3600 +
            (int.tryParse(parts[1]) ?? 0) * 60 +
            (int.tryParse(parts[2]) ?? 0);
      }
    }

    return {
      'id': videoId,
      'title': title,
      'artist': artist,
      'artworkUrl': artworkUrl,
      'durationSeconds': durationSeconds,
    };
  } catch (_) {
    return null;
  }
}

/// Walk a YTMusic API response and collect all song items.
List<Map<String, dynamic>> extractSongs(dynamic data) {
  final results = <Map<String, dynamic>>[];
  if (data == null) return results;

  void walk(dynamic node) {
    if (node is Map) {
      if (node.containsKey('musicResponsiveListItemRenderer') ||
          node.containsKey('musicTwoRowItemRenderer')) {
        final s = parseMusicItem(node);
        if (s != null) results.add(s);
        return;
      }
      if (node.containsKey('playlistPanelVideoRenderer')) {
        final s = parsePlaylistPanelVideo(node);
        if (s != null) results.add(s);
        return;
      }
      for (final v in node.values) walk(v);
    } else if (node is List) {
      for (final item in node) walk(item);
    }
  }

  walk(data);
  return results;
}
/// Extract songs from the playlistPanelRenderer inside the watch next response.
/// This matches the official YouTube Music autoplay queue (radio mix) precisely.
List<Map<String, dynamic>> extractPlaylistPanelSongs(dynamic data) {
  final results = <Map<String, dynamic>>[];
  if (data == null) return results;

  // Locate the playlistPanelRenderer inside watch next results
  var panel = ytNav(data, [
    'contents',
    'singleColumnMusicWatchNextResultsRenderer',
    'playlistPanelRenderer',
    'playlistPanelRenderer'
  ]);

  if (panel == null) {
    // Alternate nested traversal fallback
    void findPanel(dynamic node) {
      if (panel != null) return;
      if (node is Map) {
        if (node.containsKey('playlistPanelRenderer')) {
          panel = node['playlistPanelRenderer'];
          return;
        }
        for (final v in node.values) findPanel(v);
      } else if (node is List) {
        for (final item in node) findPanel(item);
      }
    }
    findPanel(data);
  }

  if (panel is Map) {
    final contents = panel['contents'] as List?;
    if (contents != null) {
      for (final item in contents) {
        final song = parsePlaylistPanelVideo(item);
        if (song != null) {
          results.add(song);
        }
      }
    }
  }
  return results;
}

/// Fetch Watch Next autoplay radio recommendations from YouTube Music.
/// Uses the RDAMVM radio mix playlist which activates YT's actual autoplay algorithm.
Future<List<Map<String, dynamic>>> fetchRecommendations(String videoId) async {
  // RDAMVM prefix activates YouTube's full radio mix algorithm
  final radioPlaylistId = 'RDAMVM$videoId';
  
  // Primary: Watch Next with radio playlist context (best quality recs)
  final data = await ytMusicPost('next', {
    'videoId': videoId,
    'playlistId': radioPlaylistId,
    'enablePersistentPlaylistPanel': true,
    'isAudioOnly': true,
  });
  
  if (data != null) {
    final songs = extractPlaylistPanelSongs(data);
    // Filter out the seed song itself
    final filtered = songs.where((s) => s['id'] != videoId).toList();
    if (filtered.isNotEmpty) return filtered;
  }
  
  // Fallback: plain Watch Next without playlist context
  final fallbackData = await ytMusicPost('next', {
    'videoId': videoId,
    'enablePersistentPlaylistPanel': true,
  });

  if (fallbackData != null) {
    final fallbackSongs = extractPlaylistPanelSongs(fallbackData);
    final filtered = fallbackSongs.where((s) => s['id'] != videoId).toList();
    if (filtered.isNotEmpty) return filtered;
  }
  
  // Final deep fallback: walk the whole response tree
  final deepSongs = extractSongs(fallbackData ?? data);
  return deepSongs.where((s) => s['id'] != videoId).toList();
}
