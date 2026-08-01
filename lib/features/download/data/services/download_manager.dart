import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../../../../../core/database/app_database.dart';

class DownloadManager {
  static final DownloadManager _instance = DownloadManager._internal();
  factory DownloadManager() => _instance;
  DownloadManager._internal();

  AppDatabase? _database;
  final List<String> _activeQueue = [];
  final Map<String, double> _progressMap = {};

  final _progressController = StreamController<Map<String, double>>.broadcast();

  Stream<Map<String, double>> get progressStream => _progressController.stream;

  void initialize(AppDatabase database) {
    _database = database;
  }

  Future<Directory> get _downloadDir async {
    final docDir = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docDir.path, 'downloads'));
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  Future<void> startDownload(String songId, String providerId, String sourceUrl, {String? songTitle, String? artistName, String? artworkUrl}) async {
    if (_activeQueue.contains(songId)) return;
    if (sourceUrl.isEmpty) return;

    _activeQueue.add(songId);
    _progressMap[songId] = 0.05;
    _progressController.add(Map.from(_progressMap));

    try {
      final dir = await _downloadDir;
      final filePath = p.join(dir.path, '$songId.mp3');
      final file = File(filePath);

      // Perform real HTTP stream download with live progress tracking
      final client = http.Client();
      final request = http.Request('GET', Uri.parse(sourceUrl));
      final response = await client.send(request);

      final totalBytes = response.contentLength ?? 0;
      int downloadedBytes = 0;

      final sink = file.openWrite();

      await for (final chunk in response.stream) {
        downloadedBytes += chunk.length;
        sink.add(chunk);

        if (totalBytes > 0) {
          _progressMap[songId] = (downloadedBytes / totalBytes).clamp(0.05, 0.95);
          _progressController.add(Map.from(_progressMap));
        }
      }

      await sink.close();
      client.close();

      // Download and save album cover image locally for offline identification
      String localArtworkPath = artworkUrl ?? '';
      if (artworkUrl != null && artworkUrl.isNotEmpty && artworkUrl.startsWith('http')) {
        try {
          final imagePath = p.join(dir.path, '${songId}_cover.jpg');
          final imgRes = await http.get(Uri.parse(artworkUrl));
          if (imgRes.statusCode == 200) {
            final imgFile = File(imagePath);
            await imgFile.writeAsBytes(imgRes.bodyBytes);
            localArtworkPath = imagePath;
          }
        } catch (imgErr) {
          print('Cover image download error for $songId: $imgErr');
        }
      }

      _progressMap[songId] = 1.0;
      _progressController.add(Map.from(_progressMap));

      final db = _database ?? AppDatabase.instance();

      // Record in downloads table
      await db.customStatement('''
        INSERT OR REPLACE INTO downloads (id, song_id, provider_id, path, status, progress, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?);
      ''', [
        songId,
        songId,
        providerId,
        filePath,
        2, // Completed
        1.0,
        DateTime.now().millisecondsSinceEpoch,
      ]);

      // Save metadata into songs table for offline playback with local artwork path
      if (songTitle != null && songTitle.isNotEmpty) {
        await db.customStatement('''
          INSERT OR REPLACE INTO songs (id, title, artist, album, duration, path, folder, artwork_url, is_local, is_favorite)
          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?);
        ''', [
          songId,
          songTitle,
          artistName ?? 'Unknown Artist',
          'Downloaded Tracks',
          '03:30',
          filePath,
          dir.path,
          localArtworkPath,
          1, // isLocal true
          0
        ]);
      }
    } catch (e) {
      print('Real Download Error for $songId: $e');
    } finally {
      _activeQueue.remove(songId);
      _progressMap.remove(songId);
      _progressController.add(Map.from(_progressMap));
    }
  }

  Future<void> deleteDownload(String songId) async {
    try {
      final db = _database ?? AppDatabase.instance();
      final dir = await _downloadDir;
      final audioFile = File(p.join(dir.path, '$songId.mp3'));
      final coverFile = File(p.join(dir.path, '${songId}_cover.jpg'));

      if (await audioFile.exists()) await audioFile.delete();
      if (await coverFile.exists()) await coverFile.delete();

      await db.customStatement('DELETE FROM downloads WHERE song_id = ?;', [songId]);
      await db.customStatement('DELETE FROM songs WHERE id = ?;', [songId]);
    } catch (e) {
      print('Delete download error: $e');
    }
  }
}
