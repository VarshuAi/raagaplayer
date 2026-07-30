import 'dart:convert';
import 'dart:io';
import '../../domain/entities/song.dart';

class PlaylistImportExport {
  PlaylistImportExport._();

  // Export playlist songs list to M3U text file format
  static Future<File> exportToM3u(String playlistName, List<Song> songs, String destinationPath) async {
    final file = File(destinationPath);
    final buffer = StringBuffer();
    buffer.writeln('#EXTM3U');

    for (final song in songs) {
      buffer.writeln('#EXTINF:${song.duration.inSeconds},${song.artist} - ${song.title}');
      buffer.writeln(song.sourceUrl);
    }

    return file.writeAsString(buffer.toString());
  }

  // Import local playlist from M3U/M3U8 file paths list
  static Future<List<String>> importFromM3u(String m3uFilePath) async {
    final file = File(m3uFilePath);
    if (!await file.exists()) return [];

    final lines = await file.readAsLines();
    final List<String> songPaths = [];

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty || trimmed.startsWith('#')) continue;
      // Line is a local file path reference
      songPaths.add(trimmed);
    }

    return songPaths;
  }

  // Export to JSON string format
  static String exportToJson(List<Song> songs) {
    final mapped = songs.map((s) => {
      'title': s.title,
      'artist': s.artist,
      'album': s.album,
      'path': s.sourceUrl,
      'durationMs': s.duration.inMilliseconds,
    }).toList();
    return json.encode(mapped);
  }
}
