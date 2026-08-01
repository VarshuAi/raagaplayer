import 'package:drift/drift.dart' hide Column;
import '../database/app_database.dart';
import 'package:raaga_music_player/music/domain/entities/song.dart' as entity;

class LibraryManager {
  final AppDatabase database;

  LibraryManager({required this.database});

  Future<List<entity.Song>> getSmartPlaylist(String type) async {
    final List<Song> rawList;

    switch (type) {
      case 'Favorites':
        rawList = await (database.select(database.songs)
              ..where((t) => t.isFavorite.equals(true)))
            .get();
        break;

      case 'Never Played':
        rawList = await database.select(database.songs).get();
        break;

      case 'High Bitrate':
        rawList = await (database.select(database.songs)
              ..where((t) => t.bitrate.isBiggerThanValue(320000)))
            .get();
        break;

      case 'Recently Added':
      default:
        rawList = await database.select(database.songs).get();
        break;
    }

    return rawList.map(_mapSong).toList();
  }

  Future<void> markSongFavorite(String songId, bool favorite) async {
    await (database.update(database.songs)
          ..where((t) => t.id.equals(songId)))
        .write(SongsCompanion(isFavorite: Value(favorite)));
  }

  Future<void> hideSong(String songId, bool hide) async {
    // Companion logic updating hidden flag
  }

  entity.Song _mapSong(Song s) {
    return entity.Song(
      id: s.id,
      title: s.title,
      artist: s.artist,
      album: s.album,
      artworkUrl: s.artworkUrl ?? '',
      sourceUrl: s.path,
      duration: Duration(milliseconds: s.durationMs ?? 0),
      isLocal: s.isLocal,
      isFavorite: s.isFavorite,
    );
  }
}
