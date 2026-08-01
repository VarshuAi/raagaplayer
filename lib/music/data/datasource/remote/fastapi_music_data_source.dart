import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../domain/entities/song.dart';
import '../../../domain/entities/playlist.dart';
import '../../../domain/entities/search_result.dart';
import '../music_data_source.dart';
import '../../../../../core/constants/urls.dart';
import '../../models/song_model.dart';
import '../../models/playlist_model.dart';

class FastApiMusicDataSource implements MusicDataSource {
  final http.Client client;

  FastApiMusicDataSource({required this.client});

  @override
  Future<List<Song>> fetchTrendingSongs() async {
    final uri = Uri.parse('${AppUrls.baseApiUrl}${AppUrls.trendingRecommendations}');
    final response = await client.get(uri);
    if (response.statusCode != 200) throw Exception('FastAPI trending failed');
    final Map<String, dynamic> data = json.decode(response.body);
    final List<Song> songs = [];
    if (data['trending'] != null) {
      for (final r in data['trending']) {
        songs.add(SongModel.fromJson(r as Map<String, dynamic>));
      }
    } else if (data['success'] == true && data['results'] != null) {
      for (final r in data['results']) {
        songs.add(SongModel.fromJson(r));
      }
    }
    return songs;
  }

  @override
  Future<Song> fetchSongDetails(String songId) async {
    final uri = Uri.parse('${AppUrls.baseApiUrl}${AppUrls.streamUrl}?id=$songId');
    final response = await client.get(uri);
    if (response.statusCode != 200) throw Exception('FastAPI stream failed');
    final Map<String, dynamic> data = json.decode(response.body);
    return SongModel.fromJson(data);
  }

  @override
  Future<List<Playlist>> fetchFeaturedPlaylists() async {
    final uri = Uri.parse('${AppUrls.baseApiUrl}${AppUrls.trendingRecommendations}');
    final response = await client.get(uri);
    if (response.statusCode != 200) throw Exception('FastAPI shelves failed');
    final Map<String, dynamic> data = json.decode(response.body);
    final List<Playlist> playlists = [];
    if (data['playlists'] != null) {
      for (final pl in data['playlists']) {
        playlists.add(PlaylistModel(
          id: pl['id'] ?? '',
          name: pl['title'] ?? '',
          description: pl['subtitle'] ?? '',
          artworkUrl: pl['image'] ?? '',
          songs: const [],
          creator: 'FastAPI YTM Engine',
        ));
      }
    } else if (data['success'] == true && data['shelves'] != null) {
      for (final shelf in data['shelves']) {
        playlists.add(PlaylistModel(
          id: shelf['title'] ?? '',
          name: shelf['title'] ?? '',
          description: shelf['strapline'] ?? '',
          artworkUrl: '',
          songs: const [],
          creator: 'FastAPI YTM Engine',
        ));
      }
    }
    return playlists;
  }

  @override
  Future<SearchResult> searchSongs(String query) async {
    final uri = Uri.parse('${AppUrls.baseApiUrl}${AppUrls.searchMusic}?q=${Uri.encodeComponent(query)}');
    final response = await client.get(uri);
    if (response.statusCode != 200) throw Exception('FastAPI search failed');
    final Map<String, dynamic> data = json.decode(response.body);
    final List<Song> songs = [];
    if (data['songs'] != null) {
      for (final r in data['songs']) {
        songs.add(SongModel.fromJson(r as Map<String, dynamic>));
      }
    } else if (data['success'] == true && data['results'] != null) {
      for (final r in data['results']) {
        if (r['type'] == 'song') {
          songs.add(SongModel.fromJson(r));
        }
      }
    }
    return SearchResult(
      songs: songs,
      albums: [],
      artists: [],
      playlists: [],
    );
  }

  @override
  Future<Playlist> fetchPlaylistDetails(String playlistId) async {
    throw UnimplementedError();
  }
}
