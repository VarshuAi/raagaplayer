import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:http/http.dart' as http;
import '../../../../../core/database/app_database.dart';
import '../../../../../music/domain/entities/lyrics.dart';

class LyricsService {
  final AppDatabase database;
  final http.Client httpClient;

  LyricsService({
    required this.database,
    required this.httpClient,
  });

  Future<Lyrics> getLyrics({
    required String songId,
    required String title,
    required String artist,
    String providerId = 'online',
  }) async {
    try {
      final cacheRows = await database.customSelect(
        'SELECT content, is_synced FROM lyrics_cache WHERE song_id = ?;',
        variables: [Variable.withString(songId)],
      ).get();

      if (cacheRows.isNotEmpty) {
        final content = cacheRows.first.read<String>('content');
        final isSynced = cacheRows.first.read<bool>('is_synced');
        return Lyrics(
          songId: songId,
          content: content,
          lines: _parseLrc(content),
          isSynced: isSynced,
        );
      }
    } catch (_) {}

    String content = '';
    bool isSynced = false;

    // Try LRCLIB API for real synced lyrics
    try {
      final cleanTitle = title.split('(').first.split('-').first.trim();
      final cleanArtist = artist.split(',').first.split('&').first.trim();

      final directUri = Uri.parse(
        'https://lrclib.net/api/get?track_name=${Uri.encodeComponent(cleanTitle)}&artist_name=${Uri.encodeComponent(cleanArtist)}',
      );
      var response = await httpClient.get(directUri).timeout(const Duration(seconds: 4));

      if (response.statusCode != 200) {
        final searchUri = Uri.parse(
          'https://lrclib.net/api/search?q=${Uri.encodeComponent("$cleanTitle $cleanArtist")}',
        );
        response = await httpClient.get(searchUri).timeout(const Duration(seconds: 4));
        if (response.statusCode == 200) {
          final List searchData = json.decode(response.body);
          if (searchData.isNotEmpty) {
            final match = searchData.firstWhere(
              (item) => item['syncedLyrics'] != null || item['plainLyrics'] != null,
              orElse: () => searchData.first,
            );
            content = match['syncedLyrics'] ?? match['plainLyrics'] ?? '';
            isSynced = match['syncedLyrics'] != null;
          }
        }
      } else {
        final data = json.decode(response.body);
        content = data['syncedLyrics'] ?? data['plainLyrics'] ?? '';
        isSynced = data['syncedLyrics'] != null;
      }
    } catch (_) {}

    // Convert plain text to spaced time markers if no synced lyrics
    if (content.isNotEmpty && !isSynced) {
      final plainLines = LineSplitter.split(content).where((l) => l.trim().isNotEmpty).toList();
      final buffer = StringBuffer();
      for (int i = 0; i < plainLines.length; i++) {
        final seconds = i * 4;
        final min = (seconds ~/ 60).toString().padLeft(2, '0');
        final sec = (seconds % 60).toString().padLeft(2, '0');
        buffer.writeln('[$min:$sec.00] ${plainLines[i]}');
      }
      content = buffer.toString();
      isSynced = true;
    }

    // Fallback if no lyrics found anywhere
    if (content.trim().isEmpty) {
      content = '''
[00:00.00] $title
[00:04.00] $artist
[00:08.00] Enjoying music on Raaga Player
[00:15.00] ♪ ♫ ♩ ♬
[00:30.00] $title - $artist
''';
      isSynced = true;
    }

    // Cache locally
    try {
      await database.customStatement('''
        INSERT OR REPLACE INTO lyrics_cache (song_id, provider_id, content, is_synced, updated_at)
        VALUES (?, ?, ?, ?, ?);
      ''', [songId, providerId, content, isSynced, DateTime.now().toIso8601String()]);
    } catch (_) {}

    return Lyrics(
      songId: songId,
      content: content,
      lines: _parseLrc(content),
      isSynced: isSynced,
    );
  }

  List<LyricLine> _parseLrc(String content) {
    final List<LyricLine> lines = [];
    final regExp = RegExp(r'\[(\d+):(\d+)(?:\.(\d+))?\](.*)');
    for (final line in LineSplitter.split(content)) {
      final match = regExp.firstMatch(line);
      if (match != null) {
        final min = int.parse(match.group(1)!);
        final sec = int.parse(match.group(2)!);
        final msStr = match.group(3) ?? '0';
        final ms = int.parse(msStr.padRight(2, '0').substring(0, 2));
        final text = match.group(4)!.trim();
        if (text.isNotEmpty) {
          final stamp = Duration(minutes: min, seconds: sec, milliseconds: ms * 10);
          lines.add(LyricLine(stamp, text));
        }
      }
    }
    return lines;
  }
}
