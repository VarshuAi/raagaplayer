import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/playlist.dart';
import '../repositories/playlist_repository.dart';

class CreatePlaylistUseCase {
  final PlaylistRepository repository;

  CreatePlaylistUseCase(this.repository);

  Future<Result<Playlist, Failure>> execute(String name, String description) {
    return repository.createPlaylist(name, description);
  }
}
