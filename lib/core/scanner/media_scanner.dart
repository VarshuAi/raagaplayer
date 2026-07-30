import 'package:on_audio_query/on_audio_query.dart' as aq;
import '../database/app_database.dart';
import 'scanner_events.dart';
import 'dart:async';
import 'package:drift/drift.dart';

class MediaScanner {
  final AppDatabase database;
  final aq.OnAudioQuery _audioQuery = aq.OnAudioQuery();
  final _eventController = StreamController<ScannerEvent>.broadcast();

  MediaScanner({required this.database});

  Stream<ScannerEvent> get scanEvents => _eventController.stream;

  Future<void> scanDeviceMusic() async {
    _eventController.add(const ScanningStarted());

    try {
      // 1. Fetch songs using on_audio_query
      final rawSongs = await _audioQuery.querySongs(
        sortType: aq.SongSortType.TITLE,
        orderType: aq.OrderType.ASC_OR_SMALLER,
        uriType: aq.UriType.EXTERNAL,
        ignoreCase: true,
      );

      _eventController.add(ScanningFolder("External Storage Root"));

      int songsCount = 0;
      final Set<String> activeSongIds = {};

      for (final raw in rawSongs) {
        // Skip files that aren't common audio types
        final path = raw.data;
        if (!path.endsWith('.mp3') &&
            !path.endsWith('.flac') &&
            !path.endsWith('.m4a') &&
            !path.endsWith('.wav') &&
            !path.endsWith('.ogg') &&
            !path.endsWith('.aac')) {
          continue;
        }

        final songId = raw.id.toString();
        activeSongIds.add(songId);

        // Deduce metadata properties
        final title = raw.title.isEmpty ? "Unknown Track" : raw.title;
        final artist = raw.artist == null || raw.artist == "<unknown>" ? "Unknown Artist" : raw.artist!;
        final album = raw.album == null || raw.album == "<unknown>" ? "Unknown Album" : raw.album!;
        
        final durationMs = raw.duration ?? 0;
        final durationStr = _formatDuration(durationMs);

        // 2. Perform incremental index insert into Drift Database
        // We write directly to Drift database using companion objects
        await database.into(database.songs).insertOnConflictUpdate(
          SongsCompanion(
            id: Value(songId),
            title: Value(title),
            artist: Value(artist),
            album: Value(album),
            duration: Value(durationStr),
            durationMs: Value(durationMs),
            path: Value(path),
            bitrate: Value(raw.size), // placeholder size metric
            trackNumber: Value(raw.track),
            year: Value(raw.bookmark), // placeholder year metric
            genre: Value(raw.composer), // placeholder genre metric
            folder: Value(_getFolderName(path)),
            artworkUrl: Value(songId), // We cache using song id
          ),
        );

        // Add album and artist to catalog
        await database.into(database.albums).insertOnConflictUpdate(
          AlbumsCompanion(
            name: Value(album),
            artist: Value(artist),
            artworkUrl: Value(songId),
            songCount: const Value(1),
          ),
        );

        _eventController.add(SongIndexed(title: title, artist: artist));
        songsCount++;
      }

      // 3. Clean up deleted songs (any song path in database that is NOT present in scanned raw list)
      final existingSongs = await database.select(database.songs).get();
      for (final song in existingSongs) {
        if (!activeSongIds.contains(song.id)) {
          await (database.delete(database.songs)..where((t) => t.id.equals(song.id))).go();
          _eventController.add(SongRemoved(song.path));
        }
      }

      _eventController.add(ScanCompleted(songsCount));
    } catch (e) {
      _eventController.add(ScanFailed(e.toString()));
    }
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
