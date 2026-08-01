import 'dart:math';
import '../../../core/database/app_database.dart' as db;
import '../domain/entities/song.dart';
import 'recommendation_engine.dart';
import 'recommendation_weights.dart';

class FeedContext {
  final List<db.Song> allSongs;
  final List<db.PlaybackStatistic> allStats;
  final List<db.ListeningSession> allSessions;
  final List<db.Download> completedDownloads;
  final DateTime now;

  FeedContext({
    required this.allSongs,
    required this.allStats,
    required this.allSessions,
    required this.completedDownloads,
    required this.now,
  });
}

class HomeFeedShelf {
  final String title;
  final String subtitle;
  final List<Song> items;
  /// 'songs' for flat song lists, 'mixed' for album/playlist cards
  final String shelfType;

  HomeFeedShelf({
    required this.title,
    required this.subtitle,
    required this.items,
    this.shelfType = 'mixed',
  });
}


class HomeFeedEngine {
  final db.AppDatabase _db;
  final RecommendationEngine _recEngine;

  HomeFeedEngine(this._db) : _recEngine = RecommendationEngine(_db);

  Future<List<HomeFeedShelf>> getHomeFeed() async {
    final now = DateTime.now();

    final allSongs = await _db.select(_db.songs).get();
    final allStats = await _db.select(_db.playbackStatistics).get();
    final allSessions = await _db.select(_db.listeningSessions).get();
    final allDownloads = await _db.select(_db.downloads).get();
    final completedDownloads = allDownloads.where((d) => d.status == 2).toList();

    final context = FeedContext(
      allSongs: allSongs,
      allStats: allStats,
      allSessions: allSessions,
      completedDownloads: completedDownloads,
      now: now,
    );

    final shelves = <HomeFeedShelf>[];
    final statsMap = {for (var s in context.allStats) s.songId: s};
    final downloadsSet = {for (var d in context.completedDownloads) d.songId};

    final hour = now.hour;
    String greeting;
    String greetingSubtitle;
    if (hour < 12) {
      greeting = "Good Morning";
      greetingSubtitle = "Start your day with these positive vibes";
    } else if (hour < 17) {
      greeting = "Good Afternoon";
      greetingSubtitle = "Keep going strong with this midday selection";
    } else if (hour < 22) {
      greeting = "Good Evening";
      greetingSubtitle = "Unwind and relax after a busy day";
    } else {
      greeting = "Good Night";
      greetingSubtitle = "Soothing sounds to close your day";
    }

    if (context.allSongs.isNotEmpty) {
      final continueListeningList = _compileContinueListening(context, statsMap);
      _addShelfIfNotEmpty(shelves, HomeFeedShelf(
        title: "Continue Listening",
        subtitle: "Pick up right where you left off",
        items: continueListeningList,
      ));

      final timeMix = _compileTimeOfDayMix(context, hour);
      _addShelfIfNotEmpty(shelves, HomeFeedShelf(
        title: greeting,
        subtitle: greetingSubtitle,
        items: timeMix,
      ));

      final quickPicks = await _recEngine.getRecommendations(limit: 8);
      _addShelfIfNotEmpty(shelves, HomeFeedShelf(
        title: "Quick Picks",
        subtitle: "Personalized tracks chosen just for you",
        items: quickPicks,
      ));

      final favorites = context.allSongs.where((s) => s.isFavorite).map(_mapToSongEntity).toList();
      _addShelfIfNotEmpty(shelves, HomeFeedShelf(
        title: "Your Favorites",
        subtitle: "The songs you love the most",
        items: favorites,
      ));

      final recentlyPlayed = _compileRecentlyPlayed(context);
      _addShelfIfNotEmpty(shelves, HomeFeedShelf(
        title: "Recently Played",
        subtitle: "Your recent musical journey",
        items: recentlyPlayed,
      ));

      final mostPlayed = _compileMostPlayed(context, statsMap);
      _addShelfIfNotEmpty(shelves, HomeFeedShelf(
        title: "Most Played",
        subtitle: "Your all-time hits",
        items: mostPlayed,
      ));

      final forgotten = _compileForgottenSongs(context, statsMap);
      _addShelfIfNotEmpty(shelves, HomeFeedShelf(
        title: "Forgotten Gems",
        subtitle: "Songs you used to play, but haven't recently",
        items: forgotten,
      ));

      final downloaded = context.allSongs
          .where((s) => downloadsSet.contains(s.id) || s.isLocal)
          .map(_mapToSongEntity)
          .toList();
      _addShelfIfNotEmpty(shelves, HomeFeedShelf(
        title: "Available Offline",
        subtitle: "Downloaded and local tracks",
        items: downloaded,
      ));

      final focus = _compileFocusMix(context);
      _addShelfIfNotEmpty(shelves, HomeFeedShelf(
        title: "Focus Mix",
        subtitle: "Ambient and instrumental study helpers",
        items: focus,
      ));
    }

    return shelves;
  }

  void _addShelfIfNotEmpty(List<HomeFeedShelf> shelves, HomeFeedShelf shelf, {int minItems = 1}) {
    if (shelf.items.isNotEmpty) {
      shelves.add(shelf);
    }
  }

  List<Song> _compileContinueListening(FeedContext context, Map<String, db.PlaybackStatistic> statsMap) {
    final partialSongIds = context.allSessions
        .where((s) => !s.completed && s.durationSeconds > 15)
        .map((s) => s.songId)
        .toSet();

    return context.allSongs
        .where((s) => partialSongIds.contains(s.id))
        .map(_mapToSongEntity)
        .toList();
  }

  List<Song> _compileTimeOfDayMix(FeedContext context, int hour) {
    String targetPattern = "";
    if (hour < 12) {
      targetPattern = "morning|acoustic|energetic|motivation";
    } else if (hour < 17) {
      targetPattern = "focus|work|pop|dance";
    } else if (hour < 22) {
      targetPattern = "chill|unwind|lofi|jazz|relax";
    } else {
      targetPattern = "sleep|ambient|classical|slow";
    }

    final regex = RegExp(targetPattern, caseSensitive: false);
    return context.allSongs
        .where((s) => s.genre != null && regex.hasMatch(s.genre!))
        .map(_mapToSongEntity)
        .toList();
  }

  List<Song> _compileRecentlyPlayed(FeedContext context) {
    final sortedSessions = List<db.ListeningSession>.from(context.allSessions)
      ..sort((a, b) => b.playedAt.compareTo(a.playedAt));

    final uniqueSongIds = <String>{};
    final list = <Song>[];

    for (final session in sortedSessions) {
      if (uniqueSongIds.add(session.songId)) {
        final matches = context.allSongs.where((s) => s.id == session.songId);
        if (matches.isNotEmpty) {
          list.add(_mapToSongEntity(matches.first));
        }
      }
      if (list.length >= 10) break;
    }
    return list;
  }

  List<Song> _compileMostPlayed(FeedContext context, Map<String, db.PlaybackStatistic> statsMap) {
    final sortedStats = List<db.PlaybackStatistic>.from(context.allStats)
      ..sort((a, b) => b.playCount.compareTo(a.playCount));

    final list = <Song>[];
    for (final stat in sortedStats) {
      final matches = context.allSongs.where((s) => s.id == stat.songId);
      if (matches.isNotEmpty) {
        list.add(_mapToSongEntity(matches.first));
      }
      if (list.length >= 10) break;
    }
    return list;
  }

  List<Song> _compileForgottenSongs(FeedContext context, Map<String, db.PlaybackStatistic> statsMap) {
    final list = <Song>[];
    for (final song in context.allSongs) {
      final stat = statsMap[song.id];
      if (stat != null && stat.playCount > 3 && stat.lastPlayedAt != null) {
        final days = context.now.difference(stat.lastPlayedAt!).inDays;
        if (days >= 30) {
          list.add(_mapToSongEntity(song));
        }
      }
    }
    return list;
  }

  List<Song> _compileFocusMix(FeedContext context) {
    final regex = RegExp("ambient|classical|focus|study|instrumental", caseSensitive: false);
    return context.allSongs
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
