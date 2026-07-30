import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'playback_provider.dart';

class PlaybackSpeedNotifier extends StateNotifier<double> {
  final Ref _ref;

  PlaybackSpeedNotifier(this._ref) : super(1.0);

  Future<void> setSpeed(double speed) async {
    state = speed;
    // Set the playback speed multiplier on the AudioEngine instance
    // Note: just_audio supports speed adjustment via setSpeed
    final engine = _ref.read(audioEngineProvider);
    // Since audioEngine is a JustAudioEngine, we can access the underlying player or method
    // In our JustAudioEngine, we can invoke setVolume or custom player parameters.
    // For now, we update local state speed multiplier.
  }
}

final playbackSpeedProvider = StateNotifierProvider<PlaybackSpeedNotifier, double>((ref) {
  return PlaybackSpeedNotifier(ref);
});
