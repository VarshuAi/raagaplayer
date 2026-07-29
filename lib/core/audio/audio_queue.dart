import '../../../domain/entities/song.dart';

class AudioQueue {
  final List<Song> items;
  int currentIndex;

  AudioQueue({
    required this.items,
    this.currentIndex = 0,
  });

  Song? get currentSong {
    if (items.isEmpty || currentIndex < 0 || currentIndex >= items.length) {
      return null;
    }
    return items[currentIndex];
  }

  bool get hasNext => currentIndex < items.length - 1;
  bool get hasPrevious => currentIndex > 0;

  void next() {
    if (hasNext) currentIndex++;
  }

  void previous() {
    if (hasPrevious) currentIndex--;
  }

  void shuffle() {
    if (items.isEmpty) return;
    final current = currentSong;
    items.shuffle();
    if (current != null) {
      currentIndex = items.indexOf(current);
    }
  }

  void add(Song song) {
    items.add(song);
  }

  void removeAt(int index) {
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
      if (currentIndex >= items.length) {
        currentIndex = items.length - 1;
      }
    }
  }

  void clear() {
    items.clear();
    currentIndex = 0;
  }
}
