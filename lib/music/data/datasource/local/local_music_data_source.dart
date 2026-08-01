import 'package:drift/drift.dart' hide Column;
import 'package:raaga_music_player/music/domain/entities/song.dart' as entity;
import 'package:raaga_music_player/music/domain/entities/playlist.dart' as entity_playlist;
import 'package:raaga_music_player/music/domain/entities/search_result.dart';
import '../music_data_source.dart';
import 'package:raaga_music_player/core/database/app_database.dart';

class LocalMusicDataSource implements MusicDataSource {
  final AppDatabase database;

  LocalMusicDataSource({required this.database});

  @override
  Future<List<entity.Song>> fetchTrendingSongs() async {
    final localList = await database.select(database.songs).get();
    return localList.map(_mapSong).toList();
  }

  @override
  Future<entity.Song> fetchSongDetails(String songId) async {
    final list = await (database.select(database.songs)
          ..where((t) => t.id.equals(songId)))
        .get();
    if (list.isEmpty) throw Exception('Song not found in local catalog.');
    return _mapSong(list.first);
  }

  @override
  Future<List<entity_playlist.Playlist>> fetchFeaturedPlaylists() async {
    final localList = await database.select(database.playlists).get();
    return localList.map(_mapPlaylist).toList();
  }

  @override
  Future<SearchResult> searchSongs(String query) async {
    final pattern = '%${query.toLowerCase()}%';
    final localSongs = await (database.select(database.songs)
          ..where((t) => t.title.like(pattern) | t.artist.like(pattern)))
        .get();

    return SearchResult(
      songs: localSongs.map(_mapSong).toList(),
      albums: const [],
      artists: const [],
      playlists: const [],
    );
  }

  @override
  Future<entity_playlist.Playlist> fetchPlaylistDetails(String playlistId) async {
    final list = await (database.select(database.playlists)
          ..where((t) => t.id.equals(playlistId)))
        .get();
    if (list.isEmpty) throw Exception('Playlist not found.');
    return _mapPlaylist(list.first);
  }

  // ---------- helpers ----------

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

  entity_playlist.Playlist _mapPlaylist(Playlist p) {
    return entity_playlist.Playlist(
      id: p.id,
      name: p.name,
      description: p.description ?? '',
      artworkUrl: p.artworkUrl ?? '',
      songs: const [],
      creator: p.creator,
    );
  }
}
