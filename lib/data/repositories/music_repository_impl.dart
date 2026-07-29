import '../../domain/entities/song.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/repositories/music_repository.dart';
import '../datasource/music_remote_source.dart';
import '../../core/error/result.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';

class MusicRepositoryImpl implements MusicRepository {
  final MusicRemoteDataSource remoteDataSource;

  MusicRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<List<Song>, ServerFailure>> getTrendingSongs() async {
    try {
      final models = await remoteDataSource.fetchTrendingSongs();
      return Result.success(models);
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(e.message));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<Playlist>, ServerFailure>> getFeaturedPlaylists() async {
    try {
      final models = await remoteDataSource.fetchFeaturedPlaylists();
      return Result.success(models);
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(e.message));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<Song>, ServerFailure>> searchSongs(String query) async {
    try {
      final models = await remoteDataSource.searchSongs(query);
      return Result.success(models);
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(e.message));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<Song, ServerFailure>> getSongDetails(String songId) async {
    try {
      final model = await remoteDataSource.fetchSongDetails(songId);
      return Result.success(model);
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(e.message));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<Playlist, ServerFailure>> getPlaylistDetails(String playlistId) async {
    try {
      final model = await remoteDataSource.fetchPlaylistDetails(playlistId);
      return Result.success(model);
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(e.message));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }
}
