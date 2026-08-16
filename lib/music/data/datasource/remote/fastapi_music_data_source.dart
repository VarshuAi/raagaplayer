import 'package:youtube_explode_dart/youtube_explode_dart.dart' hide Playlist, SearchResult;
import '../../../domain/entities/song.dart';
import '../../../domain/entities/playlist.dart';
import '../../../domain/entities/search_result.dart';
import '../music_data_source.dart';
import '../../models/song_model.dart';
import '../../models/playlist_model.dart';
import 'ytmusic_client.dart';

class FastApiMusicDataSource implements MusicDataSource {
  final dynamic client;

  FastApiMusicDataSource({this.client});

  SongModel _mapToModel(Map<String, dynamic> m) {
    return SongModel(
      id: m['id'] as String,
      title: m['title'] as String,
      artist: m['artist'] as String,
      album: '',
      artworkUrl: m['artworkUrl'] as String,
      sourceUrl: '/api/stream?id=${m['id']}',
      duration: Duration(seconds: m['durationSeconds'] as int),
    );
  }

  @override
  Future<List<Song>> fetchTrendingSongs() async {
    // YouTube Music search: top hits
    final data = await ytMusicPost('search', {
      'query': 'top hits 2024',
      'params': 'EgWKAQIIAWoKEAMQBBAJEAoQBQ%3D%3D',
    });
    final songs = extractSongs(data);
    if (songs.isNotEmpty) return songs.take(20).map(_mapToModel).toList();

    // Fallback to regular YouTube
    try {
      final list = await ytExplode.search.search('top music hits 2024');
      final result = list.map((v) => SongModel(
        id: v.id.value,
        title: v.title,
        artist: v.author
            .replaceAll(RegExp(r'\s*-\s*Topic$', caseSensitive: false), '')
            .trim(),
        album: '',
        artworkUrl: upgradeToHighResArtwork(v.thumbnails.highResUrl),
        sourceUrl: '/api/stream?id=${v.id.value}',
        duration: v.duration ?? const Duration(minutes: 3),
      )).toList();
      return result;
    } catch (_) {
      return [];
    }
  }

  @override
  Future<Song> fetchSongDetails(String songId) async {
    try {
      final video = await ytExplode.videos.get(songId);
      final song = SongModel(
        id: video.id.value,
        title: video.title,
        artist: video.author
            .replaceAll(RegExp(r'\s*-\s*Topic$', caseSensitive: false), '')
            .trim(),
        album: '',
        artworkUrl: upgradeToHighResArtwork(video.thumbnails.highResUrl),
        sourceUrl: '/api/stream?id=${video.id.value}',
        duration: video.duration ?? const Duration(minutes: 3),
      );
      return song;
    } catch (e) {
      throw Exception('Song details fetch failed: $e');
    }
  }

  @override
  Future<List<Playlist>> fetchFeaturedPlaylists() async => [];

  @override
  Future<SearchResult> searchSongs(String query) async {
    // YouTube Music search (songs-only filter)
    final data = await ytMusicPost('search', {
      'query': query,
      'params': 'EgWKAQIIAWoKEAMQBBAJEAoQBQ%3D%3D',
    });
    final songs = extractSongs(data);
    if (songs.isNotEmpty) {
      return SearchResult(
        songs: songs.map(_mapToModel).toList(),
        albums: [],
        artists: [],
        playlists: [],
      );
    }

    // Fallback to regular YouTube
    try {
      final list = await ytExplode.search.search(query);
      final result = list.map((v) => SongModel(
        id: v.id.value,
        title: v.title,
        artist: v.author
            .replaceAll(RegExp(r'\s*-\s*Topic$', caseSensitive: false), '')
            .trim(),
        album: '',
        artworkUrl: upgradeToHighResArtwork(v.thumbnails.highResUrl),
        sourceUrl: '/api/stream?id=${v.id.value}',
        duration: v.duration ?? const Duration(minutes: 3),
      )).toList();
      return SearchResult(songs: result, albums: [], artists: [], playlists: []);
    } catch (e) {
      return SearchResult(songs: [], albums: [], artists: [], playlists: []);
    }
  }

  @override
  Future<Playlist> fetchPlaylistDetails(String playlistId) async {
    throw UnimplementedError();
  }
}
