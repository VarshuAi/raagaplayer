import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class RaagaAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer _player;

  RaagaAudioHandler(this._player) {
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> skipToNext() async {
    if (_onSkipNext != null) {
      await _onSkipNext!();
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (_onSkipPrevious != null) {
      await _onSkipPrevious!();
    }
  }

  Future<void> Function()? _onSkipNext;
  Future<void> Function()? _onSkipPrevious;

  void setMediaControlCallbacks({
    Future<void> Function()? onSkipNext,
    Future<void> Function()? onSkipPrevious,
  }) {
    _onSkipNext = onSkipNext;
    _onSkipPrevious = onSkipPrevious;
  }

  Future<void> updateMetadata({
    required String id,
    required String title,
    required String artist,
    required String album,
    required Duration duration,
    String? artworkUri,
  }) async {
    Uri? finalArtUri;

    if (artworkUri != null && artworkUri.isNotEmpty) {
      if (artworkUri.startsWith('http://') || artworkUri.startsWith('https://')) {
        try {
          final client = http.Client();
          final res = await client.get(Uri.parse(artworkUri)).timeout(const Duration(seconds: 4));
          if (res.statusCode == 200) {
            final tempDir = await getTemporaryDirectory();
            final safeId = id.replaceAll(RegExp(r'[^\w\.-]'), '_');
            final file = File('${tempDir.path}/notification_art_$safeId.jpg');
            await file.writeAsBytes(res.bodyBytes);
            finalArtUri = Uri.file(file.path);
          } else {
            finalArtUri = Uri.parse(artworkUri);
          }
          client.close();
        } catch (_) {
          finalArtUri = Uri.parse(artworkUri);
        }
      } else if (artworkUri.startsWith('file://')) {
        finalArtUri = Uri.parse(artworkUri);
      } else {
        finalArtUri = Uri.file(artworkUri);
      }
    }

    mediaItem.add(
      MediaItem(
        id: id,
        title: title,
        artist: artist,
        album: album,
        duration: duration,
        artUri: finalArtUri,
      ),
    );
  }
}
