import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'audio_engine.dart';
import 'audio_state.dart';
import 'raaga_audio_handler.dart';
import '../error/result.dart';
import '../error/failures.dart';

import '../playback/playback_engine.dart';

class JustAudioEngine implements AudioEngine {
  AudioPlayer get _player => PlaybackEngine.sharedPlayer;
  late final RaagaAudioHandler _audioHandler;

  final _playbackStateController = StreamController<RaagaPlaybackState>.broadcast();
  final _positionController = StreamController<Duration>.broadcast();
  final _durationController = StreamController<Duration>.broadcast();

  JustAudioEngine() {
    _audioHandler = RaagaAudioHandler(_player);

    // Pipe position and duration events
    _player.positionStream.listen((pos) => _positionController.add(pos));
    _player.durationStream.listen((dur) => _durationController.add(dur ?? Duration.zero));
    _player.playerStateStream.listen((state) {
      _playbackStateController.add(_mapPlaybackState(state));
    });
  }

  RaagaAudioHandler get audioHandler => _audioHandler;

  @override
  Stream<RaagaPlaybackState> get playbackStateStream => _playbackStateController.stream;

  @override
  Stream<Duration> get positionStream => _positionController.stream;

  @override
  Stream<Duration> get durationStream => _durationController.stream;

  @override
  RaagaPlaybackState get currentPlaybackState => _mapPlaybackState(_player.playerState);

  @override
  Duration get currentPosition => _player.position;

  @override
  Duration get currentDuration => _player.duration ?? Duration.zero;

  @override
  Future<Result<void, AudioPlaybackFailure>> setSource(String sourceUrl) async {
    try {
      if (sourceUrl.isEmpty) {
        await _player.setAudioSource(ConcatenatingAudioSource(children: []));
      } else if (sourceUrl.startsWith('http')) {
        await _player.setUrl(
          sourceUrl,
          headers: const {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36',
            'Referer': 'https://www.youtube.com/',
            'Origin': 'https://www.youtube.com',
          },
        );
      } else if (sourceUrl.startsWith('file://')) {
        // Local downloaded file — use URI-based source
        await _player.setAudioSource(
          AudioSource.uri(Uri.parse(sourceUrl)),
        );
      } else {
        // Raw file system path
        await _player.setFilePath(sourceUrl);
      }
      return const Result.success(null);
    } catch (e) {
      return Result.failure(AudioPlaybackFailure("Failed to load source: $e"));
    }
  }

  @override
  Future<Result<void, AudioPlaybackFailure>> play() async {
    try {
      await _player.play();
      return const Result.success(null);
    } catch (e) {
      return Result.failure(AudioPlaybackFailure("Failed to play: $e"));
    }
  }

  @override
  Future<Result<void, AudioPlaybackFailure>> pause() async {
    try {
      await _player.pause();
      return const Result.success(null);
    } catch (e) {
      return Result.failure(AudioPlaybackFailure("Failed to pause: $e"));
    }
  }

  @override
  Future<Result<void, AudioPlaybackFailure>> seek(Duration position) async {
    try {
      await _player.seek(position);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(AudioPlaybackFailure("Failed to seek: $e"));
    }
  }

  @override
  Future<Result<void, AudioPlaybackFailure>> stop() async {
    try {
      await _player.stop();
      return const Result.success(null);
    } catch (e) {
      return Result.failure(AudioPlaybackFailure("Failed to stop: $e"));
    }
  }

  @override
  Future<Result<void, AudioPlaybackFailure>> setVolume(double volume) async {
    try {
      await _player.setVolume(volume);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(AudioPlaybackFailure("Failed to change volume: $e"));
    }
  }

  @override
  Future<Result<void, AudioPlaybackFailure>> setSpeed(double speed) async {
    try {
      await _player.setSpeed(speed);
      return const Result.success(null);
    } catch (e) {
      return Result.failure(AudioPlaybackFailure("Failed to change playback speed: $e"));
    }
  }

  @override
  Future<void> dispose() async {
    await _player.dispose();
    await _playbackStateController.close();
    await _positionController.close();
    await _durationController.close();
  }

  RaagaPlaybackState _mapPlaybackState(PlayerState state) {
    if (state.processingState == ProcessingState.idle) return RaagaPlaybackState.idle;
    if (state.processingState == ProcessingState.loading) return RaagaPlaybackState.loading;
    if (state.processingState == ProcessingState.buffering) return RaagaPlaybackState.loading;
    if (state.processingState == ProcessingState.completed) return RaagaPlaybackState.completed;
    return state.playing ? RaagaPlaybackState.playing : RaagaPlaybackState.paused;
  }
}
