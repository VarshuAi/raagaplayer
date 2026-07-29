import 'package:flutter/material.dart';
import '../../../core/audio/audio_engine.dart';
import '../../../core/audio/audio_state.dart';
import '../../../domain/entities/song.dart';

class PlayerProvider extends ChangeNotifier {
  final AudioEngine audioEngine;
  Song? _currentSong;
  RaagaPlaybackState _state = RaagaPlaybackState.idle;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;

  PlayerProvider({required this.audioEngine}) {
    // Listen to audio engine streams
    audioEngine.playbackStateStream.listen((state) {
      _state = state;
      notifyListeners();
    });
    audioEngine.positionStream.listen((pos) {
      _position = pos;
      notifyListeners();
    });
    audioEngine.durationStream.listen((dur) {
      _duration = dur;
      notifyListeners();
    });
  }

  Song? get currentSong => _currentSong;
  RaagaPlaybackState get state => _state;
  Duration get position => _position;
  Duration get duration => _duration;
  bool get isPlaying => _state == RaagaPlaybackState.playing;

  Future<void> playSong(Song song) async {
    _currentSong = song;
    notifyListeners();
    await audioEngine.setSource(song.sourceUrl);
    await audioEngine.play();
  }

  Future<void> pause() async {
    await audioEngine.pause();
  }

  Future<void> resume() async {
    await audioEngine.play();
  }

  Future<void> seek(Duration pos) async {
    await audioEngine.seek(pos);
  }

  Future<void> stop() async {
    await audioEngine.stop();
  }
}
