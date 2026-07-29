import '../entities/song.dart';
import '../repositories/music_repository.dart';
import '../../core/error/result.dart';
import '../../core/error/failures.dart';

class PlaySongUseCase {
  final MusicRepository repository;

  PlaySongUseCase(this.repository);

  Future<Result<Song, ServerFailure>> execute(String songId) async {
    return repository.getSongDetails(songId);
  }
}
