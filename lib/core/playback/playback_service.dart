import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'playback_engine.dart';

class PlaybackService {
  final PlaybackEngine _playbackEngine;
  bool _initialized = false;

  PlaybackService(this._playbackEngine);

  Future<void> initialize() async {
    if (_initialized) return;

    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());

    _initialized = true;
  }
}
