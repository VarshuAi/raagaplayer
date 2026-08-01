import '../../../core/database/app_database.dart' as db;
import '../domain/entities/song.dart';

enum SmartPlaylistType {
  favorites,
  neverPlayed,
  recentlyAdded,
  recentlyPlayed,
  mostPlayed,
  leastPlayed,
  downloaded,
  highRated,
  longSongs,
  shortSongs,
  workout,
  focus,
  sleep,
  roadTrip,
  relax,
  instrumental,
  forgottenFavorites,
  hiddenGems,
  recentlyDownloaded,
  newThisWeek,
  randomDiscovery,
  recentlySkipped
}

class SmartPlaylistEngine {
  final db.AppDatabase _db;

  SmartPlaylistEngine(this._db);

  Future<List<Song>> getPlaylistTracks(SmartPlaylistType type) async {
    final allSongs = await _db.select(_db.songs).get();
    if (allSongs.isEmpty) return [];

    final stats = await _db.select(_db.playbackStatistics).get();
    final statsMap = {for (var s in stats) s.songId: s};
    final now = DateTime.now();

    switch (type) {
      case SmartPlaylistType.favorites:
        return allSongs.where((s) => s.isFavorite).map(_mapToSongEntity).toList();

      case SmartPlaylistType.neverPlayed:
        return allSongs.where((s) {
          final stat = statsMap[s.id];
          return stat == null || stat.playCount == 0;
        }).map(_mapToSongEntity).toList();

      case SmartPlaylistType.recentlyAdded:
        final sorted = List<db.Song>.from(allSongs)
          ..sort((a, b) => b.id.compareTo(a.id));
        return sorted.take(25).map(_mapToSongEntity).toList();

      case SmartPlaylistType.recentlyPlayed:
        final played = allSongs.where((s) {
          final stat = statsMap[s.id];
          return stat != null && stat.lastPlayedAt != null;
        }).toList();
        played.sort((a, b) => statsMap[b.id]!.lastPlayedAt!.compareTo(statsMap[a.id]!.lastPlayedAt!));
        return played.take(25).map(_mapToSongEntity).toList();

      case SmartPlaylistType.mostPlayed:
        final played = allSongs.where((s) {
          final stat = statsMap[s.id];
          return stat != null && stat.playCount > 0;
        }).toList();
        played.sort((a, b) => statsMap[b.id]!.playCount.compareTo(statsMap[a.id]!.playCount));
        return played.take(25).map(_mapToSongEntity).toList();

      case SmartPlaylistType.leastPlayed:
        final played = allSongs.where((s) {
          final stat = statsMap[s.id];
          return stat != null && stat.playCount > 0;
        }).toList();
        played.sort((a, b) => statsMap[a.id]!.playCount.compareTo(statsMap[b.id]!.playCount));
        return played.take(25).map(_mapToSongEntity).toList();

      case SmartPlaylistType.downloaded:
        final allDownloads = await _db.select(_db.downloads).get();
        final dlSongIds = allDownloads.where((d) => d.status == 2).map((d) => d.songId).toSet();
        return allSongs.where((s) => dlSongIds.contains(s.id) || s.isLocal).map(_mapToSongEntity).toList();

      case SmartPlaylistType.highRated:
        return allSongs.where((s) {
          final stat = statsMap[s.id];
          return s.isFavorite || (stat != null && stat.completionRate >= 0.8);
        }).map(_mapToSongEntity).toList();

      case SmartPlaylistType.longSongs:
        return allSongs
            .where((s) => (s.durationMs ?? 0) >= 300000)
            .map(_mapToSongEntity)
            .toList();

      case SmartPlaylistType.shortSongs:
        return allSongs
            .where((s) => (s.durationMs ?? 0) > 0 && (s.durationMs ?? 0) <= 120000)
            .map(_mapToSongEntity)
            .toList();

      case SmartPlaylistType.workout:
        return _filterByGenres(allSongs, ["workout", "energetic", "gym", "electronic", "fast", "dance"]);

      case SmartPlaylistType.focus:
        return _filterByGenres(allSongs, ["focus", "study", "ambient", "classical", "instrumental", "calm"]);

      case SmartPlaylistType.sleep:
        return _filterByGenres(allSongs, ["sleep", "slow", "ambient", "peaceful", "soft"]);

      case SmartPlaylistType.roadTrip:
        return _filterByGenres(allSongs, ["rock", "pop", "roadtrip", "driving", "indie", "alternative"]);

      case SmartPlaylistType.relax:
        return _filterByGenres(allSongs, ["relax", "acoustic", "lofi", "chill", "jazz", "blues"]);

      case SmartPlaylistType.instrumental:
        return _filterByGenres(allSongs, ["instrumental", "classical", "soundtrack", "piano"]);

      case SmartPlaylistType.forgottenFavorites:
        return allSongs.where((s) {
          final stat = statsMap[s.id];
          if (!s.isFavorite || stat == null || stat.lastPlayedAt == null) return false;
          return now.difference(stat.lastPlayedAt!).inDays >= 30;
        }).map(_mapToSongEntity).toList();

      case SmartPlaylistType.hiddenGems:
        return allSongs.where((s) {
          final stat = statsMap[s.id];
          if (stat == null) return false;
          return stat.playCount > 0 && stat.playCount <= 3 && stat.completionRate >= 0.85;
        }).map(_mapToSongEntity).toList();

      case SmartPlaylistType.recentlyDownloaded:
        final allDownloads = await _db.select(_db.downloads).get();
        final completed = allDownloads.where((d) => d.status == 2).toList();
        completed.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        final dlIds = completed.take(20).map((d) => d.songId).toSet();
        return allSongs.where((s) => dlIds.contains(s.id)).map(_mapToSongEntity).toList();

      case SmartPlaylistType.newThisWeek:
        final sorted = List<db.Song>.from(allSongs)
          ..sort((a, b) => b.id.compareTo(a.id));
        return sorted.take(15).map(_mapToSongEntity).toList();

      case SmartPlaylistType.randomDiscovery:
        final unplayed = allSongs.where((s) {
          final stat = statsMap[s.id];
          return stat == null || stat.playCount == 0;
        }).toList()..shuffle();
        return unplayed.take(20).map(_mapToSongEntity).toList();

      case SmartPlaylistType.recentlySkipped:
        final skipped = allSongs.where((s) {
          final stat = statsMap[s.id];
          return stat != null && stat.skipCount > 0;
        }).toList();
        skipped.sort((a, b) => statsMap[b.id]!.skipCount.compareTo(statsMap[a.id]!.skipCount));
        return skipped.take(20).map(_mapToSongEntity).toList();
    }
  }

  List<Song> _filterByGenres(List<db.Song> songs, List<String> targets) {
    final regex = RegExp(targets.join("|"), caseSensitive: false);
    return songs
        .where((s) => s.genre != null && regex.hasMatch(s.genre!))
        .map(_mapToSongEntity)
        .toList();
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
