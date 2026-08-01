import 'dart:async';
import '../../../music/domain/entities/playlist.dart';

abstract class PlaylistEvent {}

class PlaylistCreatedEvent extends PlaylistEvent {
  final Playlist playlist;
  PlaylistCreatedEvent(this.playlist);
}

class PlaylistDeletedEvent extends PlaylistEvent {
  final String id;
  PlaylistDeletedEvent(this.id);
}

class PlaylistEvents {
  static final _controller = StreamController<PlaylistEvent>.broadcast();
  static Stream<PlaylistEvent> get stream => _controller.stream;
  static void emit(PlaylistEvent event) => _controller.add(event);
}
