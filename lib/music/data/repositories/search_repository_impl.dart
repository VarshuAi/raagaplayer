import 'dart:math';
import 'package:drift/drift.dart';
import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/database/app_database.dart';
import '../../../../plugins/provider_registry.dart';
import '../../domain/entities/search_result.dart';
import '../../domain/repositories/search_repository.dart';
import '../adapters/music_provider_adapter.dart';

class SearchRepositoryImpl implements SearchRepository {
  final AppDatabase _db;

  SearchRepositoryImpl(this._db);

  MusicProviderAdapter get _adapter => ProviderRegistry().activePlugin.adapter;

  @override
  Future<Result<SearchResult, Failure>> search(String query) async {
    try {
      if (query.trim().isNotEmpty) {
        await _db.into(_db.recentSearches).insertOnConflictUpdate(
          RecentSearchesCompanion(
            query: Value(query.trim()),
            searchedAt: Value(DateTime.now()),
          ),
        );
      }
      final result = await _adapter.search(query);
      return Result.success(result);
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<String>, Failure>> getSearchSuggestions(String query) async {
    try {
      final cleanQuery = query.trim().toLowerCase();
      if (cleanQuery.isEmpty) return const Result.success([]);

      // 1. Prefix/Contains match on titles & artists
      final matches = await _db.customSelect(
        'SELECT title, artist FROM songs WHERE title LIKE ? OR artist LIKE ? LIMIT 15',
        variables: [Variable.withString('%$cleanQuery%'), Variable.withString('%$cleanQuery%')],
      ).get();

      final suggestionsSet = <String>{};
      for (final row in matches) {
        final title = row.read<String>('title');
        final artist = row.read<String>('artist');
        suggestionsSet.add("$title - $artist");
      }

      // 2. Typo tolerance matching: scan all local songs if direct matches are low
      if (suggestionsSet.length < 5) {
        final allSongs = await _db.select(_db.songs).get();
        for (final song in allSongs) {
          final cleanTitle = song.title.toLowerCase();
          final cleanArtist = song.artist.toLowerCase();

          // Split words and compare Levenshtein distance
          final titleWords = cleanTitle.split(RegExp(r'\s+'));
          for (final word in titleWords) {
            if (word.length >= 3 && _levenshteinDistance(word, cleanQuery) <= 1) {
              suggestionsSet.add("${song.title} - ${song.artist}");
              break;
            }
          }

          final artistWords = cleanArtist.split(RegExp(r'\s+'));
          for (final word in artistWords) {
            if (word.length >= 3 && _levenshteinDistance(word, cleanQuery) <= 1) {
              suggestionsSet.add("${song.title} - ${song.artist}");
              break;
            }
          }
        }
      }

      return Result.success(suggestionsSet.take(8).toList());
    } catch (e) {
      return Result.failure(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<String>, Failure>> getSearchHistory() async {
    try {
      final list = await (_db.select(_db.recentSearches)
            ..orderBy([(t) => OrderingTerm(expression: t.searchedAt, mode: OrderingMode.desc)]))
          .get();
      return Result.success(list.map((h) => h.query).toList());
    } catch (e) {
      return Result.failure(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Result<void, Failure>> clearSearchHistory() async {
    try {
      await _db.delete(_db.recentSearches).go();
      return const Result.success(null);
    } catch (e) {
      return Result.failure(CacheFailure(e.toString()));
    }
  }

  int _levenshteinDistance(String s, String t) {
    if (s == t) return 0;
    if (s.isEmpty) return t.length;
    if (t.isEmpty) return s.length;

    List<int> v0 = List<int>.generate(t.length + 1, (i) => i);
    List<int> v1 = List<int>.filled(t.length + 1, 0);

    for (int i = 0; i < s.length; i++) {
      v1[0] = i + 1;
      for (int j = 0; j < t.length; j++) {
        int cost = (s[i] == t[j]) ? 0 : 1;
        v1[j + 1] = min(v1[j] + 1, min(v0[j + 1] + 1, v0[j] + cost));
      }
      for (int j = 0; j < v0.length; j++) {
        v0[j] = v1[j];
      }
    }
    return v0[t.length];
  }
}
