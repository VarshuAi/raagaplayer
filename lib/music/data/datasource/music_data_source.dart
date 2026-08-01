import '../../domain/entities/song.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/search_result.dart';

abstract class MusicDataSource {
  Future<List<Song>> fetchTrendingSongs();
  Future<Song> fetchSongDetails(String songId);
  Future<List<Playlist>> fetchFeaturedPlaylists();
  Future<SearchResult> searchSongs(String query);
  Future<Playlist> fetchPlaylistDetails(String playlistId);
}
