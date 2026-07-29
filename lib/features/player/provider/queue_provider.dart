import 'package:flutter/material.dart';
import '../../../core/audio/audio_queue.dart';
import '../../../domain/entities/song.dart';

class QueueProvider extends ChangeNotifier {
  final AudioQueue _queue = AudioQueue(items: []);

  List<Song> get items => _queue.items;
  int get currentIndex => _queue.currentIndex;
  Song? get currentSong => _queue.currentSong;

  void addToQueue(Song song) {
    _queue.add(song);
    notifyListeners();
  }

  void next() {
    _queue.next();
    notifyListeners();
  }

  void previous() {
    _queue.previous();
    notifyListeners();
  }

  void shuffle() {
    _queue.shuffle();
    notifyListeners();
  }

  void remove(int index) {
    _queue.removeAt(index);
    notifyListeners();
  }

  void clear() {
    _queue.clear();
    notifyListeners();
  }
}
