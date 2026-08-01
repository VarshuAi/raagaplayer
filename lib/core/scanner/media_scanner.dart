import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:on_audio_query/on_audio_query.dart' as aq;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import '../database/app_database.dart';
import 'scanner_events.dart';

class MediaScanner {
  final AppDatabase database;
  final aq.OnAudioQuery _audioQuery = aq.OnAudioQuery();
  final _eventController = StreamController<ScannerEvent>.broadcast();

  MediaScanner({required this.database});

  Stream<ScannerEvent> get scanEvents => _eventController.stream;

  Future<void> scanDeviceMusic({List<String> allowedFolders = const []}) async {
    _eventController.add(const ScanningStarted());

    try {
      // 1. Generate local preloaded files inside app's document directory
      final docDir = await getApplicationDocumentsDirectory();
      final localFolder = Directory('${docDir.path}/local');
      if (!await localFolder.exists()) {
        await localFolder.create(recursive: true);
      }

      final songsToCreate = {
        'Morning Meditation.wav': 'Morning Meditation',
        'Deep Focus Beats.wav': 'Deep Focus Beats',
        'Silent Sunset.wav': 'Silent Sunset',
      };

      for (final entry in songsToCreate.entries) {
        final file = File('${localFolder.path}/${entry.key}');
        if (!await file.exists()) {
          await file.writeAsBytes(_createSilentWav(2));
        }

        final songId = 'local_${entry.value.hashCode}';
        await database.into(database.songs).insertOnConflictUpdate(
          SongsCompanion(
            id: Value(songId),
            title: Value(entry.value),
            artist: const Value('Raaga Zen'),
            album: const Value('Local Preloads'),
            duration: const Value('0:02'),
            durationMs: const Value(2000),
            path: Value(file.path),
            bitrate: const Value(128000),
            trackNumber: const Value(1),
            year: const Value(2026),
            genre: const Value('Ambient'),
            folder: const Value('local'),
            artworkUrl: Value(songId),
          ),
        );

        await database.into(database.albums).insertOnConflictUpdate(
          AlbumsCompanion(
            name: const Value('Local Preloads'),
            artist: const Value('Raaga Zen'),
            artworkUrl: Value(songId),
            songCount: const Value(1),
          ),
        );

        await database.customStatement('''
          INSERT OR REPLACE INTO song_search_index (song_id, title, artist, album)
          VALUES (?, ?, ?, ?);
        ''', [songId, entry.value, 'Raaga Zen', 'Local Preloads']);
      }

      await database.into(database.folders).insertOnConflictUpdate(
        FoldersCompanion(
          path: Value(localFolder.path),
        ),
      );

      // 2. Scan external storage files if permissions are granted
      final hasPermission = await aq.OnAudioQuery().permissionsStatus();
      int externalSongsCount = 0;

      if (hasPermission) {
        final rawSongs = await _audioQuery.querySongs(
          sortType: aq.SongSortType.TITLE,
          orderType: aq.OrderType.ASC_OR_SMALLER,
          uriType: aq.UriType.EXTERNAL,
          ignoreCase: true,
        );

        _eventController.add(ScanningFolder("External Storage Root"));

        for (final raw in rawSongs) {
          final path = raw.data;
          if (!path.endsWith('.mp3') &&
              !path.endsWith('.flac') &&
              !path.endsWith('.m4a') &&
              !path.endsWith('.wav') &&
              !path.endsWith('.ogg') &&
              !path.endsWith('.aac')) {
            continue;
          }

          final parentFolder = File(path).parent.path;

          // Apply selective folder filter if configured by user
          if (allowedFolders.isNotEmpty && !allowedFolders.contains(parentFolder)) {
            continue;
          }

          final songId = raw.id.toString();
          final title = raw.title.isEmpty ? "Unknown Track" : raw.title;
          final artist = raw.artist == null || raw.artist == "<unknown>" ? "Unknown Artist" : raw.artist!;
          final album = raw.album == null || raw.album == "<unknown>" ? "Unknown Album" : raw.album!;
          final durationMs = raw.duration ?? 0;

          await database.into(database.songs).insertOnConflictUpdate(
            SongsCompanion(
              id: Value(songId),
              title: Value(title),
              artist: Value(artist),
              album: Value(album),
              duration: Value(_formatDuration(durationMs)),
              durationMs: Value(durationMs),
              path: Value(path),
              bitrate: Value(raw.size),
              trackNumber: Value(raw.track),
              year: Value(raw.bookmark),
              genre: Value(raw.composer),
              folder: Value(_getFolderName(path)),
              artworkUrl: Value(songId),
            ),
          );

          await database.into(database.albums).insertOnConflictUpdate(
            AlbumsCompanion(
              name: Value(album),
              artist: Value(artist),
              artworkUrl: Value(songId),
              songCount: const Value(1),
            ),
          );

          await database.customStatement('''
            INSERT OR REPLACE INTO song_search_index (song_id, title, artist, album)
            VALUES (?, ?, ?, ?);
          ''', [songId, title, artist, album]);

          await database.into(database.folders).insertOnConflictUpdate(
            FoldersCompanion(
              path: Value(parentFolder),
            ),
          );

          _eventController.add(SongIndexed(title: title, artist: artist));
          externalSongsCount++;
        }
      }

      _eventController.add(ScanCompleted(songsToCreate.length + externalSongsCount));
    } catch (e) {
      _eventController.add(ScanFailed(e.toString()));
    }
  }

  List<int> _createSilentWav(int durationSeconds) {
    final int sampleRate = 8000;
    final int numChannels = 1;
    final int bitsPerSample = 16;
    final int subChunk2Size = sampleRate * numChannels * (bitsPerSample ~/ 8) * durationSeconds;
    final int chunkSize = 36 + subChunk2Size;
    final int byteRate = sampleRate * numChannels * (bitsPerSample ~/ 8);
    final int blockAlign = numChannels * (bitsPerSample ~/ 8);

    final List<int> header = [
      ...ascii.encode('RIFF'),
      chunkSize & 0xFF, (chunkSize >> 8) & 0xFF, (chunkSize >> 16) & 0xFF, (chunkSize >> 24) & 0xFF,
      ...ascii.encode('WAVE'),
      ...ascii.encode('fmt '),
      16, 0, 0, 0,
      1, 0,
      numChannels, 0,
      sampleRate & 0xFF, (sampleRate >> 8) & 0xFF, (sampleRate >> 16) & 0xFF, (sampleRate >> 24) & 0xFF,
      byteRate & 0xFF, (byteRate >> 8) & 0xFF, (byteRate >> 16) & 0xFF, (byteRate >> 24) & 0xFF,
      blockAlign, 0,
      bitsPerSample, 0,
      ...ascii.encode('data'),
      subChunk2Size & 0xFF, (subChunk2Size >> 8) & 0xFF, (subChunk2Size >> 16) & 0xFF, (subChunk2Size >> 24) & 0xFF,
    ];

    final data = List<int>.filled(subChunk2Size, 0);
    return [...header, ...data];
  }

  String _formatDuration(int ms) {
    if (ms <= 0) return "0:00";
    final totalSecs = ms ~/ 1000;
    final m = totalSecs ~/ 60;
    final s = totalSecs % 60;
    return "$m:${s < 10 ? '0' : ''}$s";
  }

  String _getFolderName(String filePath) {
    final parts = filePath.split('/');
    if (parts.length > 1) {
      return parts[parts.length - 2];
    }
    return "Root";
  }

  void dispose() {
    _eventController.close();
  }
}
