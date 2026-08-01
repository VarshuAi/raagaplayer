import 'dart:async';
import '../../../music/domain/entities/song.dart';

abstract class QueueEvent {}

class QueueClearedEvent extends QueueEvent {}

class QueueReorderedEvent extends QueueEvent {
  final List<Song> queue;
  QueueReorderedEvent(this.queue);
}

class QueueEvents {
  static final _controller = StreamController<QueueEvent>.broadcast();
  static Stream<QueueEvent> get stream => _controller.stream;
  static void emit(QueueEvent event) => _controller.add(event);
}
