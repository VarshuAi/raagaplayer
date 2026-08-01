import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/playlist.dart';

abstract class PlaylistRepository {
  Future<Result<List<Playlist>, Failure>> getPlaylists();
  Future<Result<Playlist, Failure>> getPlaylistDetails(String id);
  Future<Result<Playlist, Failure>> createPlaylist(String name, String description);
  Future<Result<void, Failure>> deletePlaylist(String id);
  Future<Result<void, Failure>> addSongToPlaylist(String playlistId, String songId);
  Future<Result<void, Failure>> removeSongFromPlaylist(String playlistId, String songId);
}
