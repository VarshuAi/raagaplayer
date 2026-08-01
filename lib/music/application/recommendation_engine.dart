import 'dart:math';
import '../../../core/database/app_database.dart' as db;
import '../domain/entities/song.dart';
import 'recommendation_weights.dart';

class RecommendationEngine {
  final db.AppDatabase _db;
  final RecommendationWeights weights;

  RecommendationEngine(this._db, {this.weights = const RecommendationWeights()});

  Future<List<Song>> getRecommendations({int limit = 20}) async {
    final allSongs = await _db.select(_db.songs).get();
    if (allSongs.isEmpty) return [];

    final stats = await _db.select(_db.playbackStatistics).get();
    final statsMap = {for (var s in stats) s.songId: s};

    final scoredSongs = <MapEntry<db.Song, double>>[];
    final now = DateTime.now();

    for (final song in allSongs) {
      double score = 0.0;
      final stat = statsMap[song.id];

      if (stat != null) {
        score += stat.playCount * weights.playCountWeight;
        score -= stat.skipCount * weights.skipPenalty;
        score += stat.completionRate * weights.completionBonus;

        if (stat.lastPlayedAt != null) {
          final daysSincePlayed = now.difference(stat.lastPlayedAt!).inDays;
          final lambda = log(2) / weights.recencyHalfLifeDays;
          score += weights.recencyBonus * exp(-lambda * daysSincePlayed);
        }
      }

      if (song.isFavorite) {
        score += weights.favoriteBonus;
      }

      // Small jitter to introduce freshness
      score += Random().nextDouble() * 0.1;

      scoredSongs.add(MapEntry(song, score));
    }

    scoredSongs.sort((a, b) => b.value.compareTo(a.value));

    return scoredSongs
        .take(limit)
        .map((entry) => _mapToSongEntity(entry.key))
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
