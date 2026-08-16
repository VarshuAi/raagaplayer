import 'dart:io';
import 'dart:math' show min;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../../../../core/audio/audio_state.dart';
import '../../../../core/services/playback_restore.dart';
import '../../../../core/audio/queue_manager.dart';
import '../../../features/player/provider/player_provider.dart';
import 'package:drift/drift.dart' show Value, Variable;
import 'package:just_audio/just_audio.dart' show LoopMode;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../core/constants/urls.dart';
import '../../data/datasource/remote/ytmusic_client.dart';
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

void logToFile(String msg) {
  print(msg);
  try {
    getApplicationDocumentsDirectory().then((dir) {
      final file = File(p.join(dir.path, 'raaga_debug.log'));
      file.writeAsStringSync('${DateTime.now().toIso8601String()}: $msg\n', mode: FileMode.append);
    }).catchError((_) {});
  } catch (_) {}
}

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
  bool _isTransitioning = false; // Suppresses engine stream updates during track changes

  PlaybackSessionNotifier(this._ref) : super(const PlaybackSession()) {
    final db = _ref.read(databaseProvider);
    _restoreService = PlaybackRestoreService(database: db);

    final engine = _ref.read(corePlaybackEngineProvider);
    
    engine.positionStream.listen((pos) {
      if (_isTransitioning) return;
      state = state.copyWith(position: pos);
      if (pos.inSeconds > 0 && pos.inSeconds % 5 == 0) {
        _saveState();
      }
    });

    engine.durationStream.listen((dur) {
      state = state.copyWith(duration: dur);
      print('[PlaybackNotifier] Duration update: ${dur.inSeconds}s');
    });

    engine.playbackStateStream.listen((playbackState) {
      print('[PlaybackNotifier] Engine state event: $playbackState (isTransitioning=$_isTransitioning)');
      if (_isTransitioning) return; // ignore idle/loading noise during track change
      final oldState = state.state;
      state = state.copyWith(state: playbackState);
      print('[PlaybackNotifier] UI State updated to: $playbackState');

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

    // Set state to loading IMMEDIATELY and stop old song playback
    _isTransitioning = true; // Block engine stream events during transition
    state = state.copyWith(
      currentSong: song,
      state: RaagaPlaybackState.loading,
      position: Duration.zero,
      duration: song.duration,
    );
    _ref.read(currentSongProvider.notifier).state = song;

    final engine = _ref.read(corePlaybackEngineProvider);
    try {
      await engine.stop(); // Stop the previous song audio immediately!
    } catch (_) {}

    // ── Resolve playback URL ──────────────────────────────────────────────
    String resolvedUrl = '';

    if (song.isLocal) {
      // ── Offline / downloaded song — play from local file ──────────────
      String localPath = song.sourceUrl;

      // Fallback: look it up in the downloads DB in case sourceUrl is stale
      if (localPath.isEmpty || localPath.startsWith('/api/')) {
        try {
          final db = _ref.read(databaseProvider);
          final rows = await db.customSelect(
            'SELECT path FROM downloads WHERE song_id = ? AND status = 2 LIMIT 1',
            variables: [Variable.withString(song.id)],
          ).get();
          if (rows.isNotEmpty) {
            localPath = rows.first.read<String>('path');
          }
        } catch (e) {
          print('[playSong] Failed to look up download path: $e');
        }
      }

      // Strip file:// prefix if present to verify path existence
      if (localPath.startsWith('file://')) {
        localPath = localPath.substring(7);
      }

      // Check if file exists; if not, resolve it dynamically in current downloads directories
      File audioFile = File(localPath);
      if (localPath.isEmpty || !audioFile.existsSync()) {
        print('[playSong] Local file not found at: "$localPath". Resolving path dynamically...');
        try {
          final filename = '${song.id}.mp3';
          // Try external storage directory
          final extDir = await getExternalStorageDirectory();
          if (extDir != null) {
            final testFile = File(p.join(extDir.path, 'Raaga', 'downloads', filename));
            if (testFile.existsSync()) {
              localPath = testFile.path;
            }
          }
          // Try app docs directory fallback
          if (localPath.isEmpty || !File(localPath).existsSync()) {
            final docDir = await getApplicationDocumentsDirectory();
            final testFile = File(p.join(docDir.path, 'downloads', filename));
            if (testFile.existsSync()) {
              localPath = testFile.path;
            }
          }
        } catch (e) {
          print('[playSong] Error checking path dynamically: $e');
        }
      }

      if (localPath.isEmpty || !File(localPath).existsSync()) {
        print('[playSong] Failed to find downloaded file for ${song.id} anywhere');
        _isTransitioning = false;
        state = state.copyWith(state: RaagaPlaybackState.error);
        return;
      }

      // Use raw file path directly for just_audio setFilePath to avoid URI parsing bugs
      resolvedUrl = localPath;
      print('[playSong] Playing local file path: $resolvedUrl');

    } else if (song.id.isNotEmpty && song.id.length == 11) {
      // ── Online song — resolve YouTube stream URL ───────────────────────
      try {
        logToFile('[playSong] Starting stream resolution for song: ${song.id}...');

        StreamManifest? manifest;
        // Try Android VR client first (works without 403 on client side)
        try {
          manifest = await ytExplode.videos.streams.getManifest(
            song.id,
            ytClients: [YoutubeApiClient.androidVr],
          ).timeout(const Duration(seconds: 15));
        } catch (e) {
          logToFile('[playSong] Android VR stream resolution failed: $e. Trying Android standard...');
        }

        // Try Android standard client next
        if (manifest == null) {
          try {
            manifest = await ytExplode.videos.streams.getManifest(
              song.id,
              ytClients: [YoutubeApiClient.android],
            ).timeout(const Duration(seconds: 15));
          } catch (e) {
            logToFile('[playSong] Android standard stream resolution failed: $e. Trying standard client fallback...');
          }
        }

        // Try standard default client fallback
        if (manifest == null) {
          try {
            manifest = await ytExplode.videos.streams.getManifest(
              song.id,
            ).timeout(const Duration(seconds: 20));
          } catch (e) {
            logToFile('[playSong] Standard client fallback failed: $e');
          }
        }

        if (manifest != null) {
          final mp4Streams = manifest.audioOnly.where((s) => s.container == StreamContainer.mp4);
          resolvedUrl = mp4Streams.isNotEmpty
              ? mp4Streams.withHighestBitrate().url.toString()
              : manifest.audioOnly.withHighestBitrate().url.toString();
          logToFile('[playSong] Resolved stream URL: ${resolvedUrl.substring(0, min(60, resolvedUrl.length))}...');
        } else {
          logToFile('[playSong] Direct resolution failed for song ${song.id} — all clients failed.');
        }
      } catch (e) {
        logToFile('[playSong] Direct resolution exception for song ${song.id}: $e');
      }
    }

    if (resolvedUrl.isEmpty) {
      logToFile('[playSong] Stream resolution failed and no fallback available.');
      _isTransitioning = false;
      state = state.copyWith(state: RaagaPlaybackState.error);
      try {
        await engine.setSource(''); // Clear source so play button does not play the old track
      } catch (_) {}
      return;
    }

    bool success = false;
    try {
      logToFile('[playSong] Setting engine source to: ${resolvedUrl.substring(0, min(60, resolvedUrl.length))}...');
      await engine.setSource(resolvedUrl);
      _isTransitioning = false; // Allow engine events through once source is set
      logToFile('[playSong] Calling engine.play()...');
      await engine.play();
      success = true;
      logToFile('[playSong] Playback started successfully!');
    } catch (e) {
      logToFile('[playSong] Direct playback failed: $e');
    }

    if (!success && !song.isLocal) {
      logToFile('[playSong] Direct playback failed. Attempting Invidious proxy fallback...');
      final httpClient = _ref.read(httpClientProvider);
      final hosts = [
        'inv.nadeko.net',
        'invidious.nerdvpn.de',
        'invidious.f5.si',
        'yt.chocolatemoo53.com',
        'invidious.tiekoetter.com',
        'inv.zoomerville.com'
      ];
      String fallbackUrl = '';
      for (final host in hosts) {
        try {
          final testUri = Uri.parse('https://$host/latest_version?id=${song.id}&itag=140&local=true');
          logToFile('[playSong] Checking fallback host: $host');
          final res = await httpClient.head(testUri).timeout(const Duration(seconds: 4));
          if (res.statusCode == 200 || res.statusCode == 302 || res.statusCode == 206) {
            fallbackUrl = testUri.toString();
            logToFile('[playSong] Found active fallback host: $host');
            break;
          }
        } catch (err) {
          logToFile('[playSong] Fallback check failed for $host: $err');
        }
      }

      if (fallbackUrl.isNotEmpty) {
        try {
          logToFile('[playSong] Setting fallback engine source to: $fallbackUrl');
          await engine.setSource(fallbackUrl);
          _isTransitioning = false;
          await engine.play();
          success = true;
          logToFile('[playSong] Fallback playback started successfully!');
        } catch (err2) {
          logToFile('[playSong] Fallback playback failed: $err2');
        }
      }
    }

    if (!success) {
      _isTransitioning = false;
      state = state.copyWith(state: RaagaPlaybackState.error);
      return;
    }

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
      print('[PlaybackNotifier] Fetching on-device Watch Next recommendations for seed: ${song.id}');
      final onlineRecs = await fetchRecommendations(song.id);
      if (onlineRecs.isNotEmpty) {
        final radioSongs = onlineRecs
            .map((r) => Song(
                  id: r['id'] ?? '',
                  title: r['title'] ?? '',
                  artist: r['artist'] ?? '',
                  album: '',
                  artworkUrl: r['artworkUrl'] ?? '',
                  sourceUrl: '/api/stream?id=${r['id']}',
                  duration: Duration(seconds: r['durationSeconds'] ?? 0),
                  isLocal: false,
                  isFavorite: false,
                ))
            .where((s) => s.id.isNotEmpty)
            .toList();

        if (radioSongs.isNotEmpty) {
          QueueManager().addAll(radioSongs);
          print('[PlaybackNotifier] Added ${radioSongs.length} Watch Next recommendations to queue.');
        }
      }
    } catch (e) {
      print('[PlaybackNotifier] Failed to fetch on-device Watch Next recommendations: $e');
    }
  }

  Future<void> refreshCurrentAutoplayQueue() async {
    final current = state.currentSong;
    if (current == null || current.isLocal) return;

    final items = QueueManager().currentQueue.items;
    final currentIndex = QueueManager().currentQueue.currentIndex;

    if (currentIndex >= 0 && currentIndex < items.length) {
      final currentPlaying = items[currentIndex];
      
      // Clear queue, keeping only the currently playing song
      QueueManager().setQueue([currentPlaying], initialIndex: 0);

      // Force state update so listeners rebuild
      state = state.copyWith(
        position: state.position, // preserve position
      );

      // Fetch and append a fresh set of recommendations
      await _fetchAndAppendAutoplayRecommendations(currentPlaying);
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
  final httpClient = ref.read(httpClientProvider);
  final db = ref.read(databaseProvider);

  // ── 0. Fetch "Picked For You" shelf from 3 diverse seed sources ──────────
  HomeFeedShelf? recommendationShelf;
  try {
    // Seed 1: Most recently played
    final recentRows = await db.customSelect(
      'SELECT song_id FROM recently_played ORDER BY played_at DESC LIMIT 1'
    ).get();

    // Seed 2: Most-played song this week (from history table)
    final mostPlayedRows = await db.customSelect(
      'SELECT song_id, COUNT(*) as cnt FROM history '
      'WHERE played_at > datetime(\'now\', \'-7 days\') '
      'GROUP BY song_id ORDER BY cnt DESC LIMIT 1'
    ).get();

    // Seed 3: A random favorite song
    final favoriteRows = await db.customSelect(
      'SELECT id FROM songs WHERE is_favorite = 1 ORDER BY RANDOM() LIMIT 1'
    ).get();

    final seedIds = <String>{};

    if (recentRows.isNotEmpty) {
      final id = recentRows.first.read<String>('song_id');
      if (id.length == 11) seedIds.add(id);
    }
    if (mostPlayedRows.isNotEmpty) {
      final id = mostPlayedRows.first.read<String>('song_id');
      if (id.length == 11) seedIds.add(id);
    }
    if (favoriteRows.isNotEmpty) {
      final id = favoriteRows.first.read<String>('id');
      if (id.length == 11) seedIds.add(id);
    }

    if (seedIds.isNotEmpty) {
      // Fetch recommendations for all seeds in parallel
      final futures = seedIds.map((id) =>
          fetchRecommendations(id).catchError((_) => <Map<String, dynamic>>[]));
      final allRecs = await Future.wait(futures);

      // Interleave & deduplicate across all seeds
      final seen = <String>{...seedIds};
      final merged = <Map<String, dynamic>>[];
      final lists = allRecs.toList();
      int maxLen = lists.fold(0, (m, r) => r.length > m ? r.length : m);
      for (int i = 0; i < maxLen; i++) {
        for (final recs in lists) {
          if (i < recs.length) {
            final id = recs[i]['id'] as String? ?? '';
            if (id.isNotEmpty && seen.add(id)) merged.add(recs[i]);
          }
        }
      }

      if (merged.isNotEmpty) {
        final recSongs = merged.take(24).map((r) => Song(
          id: r['id'] as String,
          title: r['title'] as String,
          artist: r['artist'] as String,
          album: '',
          artworkUrl: r['artworkUrl'] as String,
          sourceUrl: '/api/stream?id=${r['id']}',
          duration: Duration(seconds: r['durationSeconds'] as int),
          isLocal: false,
          isFavorite: false,
        )).toList();

        recommendationShelf = HomeFeedShelf(
          title: 'Picked For You',
          subtitle: 'From your recent plays, replays & favorites',
          shelfType: 'songs',
          items: recSongs,
        );
        print('[homeFeed] Picked For You: ${recSongs.length} songs from ${seedIds.length} seeds');
      }
    }
  } catch (e) {
    print('[homeFeed] Failed to load Picked For You: $e');
  }

  String cleanArtist(String author) {
    return author
        .replaceAll(RegExp(r'\s*-\s*Topic$', caseSensitive: false), '')
        .replaceAll(RegExp(r'\s*VEVO$', caseSensitive: false), '')
        .trim();
  }

  // Helper: convert a list of raw song maps to Song entities
  List<Song> _rawToSongs(List<Map<String, dynamic>> raw) => raw
      .map((m) => Song(
            id: m['id'] as String,
            title: m['title'] as String,
            artist: m['artist'] as String,
            album: '',
            artworkUrl: m['artworkUrl'] as String,
            sourceUrl: '/api/stream?id=${m['id']}',
            duration: Duration(seconds: m['durationSeconds'] as int),
            isLocal: false,
            isFavorite: false,
          ))
      .toList();

  // ── Parse selected languages from the joined key ─────────────────────────
  final langs = language
      .split(',')
      .map((l) => l.trim().toLowerCase())
      .where((l) => l.isNotEmpty && l != 'null' && l != 'none')
      .toList();

  final hasLanguageFilter = langs.isNotEmpty;

  // ─────────────────────────────────────────────────────────────────────────
  // PATH A: Language-specific — one shelf per language (Songs + New + Hits)
  // This path is taken whenever the user has selected any language chip.
  // ─────────────────────────────────────────────────────────────────────────
  if (hasLanguageFilter) {
    try {
      // For each selected language, run 2 queries in parallel: Top hits + New releases
      final allShelfFutures = <Future<List<HomeFeedShelf>>>[];

      for (final lang in langs) {
        final capLang = lang[0].toUpperCase() + lang.substring(1);
        allShelfFutures.add(() async {
          final queries = [
            {'title': 'Trending $capLang', 'query': '$lang top hits 2024'},
            {'title': 'New $capLang Releases', 'query': 'new $lang songs 2024'},
            {'title': '$capLang Hits', 'query': '$lang superhits best songs'},
          ];
          final results = await Future.wait(queries.map((q) => ytMusicPost(
            'search',
            {'query': q['query']!, 'params': 'EgWKAQIIAWoKEAMQBBAJEAoQBQ=='},
            client: httpClient,
          )));

          final shelves = <HomeFeedShelf>[];
          for (int i = 0; i < queries.length; i++) {
            final songs = _rawToSongs(extractSongs(results[i]));
            if (songs.isNotEmpty) {
              final displaySongs = List<Song>.from(songs)..shuffle();
              shelves.add(HomeFeedShelf(
                title: queries[i]['title']!,
                subtitle: 'Popular right now',
                shelfType: 'songs',
                items: displaySongs.take(12).toList(),
              ));
            }
          }
          return shelves;
        }());
      }

      final allLangResults = await Future.wait(allShelfFutures);
      final langShelves = allLangResults.expand((s) => s).toList();

      // Also fetch albums for selected languages
      final albumShelfFutures = langs.map((lang) async {
        final capLang = lang[0].toUpperCase() + lang.substring(1);
        final data = await ytMusicPost('search', {
          'query': '$lang albums 2024',
          // Album filter params
          'params': 'EgWKAQIYAWoKEAMQBBAJEAoQBQ==',
        }, client: httpClient);
        final songs = _rawToSongs(extractSongs(data));
        if (songs.isEmpty) return null;
        final displaySongs = List<Song>.from(songs)..shuffle();
        return HomeFeedShelf(
          title: '$capLang Albums',
          subtitle: 'Latest albums',
          shelfType: 'albums',
          items: displaySongs.take(12).toList(),
        );
      });
      final albumResults = await Future.wait(albumShelfFutures);
      final albumShelves = albumResults.whereType<HomeFeedShelf>().toList();

      if (langShelves.isNotEmpty || albumShelves.isNotEmpty) {
        final combined = <HomeFeedShelf>[];
        if (recommendationShelf != null) combined.add(recommendationShelf!);
        combined.addAll(langShelves);
        combined.addAll(albumShelves);
        return combined;
      }
    } catch (e) {
      print('[homeFeed] Language-specific search failed: $e');
    }
  }

  // ─────────────────────────────────────────────────────────────────────────
  // PATH B: No language selected — use global YTMusic home browse
  // ─────────────────────────────────────────────────────────────────────────
  // ── 1. Try YouTube Music browse (FEmusic_home) ───────────────────────────
  try {
    final uri = Uri.parse('$ytMusicBase/browse?key=$ytMusicApiKey');
    final payload = json.encode({
      "context": ytMusicContext,
      "browseId": "FEmusic_home",
    });

    final response = await httpClient.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'X-YouTube-Client-Name': '67',
        'X-YouTube-Client-Version': '1.20240918.01.00',
        'Origin': 'https://music.youtube.com',
        'Referer': 'https://music.youtube.com/',
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/127.0.0.0 Safari/537.36',
      },
      body: payload,
    ).timeout(const Duration(seconds: 12));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;

      // Walk the sections from the home browse response
      final shelves = <HomeFeedShelf>[];
      final sections = ytNav(data, [
        'contents', 'singleColumnBrowseResultsRenderer', 'tabs', 0,
        'tabRenderer', 'content', 'sectionListRenderer', 'contents'
      ]) as List? ?? [];

      for (final section in sections) {
        final shelf = section['musicCarouselShelfRenderer'] ??
            section['musicShelfRenderer'] ??
            section['musicImmersiveCarouselShelfRenderer'];
        if (shelf == null) continue;

        // Shelf title
        final titleRuns = ytNav(shelf, ['header',
          'musicCarouselShelfBasicHeaderRenderer', 'title', 'runs']) as List? ??
            ytNav(shelf, ['header',
              'musicImmersiveCarouselShelfBasicHeaderRenderer', 'title', 'runs']) as List? ?? [];
        final shelfTitle = titleRuns.isNotEmpty
            ? (titleRuns[0]['text'] as String? ?? 'Picks for You')
            : 'Picks for You';

        // Parse items from contents
        final contents = (shelf['contents'] as List? ?? []);
        final songs = <Song>[];
        for (final item in contents) {
          final m = parseMusicItem(item);
          if (m != null) {
            songs.add(Song(
              id: m['id'] as String,
              title: m['title'] as String,
              artist: m['artist'] as String,
              album: '',
              artworkUrl: m['artworkUrl'] as String,
              sourceUrl: '/api/stream?id=${m['id']}',
              duration: Duration(seconds: m['durationSeconds'] as int),
              isLocal: false,
              isFavorite: false,
            ));
          }
        }

        if (songs.isNotEmpty) {
          // Skip podcast/episode shelves — they never resolve to playable songs
          final lowerTitle = shelfTitle.toLowerCase();
          final isEpisodeShelf = lowerTitle.contains('episode') ||
              lowerTitle.contains('podcast') ||
              lowerTitle.contains('talk show') ||
              lowerTitle.contains('comedy') ||
              lowerTitle.contains('upload') ||
              lowerTitle.contains('show');
          if (isEpisodeShelf) continue;

          shelves.add(HomeFeedShelf(
            title: shelfTitle,
            subtitle: 'Trending',
            shelfType: 'songs',
            items: songs.take(15).toList(),
          ));
        }
      }

      if (shelves.isNotEmpty) {
        if (recommendationShelf != null) {
          shelves.insert(0, recommendationShelf!);
        }
        // Add global album shelf at the bottom
        try {
          final albumData = await ytMusicPost('search', {
            'query': 'top albums 2024',
            'params': 'EgWKAQIYAWoKEAMQBBAJEAoQBQ==',
          }, client: httpClient);
          final albumSongs = _rawToSongs(extractSongs(albumData));
          if (albumSongs.isNotEmpty) {
            shelves.add(HomeFeedShelf(
              title: 'Popular Albums',
              subtitle: 'Latest releases',
              shelfType: 'albums',
              items: albumSongs.take(12).toList(),
            ));
          }
        } catch (_) {}
        return shelves;
      }
    }
  } catch (e) {
    print('[homeFeed] YTMusic browse failed: $e');
  }

  // ── 2. Fallback: YTMusic generic search-based shelves ────────────────────
  try {
    final queries = <Map<String, String>>[
      {
        'title': 'Trending Hits',
        'subtitle': 'Popular right now',
        'query': 'top hits 2024',
      },
      {
        'title': 'New Releases',
        'subtitle': 'Fresh new releases',
        'query': 'new songs 2024',
      },
      {
        'title': 'Chill Vibes',
        'subtitle': 'Easy listening',
        'query': 'chill music playlist',
      },
    ];

    // Fire all 3 searches simultaneously instead of sequentially
    final results = await Future.wait(
      queries.map((q) => ytMusicPost(
        'search',
        {'query': q['query']!, 'params': 'EgWKAQIIAWoKEAMQBBAJEAoQBQ=='},
        client: httpClient,
      )),
    );

    final shelves = <HomeFeedShelf>[];
    for (int i = 0; i < queries.length; i++) {
      final songs = _rawToSongs(extractSongs(results[i]));
      if (songs.isNotEmpty) {
        final displaySongs = List<Song>.from(songs)..shuffle();
        shelves.add(HomeFeedShelf(
          title: queries[i]['title']!,
          subtitle: queries[i]['subtitle']!,
          shelfType: 'songs',
          items: displaySongs.take(12).toList(),
        ));
      }
    }
    if (shelves.isNotEmpty) {
      if (recommendationShelf != null) {
        shelves.insert(0, recommendationShelf!);
      }
      return shelves;
    }
  } catch (e) {
    print('[homeFeed] YTMusic search fallback failed: $e');
  }

  // ── 3. Last resort: trending songs provider ───────────────────────────────
  final trending = await ref.watch(trendingSongsProvider.future);
  final list = <HomeFeedShelf>[];
  if (recommendationShelf != null) {
    list.add(recommendationShelf);
  }
  list.add(HomeFeedShelf(
    title: 'Trending Hits',
    subtitle: 'Top recommendations',
    items: trending,
  ));
  return list;
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
