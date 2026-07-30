import '../../domain/entities/song.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/repositories/music_repository.dart';
import '../datasource/music_remote_source.dart';
import '../../core/database/app_database.dart';
import '../../core/error/result.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import 'package:drift/drift.dart';

class MusicRepositoryImpl implements MusicRepository {
  final MusicRemoteDataSource remoteDataSource;
  final AppDatabase database;

  MusicRepositoryImpl({
    required this.remoteDataSource,
    required this.database,
  });

  @override
  Future<Result<List<Song>, ServerFailure>> getTrendingSongs() async {
    try {
      // First try fetching trending songs from the YouTube Music FastAPI backend clone
      final models = await remoteDataSource.fetchTrendingSongs();
      if (models.isNotEmpty) {
        return Result.success(models);
      }
    } catch (_) {
      // Fallback: Return local indexed songs if offline or server is down
    }

    try {
      final localSongs = await database.select(database.songs).get();
      final songsList = localSongs
          .map((s) => Song(
                id: s.id,
                title: s.title,
                artist: s.artist,
                album: s.album,
                artworkUrl: s.artworkUrl ?? '',
                sourceUrl: s.path,
                duration: Duration(milliseconds: s.durationMs ?? 0),
                isLocal: s.isLocal,
                isFavorite: s.isFavorite,
              ))
          .toList();
      return Result.success(songsList);
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<Playlist>, ServerFailure>> getFeaturedPlaylists() async {
    try {
      final models = await remoteDataSource.fetchFeaturedPlaylists();
      if (models.isNotEmpty) {
        return Result.success(models);
      }
    } catch (_) {}

    try {
      final localPlaylists = await database.select(database.playlists).get();
      final playlistsList = localPlaylists
          .map((p) => Playlist(
                id: p.id,
                name: p.name,
                description: p.description ?? '',
                artworkUrl: p.artworkUrl ?? '',
                songs: const [],
                creator: p.creator,
              ))
          .toList();
      return Result.success(playlistsList);
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<Song>, ServerFailure>> searchSongs(String query) async {
    final List<Song> combined = [];

    // 1. Fetch matching local indexed songs from the Drift database
    try {
      final localMatches = await (database.select(database.songs)
            ..where((t) => t.title.toLowerCase().like('%${query.toLowerCase()}%') | 
                           t.artist.toLowerCase().like('%${query.toLowerCase()}%')))
          .get();
          
      combined.addAll(localMatches.map((s) => Song(
            id: s.id,
            title: s.title,
            artist: s.artist,
            album: s.album,
            artworkUrl: s.artworkUrl ?? '',
            sourceUrl: s.path,
            duration: Duration(milliseconds: s.durationMs ?? 0),
            isLocal: s.isLocal,
            isFavorite: s.isFavorite,
          )));
    } catch (_) {}

    // 2. Fetch remote search results from the YouTube Music FastAPI backend clone
    try {
      final remoteModels = await remoteDataSource.searchSongs(query);
      combined.addAll(remoteModels);
    } on ServerException catch (e) {
      if (combined.isEmpty) {
        return Result.failure(ServerFailure(e.message));
      }
    } catch (e) {
      if (combined.isEmpty) {
        return Result.failure(ServerFailure(e.toString()));
      }
    }

    return Result.success(combined);
  }

  @override
  Future<Result<Song, ServerFailure>> getSongDetails(String songId) async {
    // 1. Check local catalog first
    try {
      final localList = await (database.select(database.songs)
            ..where((t) => t.id.equals(songId)))
          .get();
      if (localList.isNotEmpty) {
        final s = localList.first;
        return Result.success(Song(
          id: s.id,
          title: s.title,
          artist: s.artist,
          album: s.album,
          artworkUrl: s.artworkUrl ?? '',
          sourceUrl: s.path,
          duration: Duration(milliseconds: s.durationMs ?? 0),
          isLocal: s.isLocal,
          isFavorite: s.isFavorite,
        ));
      }
    } catch (_) {}

    // 2. Query remote details from the YouTube Music FastAPI backend clone
    try {
      final model = await remoteDataSource.fetchSongDetails(songId);
      return Result.success(model);
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(e.message));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Result<Playlist, ServerFailure>> getPlaylistDetails(String playlistId) async {
    try {
      final model = await remoteDataSource.fetchPlaylistDetails(playlistId);
      return Result.success(model);
    } on ServerException catch (e) {
      return Result.failure(ServerFailure(e.message));
    } catch (e) {
      return Result.failure(ServerFailure(e.toString()));
    }
  }
}
