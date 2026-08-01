import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../repositories/music_repository.dart';

class ToggleFavoriteUseCase {
  final MusicRepository repository;

  ToggleFavoriteUseCase(this.repository);

  Future<Result<void, Failure>> execute(String songId) {
    return repository.toggleFavorite(songId);
  }
}
