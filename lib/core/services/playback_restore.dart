import '../database/app_database.dart' hide Song, Playlist;
import '../audio/queue_manager.dart';
import '../../domain/entities/song.dart';
import 'package:drift/drift.dart';

class PlaybackRestoreService {
  final AppDatabase database;

  PlaybackRestoreService({required this.database});

  Future<void> saveCurrentState({
    required String? songId,
    required Duration position,
    required int queueIndex,
    required bool isShuffle,
    required int repeatMode,
  }) async {
    // Write current player states to Settings / state tables
    await database.into(database.playbackStateTable).insertOnConflictUpdate(
      PlaybackStateTableCompanion(
        id: const Value(1),
        currentSongId: Value(songId),
        currentPositionMs: Value(position.inMilliseconds),
        queueIndex: Value(queueIndex),
        isShuffle: Value(isShuffle),
        repeatMode: Value(repeatMode),
      ),
    );
  }

  Future<Map<String, dynamic>?> restoreLastState() async {
    final list = await database.select(database.playbackStateTable).get();
    if (list.isEmpty) return null;

    final state = list.first;
    return {
      'currentSongId': state.currentSongId,
      'position': Duration(milliseconds: state.currentPositionMs),
      'queueIndex': state.queueIndex,
      'isShuffle': state.isShuffle,
      'repeatMode': state.repeatMode,
    };
  }

  Future<void> saveQueue(List<Song> queue) async {
    // Clear old queue items
    await database.delete(database.queueItems).go();
    
    for (int i = 0; i < queue.length; i++) {
      await database.into(database.queueItems).insert(
        QueueItemsCompanion(
          songId: Value(queue[i].id),
          sequence: Value(i),
        ),
      );
    }
  }

  Future<List<Song>> restoreQueue() async {
    final savedItems = await (database.select(database.queueItems)
          ..orderBy([(t) => OrderingTerm(expression: t.sequence)]))
        .get();

    final List<Song> restored = [];
    for (final item in savedItems) {
      final songsList = await (database.select(database.songs)
            ..where((t) => t.id.equals(item.songId)))
          .get();
      if (songsList.isNotEmpty) {
        final s = songsList.first;
        restored.add(
          Song(
            id: s.id,
            title: s.title,
            artist: s.artist,
            album: s.album,
            artworkUrl: s.artworkUrl ?? '',
            sourceUrl: s.path,
            duration: Duration(milliseconds: s.durationMs ?? 0),
            isLocal: s.isLocal,
            isFavorite: s.isFavorite,
          ),
        );
      }
    }
    return restored;
  }
}
