import '../entities/playlist.dart';
import '../repositories/music_repository.dart';
import '../../core/error/result.dart';
import '../../core/error/failures.dart';

class GetHomeShelvesUseCase {
  final MusicRepository repository;

  GetHomeShelvesUseCase(this.repository);

  Future<Result<List<Playlist>, ServerFailure>> execute() async {
    return repository.getFeaturedPlaylists();
  }
}
