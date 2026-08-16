import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../../music/data/datasource/remote/ytmusic_client.dart';
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
    // Try external storage first so files appear in device Downloads folder
    try {
      final extDir = await getExternalStorageDirectory();
      if (extDir != null) {
        final dir = Directory(p.join(extDir.path, 'Raaga', 'downloads'));
        if (!await dir.exists()) await dir.create(recursive: true);
        return dir;
      }
    } catch (_) {}
    // Fallback to app documents directory (always available)
    final docDir = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(docDir.path, 'downloads'));
    if (!await dir.exists()) await dir.create(recursive: true);
    return dir;
  }

  Future<void> startDownload(String songId, String providerId, String sourceUrl, {String? songTitle, String? artistName, String? artworkUrl}) async {
    if (_activeQueue.contains(songId)) return;

    _activeQueue.add(songId);
    _progressMap[songId] = 0.05;
    _progressController.add(Map.from(_progressMap));

    try {
      final dir = await _downloadDir;
      final filePath = p.join(dir.path, '$songId.mp3');
      final file = File(filePath);

      // Always resolve stream URL via youtube_explode for YT songs (11-char video ID)
      // This bypasses relative /api/stream URLs and ensures a valid direct CDN URL
      String downloadUrl = sourceUrl;
      if (songId.length == 11) {
        print('[DownloadManager] Resolving stream URL for download: $songId...');
        String? resolved;
        // Try Android client first
        try {
          final manifest = await ytExplode.videos.streams.getManifest(
            songId,
            ytClients: [YoutubeApiClient.android],
          ).timeout(const Duration(seconds: 15));
          final mp4Streams = manifest.audioOnly.where((s) => s.container == StreamContainer.mp4);
          resolved = mp4Streams.isNotEmpty
              ? mp4Streams.withHighestBitrate().url.toString()
              : manifest.audioOnly.withHighestBitrate().url.toString();
        } catch (e) {
          print('[DownloadManager] android client failed: $e. Trying Android VR client...');
        }
        
        // Try Android VR client next
        if (resolved == null) {
          try {
            final manifest = await ytExplode.videos.streams.getManifest(
              songId,
              ytClients: [YoutubeApiClient.androidVr],
            ).timeout(const Duration(seconds: 15));
            final mp4Streams = manifest.audioOnly.where((s) => s.container == StreamContainer.mp4);
            resolved = mp4Streams.isNotEmpty
                ? mp4Streams.withHighestBitrate().url.toString()
                : manifest.audioOnly.withHighestBitrate().url.toString();
          } catch (e) {
            print('[DownloadManager] androidVr client failed: $e. Trying standard client fallback...');
          }
        }

        // Try standard default client fallback
        if (resolved == null) {
          try {
            final manifest = await ytExplode.videos.streams.getManifest(
              songId,
            ).timeout(const Duration(seconds: 10));
            final mp4Streams = manifest.audioOnly.where((s) => s.container == StreamContainer.mp4);
            resolved = mp4Streams.isNotEmpty
                ? mp4Streams.withHighestBitrate().url.toString()
                : manifest.audioOnly.withHighestBitrate().url.toString();
          } catch (e) {
            print('[DownloadManager] Standard client fallback also failed: $e');
          }
        }

        if (resolved != null) {
          downloadUrl = resolved;
          print('[DownloadManager] Resolved stream URL: ${downloadUrl.substring(0, 60)}...');
        } else {
          throw Exception('Could not resolve stream URL for $songId — all clients failed');
        }
      }
      
      if (!downloadUrl.startsWith('http')) {
        throw Exception('Invalid download URL: $downloadUrl');
      }

      // ── Fast parallel chunk download ──────────────────────────────────────
      // First probe the file size via HEAD to check Range support
      final probeClient = http.Client();
      int totalBytes = 0;
      bool supportsRanges = false;
      try {
        final headReq = http.Request('HEAD', Uri.parse(downloadUrl));
        headReq.headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36';
        headReq.headers['Referer'] = 'https://www.youtube.com/';
        final headResp = await probeClient.send(headReq).timeout(const Duration(seconds: 8));
        totalBytes = headResp.contentLength ?? 0;
        supportsRanges = headResp.headers['accept-ranges'] == 'bytes' || totalBytes > 0;
      } catch (_) {} finally {
        probeClient.close();
      }

      final headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36',
        'Referer': 'https://www.youtube.com/',
      };

      if (supportsRanges && totalBytes > 0) {
        // Parallel 4-chunk download for max speed
        const numChunks = 4;
        final chunkSize = (totalBytes / numChunks).ceil();
        int downloadedBytes = 0;

        final chunks = List<List<int>?>.filled(numChunks, null);

        await Future.wait(
          List.generate(numChunks, (i) async {
            final start = i * chunkSize;
            final end = (i + 1 == numChunks) ? totalBytes - 1 : start + chunkSize - 1;
            if (start >= totalBytes) return;

            final client = http.Client();
            try {
              final req = http.Request('GET', Uri.parse(downloadUrl));
              req.headers.addAll(headers);
              req.headers['Range'] = 'bytes=$start-$end';
              final resp = await client.send(req).timeout(const Duration(seconds: 60));
              final bytes = <int>[];
              await for (final chunk in resp.stream) {
                bytes.addAll(chunk);
                downloadedBytes += chunk.length;
                if (totalBytes > 0) {
                  _progressMap[songId] = (downloadedBytes / totalBytes).clamp(0.05, 0.95);
                  _progressController.add(Map.from(_progressMap));
                }
              }
              chunks[i] = bytes;
            } finally {
              client.close();
            }
          }),
        );

        // Write chunks in order
        final sink = file.openWrite();
        for (final chunk in chunks) {
          if (chunk != null) sink.add(chunk);
        }
        await sink.close();
        print('[DownloadManager] Parallel chunk download done for $songId (${(totalBytes / 1024 / 1024).toStringAsFixed(1)} MB)');
      } else {
        // Fallback: single stream download
        final client = http.Client();
        final request = http.Request('GET', Uri.parse(downloadUrl));
        request.headers.addAll(headers);
        final response = await client.send(request).timeout(const Duration(seconds: 120));

        final respTotal = response.contentLength ?? 0;
        int downloadedBytes = 0;
        final sink = file.openWrite();

        await for (final chunk in response.stream) {
          downloadedBytes += chunk.length;
          sink.add(chunk);
          if (respTotal > 0) {
            _progressMap[songId] = (downloadedBytes / respTotal).clamp(0.05, 0.95);
            _progressController.add(Map.from(_progressMap));
          }
        }
        await sink.close();
        client.close();
      }

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
