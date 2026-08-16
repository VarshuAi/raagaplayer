import 'dart:convert';
import 'package:http/http.dart' as http;

class LyricLine {
  final Duration time;
  final String text;

  LyricLine({required this.time, required this.text});
}

class LyricsResult {
  final String? plainLyrics;
  final List<LyricLine>? syncedLyrics;

  LyricsResult({this.plainLyrics, this.syncedLyrics});
}

class LyricsEngine {
  static final LyricsEngine _instance = LyricsEngine._internal();
  factory LyricsEngine() => _instance;
  LyricsEngine._internal();

  Future<LyricsResult?> fetchLyrics(String artist, String title) async {
    try {
      // Clean artist and title queries (remove formatting, extra text)
      final cleanTitle = _cleanQuery(title);
      final cleanArtist = _cleanQuery(artist);

      final url = Uri.parse(
        'https://lrclib.net/api/get?'
        'artist_name=${Uri.encodeComponent(cleanArtist)}&'
        'track_name=${Uri.encodeComponent(cleanTitle)}',
      );

      final resp = await http.get(url).timeout(const Duration(seconds: 5));
      if (resp.statusCode == 200) {
        final data = json.decode(utf8.decode(resp.bodyBytes));
        
        final String? plain = data['plainLyrics'];
        final String? synced = data['syncedLyrics'];
        
        List<LyricLine>? parsedSynced;
        if (synced != null && synced.trim().isNotEmpty) {
          parsedSynced = _parseLrc(synced);
        }

        return LyricsResult(
          plainLyrics: plain,
          syncedLyrics: parsedSynced,
        );
      }
    } catch (e) {
      print('[LyricsEngine] Fetch failed: $e');
    }
    return null;
  }

  String _cleanQuery(String input) {
    // Remove "official video", "lyric video", "feat.", features in brackets etc.
    var clean = input.toLowerCase();
    clean = clean.replaceAll(RegExp(r'\((official|lyric|video|audio|full|hd|live|with lyrics)\)'), '');
    clean = clean.replaceAll(RegExp(r'\[(official|lyric|video|audio|full|hd|live|with lyrics)\]'), '');
    clean = clean.replaceAll(RegExp(r'feat\..*|ft\..*'), '');
    return clean.trim();
  }

  List<LyricLine> _parseLrc(String lrcContent) {
    final lines = lrcContent.split('\n');
    final List<LyricLine> parsed = [];
    final pattern = RegExp(r'^\[(\d+):(\d+)\.(\d+)\](.*)');

    for (final line in lines) {
      final match = pattern.firstMatch(line.trim());
      if (match != null) {
        final min = int.parse(match.group(1)!);
        final sec = int.parse(match.group(2)!);
        final ms = int.parse(match.group(3)!);
        final text = match.group(4)!.trim();

        // Convert groups to Duration
        final duration = Duration(
          minutes: min,
          seconds: sec,
          milliseconds: ms * (match.group(3)!.length == 2 ? 10 : 1), // Adjust for 2-digit or 3-digit ms
        );
        parsed.add(LyricLine(time: duration, text: text));
      }
    }

    parsed.sort((a, b) => a.time.compareTo(b.time));
    return parsed;
  }
}
