import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'playback_provider.dart';

class PlaybackSpeedNotifier extends StateNotifier<double> {
  final Ref _ref;

  PlaybackSpeedNotifier(this._ref) : super(1.0);

  Future<void> setSpeed(double speed) async {
    state = speed;
    final engine = _ref.read(audioEngineProvider);
    await engine.setSpeed(speed);
  }
}

final playbackSpeedProvider = StateNotifierProvider<PlaybackSpeedNotifier, double>((ref) {
  return PlaybackSpeedNotifier(ref);
});
