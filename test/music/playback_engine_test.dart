import 'package:flutter_test/flutter_test.dart';
import 'package:raaga_music_player/core/playback/playback_engine.dart';
import 'package:raaga_music_player/core/playback/playback_session.dart';
import 'package:raaga_music_player/core/audio/audio_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('PlaybackEngine Tests', () {
    late PlaybackEngine engine;

    setUp(() {
      engine = PlaybackEngine();
    });

    tearDown(() async {
      await engine.dispose();
    });

    test('should start in idle state', () {
      expect(engine.currentPlaybackState, RaagaPlaybackState.idle);
      expect(engine.currentPosition, Duration.zero);
      expect(engine.currentDuration, Duration.zero);
    });
  });

  group('PlaybackSession Tests', () {
    test('copyWith creates correct clone with updated fields', () {
      const session = PlaybackSession(
        volume: 0.8,
        shuffle: true,
      );
      final updated = session.copyWith(
        volume: 0.9,
        shuffle: false,
      );
      expect(updated.volume, 0.9);
      expect(updated.shuffle, false);
    });
  });
}
