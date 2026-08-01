import '../domain/entities/playlist.dart';
import '../domain/usecases/create_playlist_use_case.dart';
import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';

class PlaylistCoordinator {
  final CreatePlaylistUseCase createPlaylistUseCase;

  PlaylistCoordinator(this.createPlaylistUseCase);

  Future<Result<Playlist, Failure>> create(String name, String description) {
    return createPlaylistUseCase.execute(name, description);
  }
}
