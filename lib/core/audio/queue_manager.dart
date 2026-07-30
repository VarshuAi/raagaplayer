import 'dart:async';
import '../../../domain/entities/song.dart';
import 'audio_queue.dart';

class QueueManager {
  static final QueueManager _instance = QueueManager._internal();
  factory QueueManager() => _instance;
  QueueManager._internal();

  final AudioQueue _queue = AudioQueue(items: []);
  final _queueChangedController = StreamController<AudioQueue>.broadcast();

  Stream<AudioQueue> get onQueueChanged => _queueChangedController.stream;
  AudioQueue get currentQueue => _queue;

  void add(Song song) {
    _queue.add(song);
    _notify();
  }

  void addAll(List<Song> songs) {
    _queue.items.addAll(songs);
    _notify();
  }

  void insertNext(Song song) {
    if (_queue.items.isEmpty) {
      _queue.add(song);
    } else {
      _queue.items.insert(_queue.currentIndex + 1, song);
    }
    _notify();
  }

  void remove(int index) {
    _queue.removeAt(index);
    _notify();
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final item = _queue.items.removeAt(oldIndex);
    _queue.items.insert(newIndex, item);
    
    // Maintain current index alignment
    if (_queue.currentIndex == oldIndex) {
      _queue.currentIndex = newIndex;
    } else if (oldIndex < _queue.currentIndex && newIndex >= _queue.currentIndex) {
      _queue.currentIndex--;
    } else if (oldIndex > _queue.currentIndex && newIndex <= _queue.currentIndex) {
      _queue.currentIndex++;
    }
    _notify();
  }

  void shuffle() {
    _queue.shuffle();
    _notify();
  }

  void clear() {
    _queue.clear();
    _notify();
  }

  void _notify() {
    _queueChangedController.add(_queue);
  }

  void dispose() {
    _queueChangedController.close();
  }
}
