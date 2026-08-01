import '../../../core/database/app_database.dart' as db;
import '../domain/entities/song.dart';
import 'recommendation_engine.dart';

class RadioEngine {
  final db.AppDatabase _db;
  final RecommendationEngine _recEngine;

  RadioEngine(this._db) : _recEngine = RecommendationEngine(_db);

  Future<List<Song>> generateRadioQueue(Song seedSong, {int limit = 20}) async {
    final allSongs = await _db.select(_db.songs).get();
    if (allSongs.isEmpty) return [];

    final seedId = seedSong.id;
    final seedArtist = seedSong.artist.trim().toLowerCase();
    final seedAlbum = seedSong.album.trim().toLowerCase();

    String? seedGenre;
    try {
      final dbSong = allSongs.firstWhere((s) => s.id == seedId);
      seedGenre = dbSong.genre?.trim().toLowerCase();
    } catch (_) {}

    final artistSeeds = <db.Song>[];
    final genreSeeds = <db.Song>[];
    final albumSeeds = <db.Song>[];
    final fallbackSeeds = <db.Song>[];

    for (final s in allSongs) {
      if (s.id == seedId) continue;

      final songArtist = s.artist.trim().toLowerCase();
      final songAlbum = s.album.trim().toLowerCase();
      final songGenre = s.genre?.trim().toLowerCase();

      bool added = false;

      if (songArtist == seedArtist) {
        artistSeeds.add(s);
        added = true;
      }
      if (seedGenre != null && songGenre != null && songGenre == seedGenre) {
        genreSeeds.add(s);
        added = true;
      }
      if (songAlbum == seedAlbum) {
        albumSeeds.add(s);
        added = true;
      }

      if (!added) {
        fallbackSeeds.add(s);
      }
    }

    artistSeeds.shuffle();
    genreSeeds.shuffle();
    albumSeeds.shuffle();
    fallbackSeeds.shuffle();

    final recommendations = await _recEngine.getRecommendations(limit: limit);

    final radioQueue = <Song>[];
    final addedIds = <String>{seedId};

    void addSong(Song song) {
      if (addedIds.add(song.id)) {
        radioQueue.add(song);
      }
    }

    void addDbSong(db.Song s) {
      addSong(_mapToSongEntity(s));
    }

    int index = 0;
    while (radioQueue.length < limit) {
      bool progress = false;

      if (index < artistSeeds.length) {
        addDbSong(artistSeeds[index]);
        progress = true;
      }
      if (radioQueue.length >= limit) break;

      if (index < genreSeeds.length) {
        addDbSong(genreSeeds[index]);
        progress = true;
      }
      if (radioQueue.length >= limit) break;

      if (index < albumSeeds.length) {
        addDbSong(albumSeeds[index]);
        progress = true;
      }
      if (radioQueue.length >= limit) break;

      if (index < recommendations.length) {
        addSong(recommendations[index]);
        progress = true;
      }
      if (radioQueue.length >= limit) break;

      if (index < fallbackSeeds.length) {
        addDbSong(fallbackSeeds[index]);
        progress = true;
      }

      index++;

      if (!progress) {
        break;
      }
    }

    return radioQueue;
  }

  Song _mapToSongEntity(db.Song s) {
    return Song(
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
