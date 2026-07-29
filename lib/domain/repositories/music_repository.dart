import '../entities/song.dart';
import '../entities/playlist.dart';
import '../../core/error/result.dart';
import '../../core/error/failures.dart';

abstract class MusicRepository {
  Future<Result<List<Song>, ServerFailure>> getTrendingSongs();
  Future<Result<List<Playlist>, ServerFailure>> getFeaturedPlaylists();
  Future<Result<List<Song>, ServerFailure>> searchSongs(String query);
  Future<Result<Song, ServerFailure>> getSongDetails(String songId);
  Future<Result<Playlist, ServerFailure>> getPlaylistDetails(String playlistId);
}
