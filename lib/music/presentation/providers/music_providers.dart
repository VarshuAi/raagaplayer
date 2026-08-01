import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/audio/audio_state.dart';
import '../../../../core/services/playback_restore.dart';
import '../../../../core/audio/queue_manager.dart';
import '../../../features/player/provider/player_provider.dart';
import 'package:drift/drift.dart' show Value;
import 'package:just_audio/just_audio.dart' show LoopMode;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/constants/urls.dart';
import '../../application/music_backend.dart';
import '../../application/home_feed_coordinator.dart';
import '../../application/cloud_sync_coordinator.dart';
import '../../application/search_coordinator.dart';
import '../../application/playlist_coordinator.dart';
import '../../application/radio_engine.dart';
import '../../application/home_feed_engine.dart';
import '../../application/queue_coordinator.dart';
import '../../application/radio_coordinator.dart';
import '../../application/recommendation_coordinator.dart';
import '../../domain/repositories/music_repository.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/search_repository.dart';
import '../../domain/repositories/playlist_repository.dart';
import '../../data/repositories/music_repository_impl.dart';
import '../../data/repositories/search_repository_impl.dart';
import '../../data/repositories/playlist_repository_impl.dart';
import '../../domain/usecases/get_home_feed_use_case.dart';
import '../../domain/usecases/play_song_use_case.dart';
import '../../domain/usecases/search_music_use_case.dart';
import '../../domain/usecases/toggle_favorite_use_case.dart';
import '../../domain/usecases/generate_recommendations_use_case.dart';
import '../../domain/usecases/create_playlist_use_case.dart';
import '../../../../core/playback/playback_engine.dart';
import '../../../../core/playback/playback_session.dart';
import '../../../../core/playback/playback_service.dart';
import '../../../../core/playback/sleep_timer_service.dart';
import '../../../../core/streaming/media_quality_manager.dart';
import '../../../../core/streaming/streaming_engine.dart';
import '../../../../core/network/network_monitor.dart';
import '../../../../core/playback/media_pipeline.dart';
import '../../../../core/database/app_database.dart' hide Song, Playlist;
import '../../../../core/database/app_database.dart' as db_models;

final httpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(() => client.close());
  return client;
});

final musicRepositoryProvider = Provider<MusicRepository>((ref) {
  return MusicRepositoryImpl();
});

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  return SearchRepositoryImpl(ref.watch(databaseProvider));
});

final playlistRepositoryProvider = Provider<PlaylistRepository>((ref) {
  return PlaylistRepositoryImpl();
});

final getHomeFeedUseCaseProvider = Provider<GetHomeFeedUseCase>((ref) {
  return GetHomeFeedUseCase(ref.watch(musicRepositoryProvider));
});

final playSongUseCaseProvider = Provider<PlaySongUseCase>((ref) {
  return PlaySongUseCase(ref.watch(musicRepositoryProvider));
});

final searchMusicUseCaseProvider = Provider<SearchMusicUseCase>((ref) {
  return SearchMusicUseCase(ref.watch(searchRepositoryProvider));
});

final toggleFavoriteUseCaseProvider = Provider<ToggleFavoriteUseCase>((ref) {
  return ToggleFavoriteUseCase(ref.watch(musicRepositoryProvider));
});

final generateRecommendationsUseCaseProvider = Provider<GenerateRecommendationsUseCase>((ref) {
  return GenerateRecommendationsUseCase(ref.watch(musicRepositoryProvider));
});

final createPlaylistUseCaseProvider = Provider<CreatePlaylistUseCase>((ref) {
  return CreatePlaylistUseCase(ref.watch(playlistRepositoryProvider));
});

final homeFeedCoordinatorProvider = Provider<HomeFeedCoordinator>((ref) {
  return HomeFeedCoordinator(ref.watch(getHomeFeedUseCaseProvider));
});

final searchCoordinatorProvider = Provider<SearchCoordinator>((ref) {
  return SearchCoordinator(ref.watch(searchMusicUseCaseProvider));
});

final playlistCoordinatorProvider = Provider<PlaylistCoordinator>((ref) {
  return PlaylistCoordinator(ref.watch(createPlaylistUseCaseProvider));
});

final queueCoordinatorProvider = Provider<QueueCoordinator>((ref) {
  return QueueCoordinator();
});

final radioCoordinatorProvider = Provider<RadioCoordinator>((ref) {
  return RadioCoordinator();
});

final recommendationCoordinatorProvider = Provider<RecommendationCoordinator>((ref) {
  return RecommendationCoordinator(ref.watch(generateRecommendationsUseCaseProvider));
});

final musicBackendProvider = Provider<MusicBackend>((ref) {
  return MusicBackend(
    musicRepository: ref.watch(musicRepositoryProvider),
    searchRepository: ref.watch(searchRepositoryProvider),
    playlistRepository: ref.watch(playlistRepositoryProvider),
    homeFeedCoordinator: ref.watch(homeFeedCoordinatorProvider),
    searchCoordinator: ref.watch(searchCoordinatorProvider),
    playlistCoordinator: ref.watch(playlistCoordinatorProvider),
    queueCoordinator: ref.watch(queueCoordinatorProvider),
    radioCoordinator: ref.watch(radioCoordinatorProvider),
    recommendationCoordinator: ref.watch(recommendationCoordinatorProvider),
  );
});

// Core Playback Providers
final corePlaybackEngineProvider = Provider<PlaybackEngine>((ref) {
  final engine = PlaybackEngine();
  ref.onDispose(() => engine.dispose());
  return engine;
});

final mediaQualityManagerProvider = Provider<MediaQualityManager>((ref) {
  return MediaQualityManager(database: ref.watch(databaseProvider));
});

final networkMonitorProvider = Provider<NetworkMonitor>((ref) {
  return NetworkMonitor();
});

final streamingEngineProvider = Provider<StreamingEngine>((ref) {
  return StreamingEngine(
    client: ref.watch(httpClientProvider),
    qualityManager: ref.watch(mediaQualityManagerProvider),
    networkMonitor: ref.watch(networkMonitorProvider),
  );
});

final mediaPipelineProvider = Provider<MediaPipeline>((ref) {
  return MediaPipeline(
    ref.watch(corePlaybackEngineProvider),
    ref.watch(streamingEngineProvider),
  );
});

final coreSleepTimerServiceProvider = Provider<SleepTimerService>((ref) {
  final service = SleepTimerService(ref.watch(corePlaybackEngineProvider));
  ref.onDispose(() => service.dispose());
  return service;
});

final corePlaybackServiceProvider = Provider<PlaybackService>((ref) {
  return PlaybackService(ref.watch(corePlaybackEngineProvider));
});

final cloudSyncCoordinatorProvider = Provider<CloudSyncCoordinator>((ref) {
  return CloudSyncCoordinator(
    database: ref.watch(databaseProvider),
    httpClient: ref.watch(httpClientProvider),
  );
});

class PlaybackSessionNotifier extends StateNotifier<PlaybackSession> {
  final Ref _ref;
  late final PlaybackRestoreService _restoreService;
  int? _lastSessionId;

  PlaybackSessionNotifier(this._ref) : super(const PlaybackSession()) {
    final db = _ref.read(databaseProvider);
    _restoreService = PlaybackRestoreService(database: db);

    final engine = _ref.read(corePlaybackEngineProvider);
    
    engine.positionStream.listen((pos) {
      state = state.copyWith(position: pos);
      if (pos.inSeconds > 0 && pos.inSeconds % 5 == 0) {
        _saveState();
      }
    });

    engine.durationStream.listen((dur) {
      state = state.copyWith(duration: dur);
    });

    engine.playbackStateStream.listen((playbackState) {
      final oldState = state.state;
      state = state.copyWith(state: playbackState);

      if (playbackState == RaagaPlaybackState.completed) {
        _logSessionCompletion(true);
        playNext();
      } else if (playbackState == RaagaPlaybackState.paused && oldState == RaagaPlaybackState.playing) {
        // Paused state saves state instantly
        _saveState();
      }
    });

    try {
      engine.audioHandler.setMediaControlCallbacks(
        onSkipNext: () => playNext(),
        onSkipPrevious: () => playPrevious(),
      );
    } catch (_) {}
  }

  void updateSession(PlaybackSession next) {
    state = next;
  }

  /// Returns true if [url] is a directly streamable audio URL.
  bool _isDirectAudioUrl(String url) {
    if (url.isEmpty) return false;
    final lower = url.toLowerCase();
    return lower.contains('.mp3') ||
        lower.contains('.m4a') ||
        lower.contains('.aac') ||
        lower.contains('/api/stream') ||
        lower.contains('akamaized.net') ||
        lower.contains('jiocdn.com') ||
        lower.contains('jiosaavncdn.com') ||
        lower.contains('c.saavncdn') ||
        lower.startsWith('/data/');
  }

  Future<void> playSong(Song song, {List<Song>? queue, int? index}) async {
    // Log previous session as skipped or incomplete if changing track
    if (state.currentSong != null && state.currentSong!.id != song.id) {
      await _logSessionCompletion(false);
    }

    if (queue != null && queue.isNotEmpty) {
      QueueManager().setQueue(queue, initialIndex: index ?? queue.indexOf(song));
    } else {
      final currentItems = QueueManager().currentQueue.items;
      final existingIndex = currentItems.indexWhere((s) => s.id == song.id);
      if (existingIndex != -1) {
        QueueManager().jumpTo(existingIndex);
      } else {
        QueueManager().setQueue([song], initialIndex: 0);
      }
    }

    state = state.copyWith(currentSong: song);
    _ref.read(currentSongProvider.notifier).state = song;

    // ── Stream URL resolution ──────────────────────────────────────────────
    // If the stored sourceUrl is a JioSaavn webpage link (not a real audio
    // URL), ask the backend to resolve the actual .mp3 stream URL first.
    String resolvedUrl = song.sourceUrl;
    if (!song.isLocal && (!_isDirectAudioUrl(song.sourceUrl) || song.sourceUrl.isEmpty) && song.id.isNotEmpty) {
      try {
        final client = _ref.read(httpClientProvider);
        final uri = Uri.parse('${AppUrls.baseApiUrl}/api/song/${song.id}/stream-url');
        final response = await client.get(uri);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final resolved = data['streamUrl'] as String? ?? '';
          if (resolved.isNotEmpty) resolvedUrl = resolved;
        }
      } catch (_) {}
    }

    if (!song.isLocal && resolvedUrl.isEmpty && (song.title.isNotEmpty || song.artist.isNotEmpty)) {
      try {
        final client = _ref.read(httpClientProvider);
        final query = '${song.title} ${song.artist}'.trim();
        final uri = Uri.parse('${AppUrls.baseApiUrl}/api/search?q=${Uri.encodeComponent(query)}&limit=5');
        final response = await client.get(uri);
        if (response.statusCode == 200) {
          final data = json.decode(response.body);
          final List<dynamic> list = data['results'] ?? data['songs'] ?? (data is List ? data : []);
          if (list.isNotEmpty) {
            final first = list.first;
            String streamUrl = (first['streamingUrl'] ?? first['sourceUrl'] ?? first['streamUrl'] ?? first['media_url'] ?? '').toString();
            final songId = (first['id'] ?? first['songid'] ?? '').toString();
            if (streamUrl.isEmpty && songId.isNotEmpty) {
              streamUrl = '/api/song/$songId/stream-url';
            }
            if (streamUrl.isNotEmpty) resolvedUrl = streamUrl;
          }
        }
      } catch (_) {}
    }

    // Ensure relative API URLs (/api/stream...) are prepended with AppUrls.baseApiUrl
    if (!song.isLocal && resolvedUrl.startsWith('/')) {
      resolvedUrl = '${AppUrls.baseApiUrl}$resolvedUrl';
    }

    final engine = _ref.read(corePlaybackEngineProvider);
    await engine.setSource(resolvedUrl);
    await engine.play();

    try {
      engine.audioHandler.updateMetadata(
        id: song.id,
        title: song.title,
        artist: song.artist,
        album: song.album,
        duration: song.duration,
        artworkUri: song.artworkUrl,
      );
    } catch (_) {}

    _saveState();
    await _logSessionStart(song);

    // Fetch and append recommendations immediately for single-song queues of online tracks
    final finalQueue = QueueManager().currentQueue.items;
    if (finalQueue.length == 1 && !song.isLocal) {
      _fetchAndAppendAutoplayRecommendations(song);
    }
  }

  Future<void> playNext() async {
    if (state.repeatMode == AudioRepeatMode.one) {
      if (state.currentSong != null) {
        final engine = _ref.read(corePlaybackEngineProvider);
        await engine.seek(Duration.zero);
        await engine.play();
      }
      return;
    }

    var nextSong = QueueManager().next();

    if (nextSong == null && state.repeatMode == AudioRepeatMode.all && QueueManager().currentQueue.items.isNotEmpty) {
      QueueManager().jumpTo(0);
      nextSong = QueueManager().currentQueue.currentSong;
    }

    if (nextSong == null && state.currentSong != null) {
      try {
        final radioEngine = RadioEngine(_ref.read(databaseProvider));
        final radioSongs = await radioEngine.generateRadioQueue(state.currentSong!, limit: 10);
        if (radioSongs.isNotEmpty) {
          QueueManager().addAll(radioSongs);
          nextSong = QueueManager().next();
        }
      } catch (_) {}

      // If we still do not have a next song and the seed song is online (non-local),
      // dynamically fetch suggested tracks from the JioSaavn recommendations endpoint
      if (nextSong == null && !state.currentSong!.isLocal) {
        try {
          final client = _ref.read(httpClientProvider);
          final songId = state.currentSong!.id;
          final uri = Uri.parse('${AppUrls.baseApiUrl}/api/recommendations/songs/$songId');
          final response = await client.get(uri);
          if (response.statusCode == 200) {
            final List<dynamic> data = json.decode(response.body);
            final radioSongs = data
                .map((r) => Song(
                      id: r['id'] ?? '',
                      title: r['title'] ?? '',
                      artist: r['artist'] ?? '',
                      album: r['album'] ?? '',
                      artworkUrl: r['image'] ?? r['artworkUrl'] ?? '',
                      sourceUrl: r['streamingUrl'] ?? r['sourceUrl'] ?? '',
                      duration: Duration(seconds: r['duration'] ?? 0),
                      isLocal: false,
                      isFavorite: false,
                    ))
                .where((s) => s.id.isNotEmpty)
                .toList();

            if (radioSongs.isNotEmpty) {
              QueueManager().addAll(radioSongs);
              nextSong = QueueManager().next();
            }
          }
        } catch (e) {
          print('Failed to fetch online JioSaavn recommendations: $e');
        }
      }
    }
    if (nextSong != null) {
      await playSong(nextSong);
    }
  }

  Future<void> playPrevious() async {
    final prevSong = QueueManager().previous();
    if (prevSong != null) {
      await playSong(prevSong);
    }
  }

  Future<void> startRadioStation(String query, {Song? seedSong}) async {
    try {
      final client = _ref.read(httpClientProvider);
      List<Song> radioQueue = [];

      if (seedSong != null && seedSong.id.isNotEmpty && !seedSong.id.startsWith('radio_')) {
        final uri = Uri.parse('${AppUrls.baseApiUrl}/api/recommendations/songs/${seedSong.id}');
        final response = await client.get(uri);
        if (response.statusCode == 200) {
          final List<dynamic> data = json.decode(response.body);
          radioQueue = data.map((r) {
            String streamUrl = (r['streamingUrl'] ?? r['sourceUrl'] ?? r['streamUrl'] ?? r['media_url'] ?? '').toString();
            final songId = (r['id'] ?? r['songid'] ?? '').toString();
            if (streamUrl.isEmpty && songId.isNotEmpty) {
              streamUrl = '/api/song/$songId/stream-url';
            }
            if (streamUrl.startsWith('/')) streamUrl = '${AppUrls.baseApiUrl}$streamUrl';
            return Song(
              id: songId,
              title: (r['title'] ?? r['song'] ?? r['name'] ?? '').toString(),
              artist: (r['artist'] ?? r['singers'] ?? r['primary_artists'] ?? '').toString(),
              album: (r['album'] ?? '').toString(),
              artworkUrl: (r['artworkUrl'] ?? r['image'] ?? '').toString().replaceAll('150x150', '500x500'),
              sourceUrl: streamUrl,
              duration: Duration(seconds: r['duration'] != null ? (int.tryParse(r['duration'].toString()) ?? 180) : 180),
              isLocal: false,
              isFavorite: false,
            );
          }).where((s) => s.id.isNotEmpty && s.sourceUrl.isNotEmpty).toList();
        }
      }

      if (radioQueue.isEmpty && query.isNotEmpty) {
        final searchQueries = [query, '$query songs', '$query hits'];
        for (final q in searchQueries) {
          if (radioQueue.isNotEmpty) break;
          final uri = Uri.parse('${AppUrls.baseApiUrl}/api/search/songs?query=${Uri.encodeComponent(q)}&page=1&limit=30');
          final response = await client.get(uri);
          if (response.statusCode == 200) {
            final data = json.decode(response.body);
            final List<dynamic> list = data['results'] ?? data['songs'] ?? (data is List ? data : []);
            radioQueue = list.map((r) {
              String streamUrl = (r['streamingUrl'] ?? r['sourceUrl'] ?? r['streamUrl'] ?? r['media_url'] ?? '').toString();
              final songId = (r['id'] ?? r['songid'] ?? '').toString();
              if (streamUrl.isEmpty && songId.isNotEmpty) {
                streamUrl = '/api/song/$songId/stream-url';
              }
              if (streamUrl.startsWith('/')) streamUrl = '${AppUrls.baseApiUrl}$streamUrl';
              return Song(
                id: songId,
                title: (r['title'] ?? r['song'] ?? r['name'] ?? '').toString(),
                artist: (r['artist'] ?? r['singers'] ?? r['primary_artists'] ?? '').toString(),
                album: (r['album'] ?? '').toString(),
                artworkUrl: (r['artworkUrl'] ?? r['image'] ?? '').toString().replaceAll('150x150', '500x500'),
                sourceUrl: streamUrl,
                duration: Duration(seconds: r['duration'] != null ? (int.tryParse(r['duration'].toString()) ?? 180) : 180),
                isLocal: false,
                isFavorite: false,
              );
            }).where((s) => s.id.isNotEmpty && s.sourceUrl.isNotEmpty).toList();
          }
        }
      }

      if (radioQueue.isNotEmpty) {
        final firstSong = radioQueue.first;
        await playSong(firstSong, queue: radioQueue, index: 0);
      }
    } catch (e) {
      print('Failed to start radio station: $e');
    }
  }

  Future<void> toggleShuffle() async {
    final newShuffle = !state.shuffle;
    state = state.copyWith(shuffle: newShuffle);
    if (newShuffle) {
      final recentIds = await contextRecentlyPlayedSongIds();
      QueueManager().smartShuffle(recentIds);
    } else {
      QueueManager().shuffle();
    }
    _saveState();
  }

  void toggleRepeatMode() {
    final modes = [AudioRepeatMode.off, AudioRepeatMode.all, AudioRepeatMode.one];
    final currentIdx = modes.indexOf(state.repeatMode);
    final nextMode = modes[(currentIdx + 1) % modes.length];
    state = state.copyWith(repeatMode: nextMode);

    final engine = _ref.read(corePlaybackEngineProvider);
    if (nextMode == AudioRepeatMode.one) {
      PlaybackEngine.sharedPlayer.setLoopMode(LoopMode.one);
    } else if (nextMode == AudioRepeatMode.all) {
      PlaybackEngine.sharedPlayer.setLoopMode(LoopMode.all);
    } else {
      PlaybackEngine.sharedPlayer.setLoopMode(LoopMode.off);
    }
    _saveState();
  }

  Future<List<String>> contextRecentlyPlayedSongIds() async {
    try {
      final allSessions = await _ref.read(databaseProvider).select(_ref.read(databaseProvider).listeningSessions).get();
      final sorted = List.from(allSessions)..sort((a, b) => b.playedAt.compareTo(a.playedAt));
      return sorted.take(10).map((s) => s.songId as String).toList();
    } catch (_) {
      return [];
    }
  }

  void _saveState() {
    _restoreService.saveCurrentState(
      songId: state.currentSong?.id,
      position: state.position,
      queueIndex: QueueManager().currentQueue.currentIndex,
      isShuffle: state.shuffle,
      repeatMode: state.repeatMode.index,
    );
  }

  Future<void> _logSessionStart(Song song) async {
    final db = _ref.read(databaseProvider);
    final now = DateTime.now();
    String timeOfDayStr = 'morning';
    final hour = now.hour;
    if (hour >= 12 && hour < 17) {
      timeOfDayStr = 'afternoon';
    } else if (hour >= 17 && hour < 22) {
      timeOfDayStr = 'evening';
    } else if (hour >= 22 || hour < 5) {
      timeOfDayStr = 'night';
    }

    final id = await db.into(db.listeningSessions).insert(
      ListeningSessionsCompanion.insert(
        songId: song.id,
        playedAt: now,
        durationSeconds: song.duration.inSeconds,
        completed: const Value(false),
        timeOfDay: timeOfDayStr,
        dayOfWeek: now.weekday,
      ),
    );
    _lastSessionId = id;

    final existingStats = await (db.select(db.playbackStatistics)
          ..where((t) => t.songId.equals(song.id)))
        .get();

    if (existingStats.isEmpty) {
      await db.into(db.playbackStatistics).insert(
        PlaybackStatisticsCompanion.insert(
          songId: song.id,
          playCount: const Value(1),
          skipCount: const Value(0),
          completionRate: const Value(0.0),
          lastPlayedAt: Value(now),
        ),
      );
    } else {
      final current = existingStats.first;
      await db.into(db.playbackStatistics).insertOnConflictUpdate(
        PlaybackStatisticsCompanion(
          songId: Value(song.id),
          playCount: Value(current.playCount + 1),
          lastPlayedAt: Value(now),
        ),
      );
    }
  }

  Future<void> _logSessionCompletion(bool completed) async {
    if (_lastSessionId == null) return;
    final db = _ref.read(databaseProvider);

    final sessionList = await (db.select(db.listeningSessions)
          ..where((t) => t.id.equals(_lastSessionId!)))
        .get();
    if (sessionList.isEmpty) return;
    final session = sessionList.first;

    final songId = session.songId;
    final playedDuration = state.position.inSeconds;
    final totalDuration = session.durationSeconds;
    final completionPct = totalDuration > 0 ? (playedDuration / totalDuration) : 0.0;

    await db.into(db.listeningSessions).insertOnConflictUpdate(
      ListeningSessionsCompanion(
        id: Value(_lastSessionId!),
        songId: Value(songId),
        playedAt: Value(session.playedAt),
        durationSeconds: Value(playedDuration),
        completed: Value(completed || completionPct >= 0.85),
        timeOfDay: Value(session.timeOfDay),
        dayOfWeek: Value(session.dayOfWeek),
      ),
    );

    final statsList = await (db.select(db.playbackStatistics)
          ..where((t) => t.songId.equals(songId)))
        .get();
    if (statsList.isNotEmpty) {
      final current = statsList.first;
      final skipIncrement = (!completed && completionPct < 0.3) ? 1 : 0;
      final totalPlays = current.playCount;
      final newCompletionRate = ((current.completionRate * (totalPlays - 1)) + completionPct) / totalPlays;

      await db.into(db.playbackStatistics).insertOnConflictUpdate(
        PlaybackStatisticsCompanion(
          songId: Value(songId),
          skipCount: Value(current.skipCount + skipIncrement),
          completionRate: Value(newCompletionRate.clamp(0.0, 1.0)),
        ),
      );
    }

    _lastSessionId = null;
  }

  Future<void> _fetchAndAppendAutoplayRecommendations(Song song) async {
    try {
      final client = _ref.read(httpClientProvider);
      final uri = Uri.parse('${AppUrls.baseApiUrl}/api/recommendations/songs/${song.id}');
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final radioSongs = data
            .map((r) => Song(
                  id: r['id'] ?? '',
                  title: r['title'] ?? '',
                  artist: r['artist'] ?? '',
                  album: r['album'] ?? '',
                  artworkUrl: r['image'] ?? r['artworkUrl'] ?? '',
                  sourceUrl: r['streamingUrl'] ?? r['sourceUrl'] ?? '',
                  duration: Duration(seconds: r['duration'] ?? 0),
                  isLocal: false,
                  isFavorite: false,
                ))
            .where((s) => s.id.isNotEmpty)
            .toList();

        if (radioSongs.isNotEmpty) {
          QueueManager().addAll(radioSongs);
        }
      }
    } catch (e) {
      print('Failed to fetch online autoplay recommendations: $e');
    }
  }
}

final playbackSessionProvider = StateNotifierProvider<PlaybackSessionNotifier, PlaybackSession>((ref) {
  return PlaybackSessionNotifier(ref);
});

final homeSongsProvider = FutureProvider<List<Song>>((ref) async {
  final db = ref.watch(databaseProvider);
  final list = await db.select(db.songs).get();
  return list
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
});

final trendingSongsProvider = FutureProvider<List<Song>>((ref) async {
  final repo = ref.watch(musicRepositoryProvider);
  final result = await repo.getTrendingSongs();
  if (result.isSuccess) {
    return result.success;
  } else {
    return [];
  }
});

final homeFeedEngineProvider = Provider<HomeFeedEngine>((ref) {
  return HomeFeedEngine(ref.watch(databaseProvider));
});

final homeFeedProvider = FutureProvider.family<List<HomeFeedShelf>, String>((ref, language) async {
  try {
    final client = ref.watch(httpClientProvider);
    final uri = Uri.parse('${AppUrls.baseApiUrl}/api/home?language=$language');
    final response = await client.get(uri);
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final shelves = <HomeFeedShelf>[];

      for (final shelfJson in data) {
        final title = shelfJson['title'] ?? 'Trending Hits';
        final subtitle = shelfJson['subtitle'] ?? '';
        final String shelfType = shelfJson['shelfType'] ?? 'mixed';
        final List<dynamic> rawItems = shelfJson['items'] ?? [];

        final items = rawItems.map((item) {
          // For song shelves (from getTrendingSongsForLanguage), use streamUrl.
          // For album/playlist shelves, fall back to permaUrl.
          final streamUrl = item['streamUrl'] as String? ?? '';
          final permaUrl = item['permaUrl'] as String? ?? '';
          final sourceUrl = streamUrl.isNotEmpty ? streamUrl : permaUrl;

          final rawDuration = item['duration'];
          final durationSecs = rawDuration is int
              ? rawDuration
              : (rawDuration is String ? int.tryParse(rawDuration) ?? 180 : 180);

          return Song(
            id: item['id'] ?? '',
            title: item['title'] ?? 'Unknown Title',
            artist: item['artist'] ?? item['subtitle'] ?? 'Raaga Stream',
            album: item['album'] ?? title,
            artworkUrl: item['artworkUrl'] ?? '',
            sourceUrl: sourceUrl,
            duration: Duration(seconds: durationSecs),
            isLocal: false,
            isFavorite: false,
          );
        }).where((s) => s.id.isNotEmpty).toList();

        if (items.isNotEmpty) {
          shelves.add(HomeFeedShelf(
            title: title,
            subtitle: subtitle,
            items: items,
            shelfType: shelfType,
          ));
        }
      }
      if (shelves.isNotEmpty) return shelves;
    }
  } catch (e) {
    print('Home Feed Fetch Error ($language): $e');
  }

  final trending = await ref.watch(trendingSongsProvider.future);
  return [
    HomeFeedShelf(
      title: "Trending Hits (${language.toUpperCase()})",
      subtitle: "Top recommendations for $language",
      items: trending,
    )
  ];
});

final favoritesSongsProvider = FutureProvider<List<Song>>((ref) async {
  final db = ref.watch(databaseProvider);
  final rows = await (db.select(db.songs)..where((t) => t.isFavorite.equals(true))).get();
  return rows.map((s) => Song(
    id: s.id,
    title: s.title,
    artist: s.artist,
    album: s.album,
    artworkUrl: s.artworkUrl ?? '',
    sourceUrl: s.path,
    duration: Duration(milliseconds: s.durationMs ?? 0),
    isLocal: s.isLocal,
    isFavorite: s.isFavorite,
  )).toList();
});
