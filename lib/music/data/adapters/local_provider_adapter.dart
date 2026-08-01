import 'package:raaga_music_player/music/domain/entities/song.dart';
import 'package:raaga_music_player/music/domain/entities/playlist.dart';
import 'package:raaga_music_player/music/domain/entities/search_result.dart';
import '../datasource/local/local_music_data_source.dart';
import 'music_provider_adapter.dart';

class LocalProviderAdapter implements MusicProviderAdapter {
  final LocalMusicDataSource dataSource;

  LocalProviderAdapter(this.dataSource);

  @override
  Future<List<Song>> getTrendingSongs() => dataSource.fetchTrendingSongs();

  @override
  Future<Song> getSongDetails(String id) => dataSource.fetchSongDetails(id);

  @override
  Future<List<Playlist>> getFeaturedPlaylists() =>
      dataSource.fetchFeaturedPlaylists();

  @override
  Future<SearchResult> search(String query) => dataSource.searchSongs(query);
}
