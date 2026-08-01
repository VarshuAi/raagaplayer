import '../../domain/entities/song.dart';

class QueueCoordinator {
  final List<Song> _items = [];
  int _currentIndex = -1;

  List<Song> get items => List.unmodifiable(_items);
  int get currentIndex => _currentIndex;

  void add(Song song) {
    _items.add(song);
  }

  void addAll(List<Song> songs) {
    _items.addAll(songs);
  }

  void clear() {
    _items.clear();
    _currentIndex = -1;
  }

  void remove(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      if (_currentIndex >= _items.length) {
        _currentIndex = _items.length - 1;
      }
    }
  }

  void shuffle() {
    _items.shuffle();
  }
}
