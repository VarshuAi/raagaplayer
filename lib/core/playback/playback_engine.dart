import 'dart:async';
import 'package:just_audio/just_audio.dart';
import '../audio/audio_state.dart';
import '../audio/raaga_audio_handler.dart';

class PlaybackEngine {
  static final AndroidEqualizer androidEqualizer = AndroidEqualizer();
  static final AudioPlayer sharedPlayer = AudioPlayer(
    audioPipeline: AudioPipeline(
      androidAudioEffects: [androidEqualizer],
    ),
  );
  AudioPlayer get _player => sharedPlayer;
  late final RaagaAudioHandler _audioHandler;

  final _playbackStateController = StreamController<RaagaPlaybackState>.broadcast();
  final _positionController = StreamController<Duration>.broadcast();
  final _durationController = StreamController<Duration>.broadcast();
  final _errorController = StreamController<String>.broadcast();

  PlaybackEngine() {
    _audioHandler = RaagaAudioHandler(_player);

    _player.positionStream.listen((pos) => _positionController.add(pos));
    _player.durationStream.listen((dur) => _durationController.add(dur ?? Duration.zero));
    _player.playerStateStream.listen((state) {
      _playbackStateController.add(_mapPlaybackState(state));
    });

    // ← CRITICAL: listen for just_audio playback errors (403, network, codec, etc.)
    _player.playbackEventStream.listen(
      (_) {},
      onError: (Object e, StackTrace st) {
        final msg = e.toString();
        print('[PlaybackEngine] playbackEvent error: $msg');
        _errorController.add(msg);
        _playbackStateController.add(RaagaPlaybackState.error);
      },
    );
  }

  RaagaAudioHandler get audioHandler => _audioHandler;

  Stream<RaagaPlaybackState> get playbackStateStream => _playbackStateController.stream;
  Stream<Duration> get positionStream => _positionController.stream;
  Stream<Duration> get durationStream => _durationController.stream;
  Stream<String> get errorStream => _errorController.stream;

  RaagaPlaybackState get currentPlaybackState => _mapPlaybackState(_player.playerState);
  Duration get currentPosition => _player.position;
  Duration get currentDuration => _player.duration ?? Duration.zero;

  Future<void> setSource(String sourceUrl) async {
    if (sourceUrl.startsWith('http://') || sourceUrl.startsWith('https://')) {
      await _player.setUrl(
        sourceUrl,
        headers: const {
          'User-Agent': 'com.google.android.youtube/19.12.35 (Linux; U; Android 11; GMT) ExoPlayerLib/2.19.1',
        },
      );
    } else if (sourceUrl.isNotEmpty) {
      await _player.setFilePath(sourceUrl);
    } else {
      throw Exception('Empty stream URL provided');
    }
  }

  Future<void> play() => _player.play();
  Future<void> pause() => _player.pause();
  Future<void> stop() => _player.stop();
  Future<void> seek(Duration position) => _player.seek(position);
  Future<void> setSpeed(double speed) => _player.setSpeed(speed);
  Future<void> setVolume(double volume) => _player.setVolume(volume);

  Future<void> dispose() async {
    await _player.dispose();
    await _playbackStateController.close();
    await _positionController.close();
    await _durationController.close();
    await _errorController.close();
  }

  RaagaPlaybackState _mapPlaybackState(PlayerState state) {
    if (state.processingState == ProcessingState.idle) return RaagaPlaybackState.idle;
    if (state.processingState == ProcessingState.loading) return RaagaPlaybackState.loading;
    if (state.processingState == ProcessingState.buffering) return RaagaPlaybackState.loading;
    if (state.processingState == ProcessingState.completed) return RaagaPlaybackState.completed;
    // NOTE: ProcessingState.error is not in the enum; just_audio surfaces errors
    // via playbackEventStream.onError instead. The listener above handles it.
    return state.playing ? RaagaPlaybackState.playing : RaagaPlaybackState.paused;
  }
}
