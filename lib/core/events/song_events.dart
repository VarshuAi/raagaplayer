import 'dart:async';
import '../../../music/domain/entities/song.dart';

abstract class SongEvent {}

class FavoriteToggledEvent extends SongEvent {
  final Song song;
  final bool isFavorite;
  FavoriteToggledEvent(this.song, this.isFavorite);
}

class SongEvents {
  static final _controller = StreamController<SongEvent>.broadcast();
  static Stream<SongEvent> get stream => _controller.stream;
  static void emit(SongEvent event) => _controller.add(event);
}
