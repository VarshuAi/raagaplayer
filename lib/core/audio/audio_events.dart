import 'audio_state.dart';
import '../../../domain/entities/song.dart';

abstract class AudioEvent {}

class TrackChangedEvent extends AudioEvent {
  final Song? newSong;
  TrackChangedEvent(this.newSong);
}

class PlaybackStateChangedEvent extends AudioEvent {
  final RaagaPlaybackState state;
  PlaybackStateChangedEvent(this.state);
}

class VolumeChangedEvent extends AudioEvent {
  final double volume;
  VolumeChangedEvent(this.volume);
}
