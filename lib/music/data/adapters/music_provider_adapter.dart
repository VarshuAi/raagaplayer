import '../../domain/entities/song.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/search_result.dart';

abstract class MusicProviderAdapter {
  Future<List<Song>> getTrendingSongs();
  Future<Song> getSongDetails(String id);
  Future<List<Playlist>> getFeaturedPlaylists();
  Future<SearchResult> search(String query);
}
