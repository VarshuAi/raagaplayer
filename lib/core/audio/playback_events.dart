import '../../../domain/entities/song.dart';

abstract class PlaybackEvent {
  const PlaybackEvent();
}

class SongStarted extends PlaybackEvent {
  final Song song;
  const SongStarted(this.song);
}

class SongFinished extends PlaybackEvent {
  final Song song;
  const SongFinished(this.song);
}

class SongSkipped extends PlaybackEvent {
  final Song song;
  const SongSkipped(this.song);
}

class QueueEnded extends PlaybackEvent {
  const QueueEnded();
}

class ShuffleChanged extends PlaybackEvent {
  final bool isShuffleEnabled;
  const ShuffleChanged(this.isShuffleEnabled);
}

class RepeatChanged extends PlaybackEvent {
  final int repeatMode; // 0: off, 1: all, 2: one
  const RepeatChanged(this.repeatMode);
}

class PlaybackError extends PlaybackEvent {
  final String error;
  const PlaybackError(this.error);
}
