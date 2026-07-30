import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/song.dart';
import '../../../core/audio/queue_manager.dart';

class QueueNotifier extends StateNotifier<List<Song>> {
  QueueNotifier() : super(QueueManager().currentQueue.items) {
    QueueManager().onQueueChanged.listen((queue) {
      state = List.from(queue.items);
    });
  }

  void add(Song song) => QueueManager().add(song);
  void clear() => QueueManager().clear();
  void remove(int index) => QueueManager().remove(index);
  void shuffle() => QueueManager().shuffle();
}

final queueProvider = StateNotifierProvider<QueueNotifier, List<Song>>((ref) {
  return QueueNotifier();
});

final currentQueueIndexProvider = StateProvider<int>((ref) {
  return QueueManager().currentQueue.currentIndex;
});
