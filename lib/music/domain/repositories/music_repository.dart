import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/song.dart';

abstract class MusicRepository {
  Future<Result<List<Song>, Failure>> getTrendingSongs();
  Future<Result<Song, Failure>> getSongDetails(String id);
  Future<Result<List<Song>, Failure>> getFavoriteSongs();
  Future<Result<void, Failure>> toggleFavorite(String songId);
}
