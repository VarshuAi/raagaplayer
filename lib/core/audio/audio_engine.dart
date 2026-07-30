import 'dart:async';
import 'audio_state.dart';
import '../error/result.dart';
import '../error/failures.dart';

abstract class AudioEngine {
  // Streams for state changes
  Stream<RaagaPlaybackState> get playbackStateStream;
  Stream<Duration> get positionStream;
  Stream<Duration> get durationStream;

  RaagaPlaybackState get currentPlaybackState;
  Duration get currentPosition;
  Duration get currentDuration;

  // Control APIs
  Future<Result<void, AudioPlaybackFailure>> setSource(String sourceUrl);
  Future<Result<void, AudioPlaybackFailure>> play();
  Future<Result<void, AudioPlaybackFailure>> pause();
  Future<Result<void, AudioPlaybackFailure>> seek(Duration position);
  Future<Result<void, AudioPlaybackFailure>> stop();
  Future<Result<void, AudioPlaybackFailure>> setVolume(double volume);
  Future<void> dispose();
}
