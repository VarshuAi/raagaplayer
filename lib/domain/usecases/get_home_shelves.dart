import '../entities/playlist.dart';
import '../../music/domain/repositories/playlist_repository.dart';
import '../../core/error/result.dart';
import '../../core/error/failures.dart';

class GetHomeShelvesUseCase {
  final PlaylistRepository repository;

  GetHomeShelvesUseCase(this.repository);

  Future<Result<List<Playlist>, Failure>> execute() async {
    return repository.getPlaylists();
  }
}
