import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/song.dart';
import '../repositories/music_repository.dart';

class GenerateRecommendationsUseCase {
  final MusicRepository repository;

  GenerateRecommendationsUseCase(this.repository);

  Future<Result<List<Song>, Failure>> execute() {
    return repository.getTrendingSongs();
  }
}
