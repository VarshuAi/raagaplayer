import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/urls.dart';
import '../../core/error/exceptions.dart';
import '../models/song_model.dart';
import '../models/playlist_model.dart';

abstract class MusicRemoteDataSource {
  Future<List<SongModel>> fetchTrendingSongs();
  Future<List<PlaylistModel>> fetchFeaturedPlaylists();
  Future<List<SongModel>> searchSongs(String query);
  Future<SongModel> fetchSongDetails(String songId);
  Future<PlaylistModel> fetchPlaylistDetails(String playlistId);
}

class MusicRemoteDataSourceImpl implements MusicRemoteDataSource {
  final http.Client client;

  MusicRemoteDataSourceImpl({required this.client});

  @override
  Future<List<SongModel>> fetchTrendingSongs() async {
    final uri = Uri.parse('${AppUrls.baseApiUrl}${AppUrls.trendingRecommendations}');
    try {
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<SongModel> songs = [];
        
        if (data['success'] == true && data['shelves'] != null) {
          final List<dynamic> shelves = data['shelves'];
          for (final shelf in shelves) {
            final List<dynamic> items = shelf['items'] ?? [];
            for (final item in items) {
              if (item['type'] == 'song') {
                songs.add(SongModel(
                  id: item['id'] ?? '',
                  title: item['title'] ?? '',
                  artist: item['artist'] ?? 'Unknown Artist',
                  album: 'Single',
                  artworkUrl: item['thumbnail'] ?? '',
                  sourceUrl: '${AppUrls.baseApiUrl}${AppUrls.streamUrl}?id=${item['id']}',
                  duration: const Duration(minutes: 3),
                ));
              }
            }
          }
        } else if (data['success'] == true && data['results'] != null) {
          final List<dynamic> results = data['results'];
          for (final r in results) {
            songs.add(SongModel(
              id: r['id'] ?? '',
              title: r['title'] ?? '',
              artist: r['artist'] ?? 'Unknown Artist',
              album: 'Single',
              artworkUrl: r['thumbnail'] ?? '',
              sourceUrl: '${AppUrls.baseApiUrl}${AppUrls.streamUrl}?id=${r['id']}',
              duration: const Duration(minutes: 3),
            ));
          }
        }
        return songs;
      } else {
        throw ServerException('Failed to fetch trending songs: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<PlaylistModel>> fetchFeaturedPlaylists() async {
    final uri = Uri.parse('${AppUrls.baseApiUrl}${AppUrls.trendingRecommendations}');
    try {
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<PlaylistModel> playlists = [];

        if (data['success'] == true && data['shelves'] != null) {
          final List<dynamic> shelves = data['shelves'];
          for (final shelf in shelves) {
            final List<dynamic> items = shelf['items'] ?? [];
            final isSongList = items.isNotEmpty && items[0]['type'] == 'song';
            
            if (!isSongList) {
              playlists.add(PlaylistModel(
                id: shelf['title'] ?? '',
                name: shelf['title'] ?? '',
                description: shelf['strapline'] ?? '',
                artworkUrl: items.isNotEmpty ? (items[0]['thumbnail'] ?? '') : '',
                songs: const [],
                creator: 'YouTube Music',
              ));
            }
          }
        }
        return playlists;
      } else {
        throw ServerException('Failed to fetch playlists: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<SongModel>> searchSongs(String query) async {
    final uri = Uri.parse('${AppUrls.baseApiUrl}${AppUrls.searchMusic}?q=${Uri.encodeComponent(query)}');
    try {
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<SongModel> songs = [];

        if (data['success'] == true && data['results'] != null) {
          final List<dynamic> results = data['results'];
          for (final r in results) {
            if (r['type'] == 'song') {
              songs.add(SongModel(
                id: r['id'] ?? r['videoId'] ?? '',
                title: r['title'] ?? '',
                artist: r['subtitle'] ?? 'Unknown Artist',
                album: 'Album',
                artworkUrl: r['thumbnail'] ?? '',
                sourceUrl: '${AppUrls.baseApiUrl}${AppUrls.streamUrl}?id=${r['id'] ?? r['videoId']}',
                duration: const Duration(minutes: 3),
              ));
            }
          }
        }
        return songs;
      } else {
        throw ServerException('Search failed: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<SongModel> fetchSongDetails(String songId) async {
    final uri = Uri.parse('${AppUrls.baseApiUrl}${AppUrls.streamUrl}?id=$songId');
    try {
      final response = await client.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (data['success'] == true) {
          return SongModel(
            id: songId,
            title: data['title'] ?? 'Unknown Title',
            artist: data['artist'] ?? 'Unknown Artist',
            album: 'Single',
            artworkUrl: data['thumbnail'] ?? '',
            sourceUrl: data['url'] ?? '',
            duration: const Duration(minutes: 3),
          );
        }
      }
      throw const ServerException('Failed to load song details');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<PlaylistModel> fetchPlaylistDetails(String playlistId) async {
    throw UnimplementedError();
  }
}
