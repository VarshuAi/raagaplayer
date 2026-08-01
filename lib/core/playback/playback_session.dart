import '../../../music/domain/entities/song.dart';
import '../audio/audio_state.dart';

enum AudioRepeatMode {
  off,
  all,
  one,
}

class PlaybackSession {
  final Song? currentSong;
  final List<Song> queue;
  final int currentIndex;
  final RaagaPlaybackState state;
  final Duration position;
  final Duration duration;
  final bool shuffle;
  final AudioRepeatMode repeatMode;
  final double speed;
  final double volume;
  final Duration? sleepTimerRemaining;
  
  // Audio Effects Parameter Scaffolds
  final bool eqEnabled;
  final double bassBoost;
  final double virtualizer;
  final double reverb;
  final double loudness;
  final double replayGain;

  const PlaybackSession({
    this.currentSong,
    this.queue = const [],
    this.currentIndex = -1,
    this.state = RaagaPlaybackState.idle,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.shuffle = false,
    this.repeatMode = AudioRepeatMode.off,
    this.speed = 1.0,
    this.volume = 1.0,
    this.sleepTimerRemaining,
    this.eqEnabled = false,
    this.bassBoost = 0.0,
    this.virtualizer = 0.0,
    this.reverb = 0.0,
    this.loudness = 0.0,
    this.replayGain = 0.0,
  });

  PlaybackSession copyWith({
    Song? currentSong,
    bool clearCurrentSong = false,
    List<Song>? queue,
    int? currentIndex,
    RaagaPlaybackState? state,
    Duration? position,
    Duration? duration,
    bool? shuffle,
    AudioRepeatMode? repeatMode,
    double? speed,
    double? volume,
    Duration? sleepTimerRemaining,
    bool clearSleepTimer = false,
    bool? eqEnabled,
    double? bassBoost,
    double? virtualizer,
    double? reverb,
    double? loudness,
    double? replayGain,
  }) {
    return PlaybackSession(
      currentSong: clearCurrentSong ? null : (currentSong ?? this.currentSong),
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      state: state ?? this.state,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      shuffle: shuffle ?? this.shuffle,
      repeatMode: repeatMode ?? this.repeatMode,
      speed: speed ?? this.speed,
      volume: volume ?? this.volume,
      sleepTimerRemaining: clearSleepTimer ? null : (sleepTimerRemaining ?? this.sleepTimerRemaining),
      eqEnabled: eqEnabled ?? this.eqEnabled,
      bassBoost: bassBoost ?? this.bassBoost,
      virtualizer: virtualizer ?? this.virtualizer,
      reverb: reverb ?? this.reverb,
      loudness: loudness ?? this.loudness,
      replayGain: replayGain ?? this.replayGain,
    );
  }
}
