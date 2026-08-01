import '../../domain/entities/song.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/search_result.dart';
import '../datasource/remote/fastapi_music_data_source.dart';
import 'music_provider_adapter.dart';

class RemoteProviderAdapter implements MusicProviderAdapter {
  final FastApiMusicDataSource dataSource;

  RemoteProviderAdapter(this.dataSource);

  @override
  Future<List<Song>> getTrendingSongs() => dataSource.fetchTrendingSongs();

  @override
  Future<Song> getSongDetails(String id) => dataSource.fetchSongDetails(id);

  @override
  Future<List<Playlist>> getFeaturedPlaylists() => dataSource.fetchFeaturedPlaylists();

  @override
  Future<SearchResult> search(String query) => dataSource.searchSongs(query);
}
