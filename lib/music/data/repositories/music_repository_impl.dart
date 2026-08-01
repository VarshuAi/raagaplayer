import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../../../../plugins/provider_registry.dart';
import '../../domain/entities/song.dart';
import '../../domain/repositories/music_repository.dart';
import '../adapters/music_provider_adapter.dart';

class MusicRepositoryImpl implements MusicRepository {
  MusicProviderAdapter get _adapter => ProviderRegistry().activePlugin.adapter;

  @override
  Future<Result<List<Song>, Failure>> getTrendingSongs() async {
    try {
      final songs = await _adapter.getTrendingSongs();
      return Result.success(songs);
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<Song, Failure>> getSongDetails(String id) async {
    try {
      final song = await _adapter.getSongDetails(id);
      return Result.success(song);
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<Song>, Failure>> getFavoriteSongs() async {
    return const Result.success([]);
  }

  @override
  Future<Result<void, Failure>> toggleFavorite(String songId) async {
    return const Result.success(null);
  }
}
