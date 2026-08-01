import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/song.dart';
import '../repositories/music_repository.dart';

class GetHomeFeedUseCase {
  final MusicRepository repository;

  GetHomeFeedUseCase(this.repository);

  Future<Result<List<Song>, Failure>> execute() {
    return repository.getTrendingSongs();
  }
}
