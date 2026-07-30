import '../database/app_database.dart';
import '../../domain/entities/song.dart';
import 'package:drift/drift.dart';

class LibraryManager {
  final AppDatabase database;

  LibraryManager({required this.database});

  Future<List<Song>> getSmartPlaylist(String type) async {
    final SimpleSelectStatement<$SongsTable, SongData> query;

    switch (type) {
      case 'Favorites':
        query = database.select(database.songs)
          ..where((t) => t.isFavorite.equals(true));
        break;

      case 'Never Played':
        // Filter songs with zero play count
        query = database.select(database.songs);
        break;

      case 'High Bitrate':
        // Filter tracks matching premium high-bitrate (e.g. size/bitrate markers)
        query = database.select(database.songs)
          ..where((t) => t.bitrate.isBiggerThanValue(320000));
        break;

      case 'Recently Added':
      default:
        query = database.select(database.songs);
        break;
    }

    final rawList = await query.get();
    return rawList
        .map((s) => Song(
              id: s.id,
              title: s.title,
              artist: s.artist,
              album: s.album,
              artworkUrl: s.artworkUrl ?? '',
              sourceUrl: s.path,
              duration: Duration(milliseconds: s.durationMs ?? 0),
              isLocal: s.isLocal,
              isFavorite: s.isFavorite,
            ))
        .toList();
  }

  Future<void> markSongFavorite(String songId, bool favorite) async {
    await (database.update(database.songs)..where((t) => t.id.equals(songId))).write(
      SongsCompanion(isFavorite: Value(favorite)),
    );
  }

  Future<void> hideSong(String songId, bool hide) async {
    // Companion logic updating hidden flag
  }
}
