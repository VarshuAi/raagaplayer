import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../../../../plugins/provider_registry.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/repositories/playlist_repository.dart';
import '../adapters/music_provider_adapter.dart';

class PlaylistRepositoryImpl implements PlaylistRepository {
  MusicProviderAdapter get _adapter => ProviderRegistry().activePlugin.adapter;

  @override
  Future<Result<List<Playlist>, Failure>> getPlaylists() async {
    try {
      final playlists = await _adapter.getFeaturedPlaylists();
      return Result.success(playlists);
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<Playlist, Failure>> getPlaylistDetails(String id) async {
    return Result.failure(ServerFailure("Unimplemented"));
  }

  @override
  Future<Result<Playlist, Failure>> createPlaylist(String name, String description) async {
    return Result.failure(ServerFailure("Unimplemented"));
  }

  @override
  Future<Result<void, Failure>> deletePlaylist(String id) async {
    return const Result.success(null);
  }

  @override
  Future<Result<void, Failure>> addSongToPlaylist(String playlistId, String songId) async {
    return const Result.success(null);
  }

  @override
  Future<Result<void, Failure>> removeSongFromPlaylist(String playlistId, String songId) async {
    return const Result.success(null);
  }
}
