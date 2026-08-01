import 'dart:async';
import '../audio/audio_state.dart';

abstract class PlaybackEvent {}

class PlaybackStateChangedEvent extends PlaybackEvent {
  final RaagaPlaybackState state;
  PlaybackStateChangedEvent(this.state);
}

class PlaybackEvents {
  static final _controller = StreamController<PlaybackEvent>.broadcast();
  static Stream<PlaybackEvent> get stream => _controller.stream;
  static void emit(PlaybackEvent event) => _controller.add(event);
}
