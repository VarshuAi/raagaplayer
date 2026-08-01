import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../music/domain/entities/lyrics.dart';

class LyricsProvider extends ChangeNotifier {
  List<LyricLine> _lyrics = [];
  int _currentLineIndex = -1;

  List<LyricLine> get lyrics => _lyrics;
  int get currentLineIndex => _currentLineIndex;

  void loadLyrics(List<LyricLine> newLyrics) {
    _lyrics = newLyrics;
    _currentLineIndex = -1;
    notifyListeners();
  }

  void updatePosition(Duration position) {
    if (_lyrics.isEmpty) return;
    int index = -1;
    for (int i = 0; i < _lyrics.length; i++) {
      if (position >= _lyrics[i].timeStamp) {
        index = i;
      } else {
        break;
      }
    }
    if (index != _currentLineIndex) {
      _currentLineIndex = index;
      notifyListeners();
    }
  }

  void clear() {
    _lyrics.clear();
    _currentLineIndex = -1;
    notifyListeners();
  }
}

final lyricsProvider = ChangeNotifierProvider<LyricsProvider>((ref) {
  return LyricsProvider();
});
