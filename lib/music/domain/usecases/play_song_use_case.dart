import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/song.dart';
import '../repositories/music_repository.dart';

class PlaySongUseCase {
  final MusicRepository repository;

  PlaySongUseCase(this.repository);

  Future<Result<Song, Failure>> execute(String songId) {
    return repository.getSongDetails(songId);
  }
}
