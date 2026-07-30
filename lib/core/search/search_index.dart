import '../database/app_database.dart';
import 'package:drift/drift.dart';

class SearchSearchResult {
  final List<Song> songs;
  final List<Album> albums;
  final List<Artist> artists;

  SearchSearchResult({
    required this.songs,
    required this.albums,
    required this.artists,
  });
}

class SearchIndex {
  final AppDatabase database;

  SearchIndex({required this.database});

  Future<SearchSearchResult> performSearch(String query) async {
    final cleanQuery = _sanitize(query);
    if (cleanQuery.isEmpty) {
      return SearchSearchResult(songs: [], albums: [], artists: []);
    }

    // 1. Fetch all items from DB for local fuzzy/relevance ranking
    final allSongs = await database.select(database.songs).get();
    final allAlbums = await database.select(database.albums).get();
    final allArtists = await database.select(database.artists).get();

    // 2. Perform subsequence & fuzzy relevance ranking
    final matchedSongs = <_RankedItem<Song>>[];
    for (final song in allSongs) {
      final score = _calculateRelevanceScore(
        query: cleanQuery,
        targets: [song.title, song.artist, song.album],
      );
      if (score > 0) {
        matchedSongs.add(_RankedItem(song, score));
      }
    }
    matchedSongs.sort((a, b) => b.score.compareTo(a.score));

    final matchedAlbums = <_RankedItem<Album>>[];
    for (final album in allAlbums) {
      final score = _calculateRelevanceScore(
        query: cleanQuery,
        targets: [album.name, album.artist],
      );
      if (score > 0) {
        matchedAlbums.add(_RankedItem(album, score));
      }
    }
    matchedAlbums.sort((a, b) => b.score.compareTo(a.score));

    final matchedArtists = <_RankedItem<Artist>>[];
    for (final artist in allArtists) {
      final score = _calculateRelevanceScore(
        query: cleanQuery,
        targets: [artist.name],
      );
      if (score > 0) {
        matchedArtists.add(_RankedItem(artist, score));
      }
    }
    matchedArtists.sort((a, b) => b.score.compareTo(a.score));

    return SearchSearchResult(
      songs: matchedSongs.map((e) => e.item).toList(),
      albums: matchedAlbums.map((e) => e.item).toList(),
      artists: matchedArtists.map((e) => e.item).toList(),
    );
  }

  double _calculateRelevanceScore({
    required String query,
    required List<String> targets,
  }) {
    double bestScore = 0.0;
    
    for (final rawTarget in targets) {
      final target = _sanitize(rawTarget);
      if (target.isEmpty) continue;

      // Exact match
      if (target == query) {
        bestScore = _max(bestScore, 10.0);
      }
      // Starts with (Prefix search)
      else if (target.startsWith(query)) {
        bestScore = _max(bestScore, 8.0);
      }
      // Contains (Subsequence search)
      else if (target.contains(query)) {
        bestScore = _max(bestScore, 5.0);
      }
      // Basic fuzzy matching: check if characters appear in order
      else if (_isSubsequence(query, target)) {
        bestScore = _max(bestScore, 2.0);
      }
    }
    return bestScore;
  }

  bool _isSubsequence(String query, String target) {
    int qIndex = 0;
    int tIndex = 0;
    while (qIndex < query.length && tIndex < target.length) {
      if (query.codeUnitAt(qIndex) == target.codeUnitAt(tIndex)) {
        qIndex++;
      }
      tIndex++;
    }
    return qIndex == query.length;
  }

  String _sanitize(String text) {
    // Basic accent-insensitive normalization mapping (removes standard diacritics)
    var normalized = text.toLowerCase().trim();
    
    final Map<String, String> diacritics = {
      'á': 'a', 'à': 'a', 'â': 'a', 'ä': 'a', 'ã': 'a',
      'é': 'e', 'è': 'e', 'ê': 'e', 'ë': 'e',
      'í': 'i', 'ì': 'i', 'î': 'i', 'ï': 'i',
      'ó': 'o', 'ò': 'o', 'â': 'o', 'ö': 'o', 'õ': 'o',
      'ú': 'u', 'ù': 'u', 'û': 'u', 'ü': 'u',
      'ç': 'c', 'ñ': 'n'
    };
    
    diacritics.forEach((accent, replacement) {
      normalized = normalized.replaceAll(accent, replacement);
    });
    
    return normalized;
  }

  double _max(double a, double b) => a > b ? a : b;
}

class _RankedItem<T> {
  final T item;
  final double score;

  _RankedItem(this.item, this.score);
}
