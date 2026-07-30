import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/audio/audio_state.dart';
import '../../../core/audio/just_audio_engine.dart';

// Provide the active JustAudioEngine
final audioEngineProvider = Provider<JustAudioEngine>((ref) {
  final engine = JustAudioEngine();
  ref.onDispose(() => engine.dispose());
  return engine;
});

// Provide playback position changes dynamically
final playbackPositionProvider = StreamProvider<Duration>((ref) {
  return ref.watch(audioEngineProvider).positionStream;
});

// Provide playback duration changes dynamically
final playbackDurationProvider = StreamProvider<Duration>((ref) {
  return ref.watch(audioEngineProvider).durationStream;
});

// Provide playback state changes dynamically
final playbackStateProvider = StreamProvider<RaagaPlaybackState>((ref) {
  return ref.watch(audioEngineProvider).playbackStateStream;
});
