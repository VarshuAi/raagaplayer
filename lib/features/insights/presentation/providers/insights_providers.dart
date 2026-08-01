import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../../../music/presentation/providers/music_providers.dart';

class PlaybackInsightsData {
  final int totalMinutes;
  final int totalSongsPlayed;
  final int uniqueSongs;
  final int uniqueArtists;
  final int uniqueGenres;
  final int longestStreak;
  final int currentStreak;
  final String topSong;
  final String topArtist;
  final String topAlbum;
  final String topGenre;
  final double averageSessionMinutes;
  final double averageCompletionRate;
  final double skipRate;
  final String favoriteDecade;
  final Map<String, int> dailyListeningMinutes; // e.g. "Monday" -> 45

  const PlaybackInsightsData({
    this.totalMinutes = 0,
    this.totalSongsPlayed = 0,
    this.uniqueSongs = 0,
    this.uniqueArtists = 0,
    this.uniqueGenres = 0,
    this.longestStreak = 0,
    this.currentStreak = 0,
    this.topSong = 'None',
    this.topArtist = 'None',
    this.topAlbum = 'None',
    this.topGenre = 'None',
    this.averageSessionMinutes = 0.0,
    this.averageCompletionRate = 0.0,
    this.skipRate = 0.0,
    this.favoriteDecade = 'None',
    this.dailyListeningMinutes = const {},
  });
}

final playbackInsightsProvider = FutureProvider<PlaybackInsightsData>((ref) async {
  final db = ref.watch(databaseProvider);
  
  final sessions = await db.select(db.listeningSessions).get();
  final stats = await db.select(db.playbackStatistics).get();
  final songs = await db.select(db.songs).get();
  
  if (sessions.isEmpty) {
    return const PlaybackInsightsData();
  }

  final songMap = {for (var s in songs) s.id: s};
  final statsMap = {for (var s in stats) s.songId: s};

  // 1. Total minutes played
  int totalSeconds = 0;
  for (final s in sessions) {
    totalSeconds += s.durationSeconds;
  }
  final totalMinutes = (totalSeconds / 60).round();

  // 2. Counts
  final totalSongsPlayed = sessions.length;
  final uniqueSongIds = sessions.map((s) => s.songId).toSet();
  final uniqueSongs = uniqueSongIds.length;

  final uniqueArtists = uniqueSongIds.map((id) => songMap[id]?.artist ?? '').where((a) => a.isNotEmpty).toSet().length;
  final uniqueGenres = uniqueSongIds.map((id) => songMap[id]?.genre ?? '').where((g) => g.isNotEmpty).toSet().length;

  // 3. Top elements counts
  final songPlayCounts = <String, int>{};
  final artistPlayCounts = <String, int>{};
  final albumPlayCounts = <String, int>{};
  final genrePlayCounts = <String, int>{};
  final decadePlayCounts = <String, int>{};

  for (final session in sessions) {
    final song = songMap[session.songId];
    if (song != null) {
      songPlayCounts[song.title] = (songPlayCounts[song.title] ?? 0) + 1;
      artistPlayCounts[song.artist] = (artistPlayCounts[song.artist] ?? 0) + 1;
      albumPlayCounts[song.album] = (albumPlayCounts[song.album] ?? 0) + 1;
      if (song.genre != null && song.genre!.isNotEmpty) {
        genrePlayCounts[song.genre!] = (genrePlayCounts[song.genre!] ?? 0) + 1;
      }
      if (song.year != null && song.year! > 0) {
        final decade = "${(song.year! / 10).floor() * 10}s";
        decadePlayCounts[decade] = (decadePlayCounts[decade] ?? 0) + 1;
      }
    }
  }

  String getTopKey(Map<String, int> map) {
    if (map.isEmpty) return 'None';
    return map.entries.reduce((a, b) => a.value > b.value ? a : b).key;
  }

  final topSong = getTopKey(songPlayCounts);
  final topArtist = getTopKey(artistPlayCounts);
  final topAlbum = getTopKey(albumPlayCounts);
  final topGenre = getTopKey(genrePlayCounts);
  final favoriteDecade = getTopKey(decadePlayCounts);

  // 4. Streaks
  final sessionDates = sessions.map((s) => DateTime(s.playedAt.year, s.playedAt.month, s.playedAt.day)).toSet().toList();
  sessionDates.sort();

  int currentStreak = 0;
  int longestStreak = 0;
  int tempStreak = 0;
  DateTime? prevDate;

  final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  for (final date in sessionDates) {
    if (prevDate == null) {
      tempStreak = 1;
    } else {
      final diff = date.difference(prevDate).inDays;
      if (diff == 1) {
        tempStreak++;
      } else if (diff > 1) {
        if (tempStreak > longestStreak) longestStreak = tempStreak;
        tempStreak = 1;
      }
    }
    prevDate = date;
  }
  if (tempStreak > longestStreak) longestStreak = tempStreak;

  // Compute current streak
  if (sessionDates.isNotEmpty) {
    final lastPlayedDate = sessionDates.last;
    final diffFromToday = today.difference(lastPlayedDate).inDays;
    if (diffFromToday <= 1) {
      currentStreak = tempStreak;
    }
  }

  // 5. Rates
  double completionRateSum = 0.0;
  int completedCount = 0;
  int skipCount = 0;
  for (final stat in stats) {
    completionRateSum += stat.completionRate;
    completedCount += stat.playCount;
    skipCount += stat.skipCount;
  }
  final averageCompletionRate = stats.isNotEmpty ? (completionRateSum / stats.length) : 0.0;
  final totalInteractions = completedCount + skipCount;
  final skipRate = totalInteractions > 0 ? (skipCount / totalInteractions) : 0.0;

  // 6. Average Session Length
  // Sessions grouped within 30 minutes of each other represent one listening session
  int sessionCount = 0;
  double totalSessionMinutes = 0;
  if (sessions.isNotEmpty) {
    final sortedSessions = List<ListeningSessionsData>.from(sessions)
      ..sort((a, b) => a.playedAt.compareTo(b.playedAt));
    
    DateTime? lastTime;
    double currentSessionSeconds = 0;
    
    for (final s in sortedSessions) {
      if (lastTime == null) {
        currentSessionSeconds = s.durationSeconds.toDouble();
        sessionCount = 1;
      } else {
        final gap = s.playedAt.difference(lastTime).inMinutes;
        if (gap <= 30) {
          currentSessionSeconds += s.durationSeconds;
        } else {
          totalSessionMinutes += currentSessionSeconds / 60;
          currentSessionSeconds = s.durationSeconds.toDouble();
          sessionCount++;
        }
      }
      lastTime = s.playedAt;
    }
    totalSessionMinutes += currentSessionSeconds / 60;
  }
  final averageSessionMinutes = sessionCount > 0 ? (totalSessionMinutes / sessionCount) : 0.0;

  // 7. Daily listening
  final dailyListening = <String, int>{
    "Monday": 0,
    "Tuesday": 0,
    "Wednesday": 0,
    "Thursday": 0,
    "Friday": 0,
    "Saturday": 0,
    "Sunday": 0,
  };
  final weekdays = ["", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

  for (final s in sessions) {
    final name = weekdays[s.dayOfWeek];
    if (name.isNotEmpty) {
      dailyListening[name] = dailyListening[name]! + (s.durationSeconds / 60).round();
    }
  }

  return PlaybackInsightsData(
    totalMinutes: totalMinutes,
    totalSongsPlayed: totalSongsPlayed,
    uniqueSongs: uniqueSongs,
    uniqueArtists: uniqueArtists,
    uniqueGenres: uniqueGenres,
    longestStreak: longestStreak,
    currentStreak: currentStreak,
    topSong: topSong,
    topArtist: topArtist,
    topAlbum: topAlbum,
    topGenre: topGenre,
    averageSessionMinutes: averageSessionMinutes,
    averageCompletionRate: averageCompletionRate,
    skipRate: skipRate,
    favoriteDecade: favoriteDecade,
    dailyListeningMinutes: dailyListening,
  );
});
