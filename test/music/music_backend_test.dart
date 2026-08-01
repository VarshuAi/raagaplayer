import 'package:flutter_test/flutter_test.dart';
import 'package:raaga_music_player/core/error/result.dart';
import 'package:raaga_music_player/core/error/failures.dart';
import 'package:raaga_music_player/music/domain/entities/song.dart';
import 'package:raaga_music_player/music/domain/entities/playlist.dart';
import 'package:raaga_music_player/music/domain/entities/search_result.dart';
import 'package:raaga_music_player/music/domain/repositories/music_repository.dart';
import 'package:raaga_music_player/music/domain/repositories/search_repository.dart';
import 'package:raaga_music_player/music/domain/repositories/playlist_repository.dart';
import 'package:raaga_music_player/music/domain/usecases/get_home_feed_use_case.dart';
import 'package:raaga_music_player/music/domain/usecases/search_music_use_case.dart';
import 'package:raaga_music_player/music/domain/usecases/create_playlist_use_case.dart';
import 'package:raaga_music_player/music/domain/usecases/generate_recommendations_use_case.dart';
import 'package:raaga_music_player/music/application/music_backend.dart';
import 'package:raaga_music_player/music/application/home_feed_coordinator.dart';
import 'package:raaga_music_player/music/application/search_coordinator.dart';
import 'package:raaga_music_player/music/application/playlist_coordinator.dart';
import 'package:raaga_music_player/music/application/queue_coordinator.dart';
import 'package:raaga_music_player/music/application/radio_coordinator.dart';
import 'package:raaga_music_player/music/application/recommendation_coordinator.dart';

class StubMusicRepository implements MusicRepository {
  @override
  Future<Result<List<Song>, Failure>> getTrendingSongs() async => const Result.success([]);
  @override
  Future<Result<Song, Failure>> getSongDetails(String id) async => Result.failure(ServerFailure('stub'));
  @override
  Future<Result<List<Song>, Failure>> getFavoriteSongs() async => const Result.success([]);
  @override
  Future<Result<void, Failure>> toggleFavorite(String songId) async => const Result.success(null);
}

class StubSearchRepository implements SearchRepository {
  @override
  Future<Result<SearchResult, Failure>> search(String query) async => Result.success(SearchResult.empty());
  @override
  Future<Result<List<String>, Failure>> getSearchSuggestions(String query) async => const Result.success([]);
  @override
  Future<Result<List<String>, Failure>> getSearchHistory() async => const Result.success([]);
  @override
  Future<Result<void, Failure>> clearSearchHistory() async => const Result.success(null);
}

class StubPlaylistRepository implements PlaylistRepository {
  @override
  Future<Result<List<Playlist>, Failure>> getPlaylists() async => const Result.success([]);
  @override
  Future<Result<Playlist, Failure>> getPlaylistDetails(String id) async => Result.failure(ServerFailure('stub'));
  @override
  Future<Result<Playlist, Failure>> createPlaylist(String name, String description) async => Result.failure(ServerFailure('stub'));
  @override
  Future<Result<void, Failure>> deletePlaylist(String id) async => const Result.success(null);
  @override
  Future<Result<void, Failure>> addSongToPlaylist(String playlistId, String songId) async => const Result.success(null);
  @override
  Future<Result<void, Failure>> removeSongFromPlaylist(String playlistId, String songId) async => const Result.success(null);
}

void main() {
  group('MusicBackend Facade Tests', () {
    test('should construct MusicBackend facade and invoke home feed', () async {
      final musicRepo = StubMusicRepository();
      final searchRepo = StubSearchRepository();
      final playlistRepo = StubPlaylistRepository();

      final homeFeed = HomeFeedCoordinator(GetHomeFeedUseCase(musicRepo));
      final search = SearchCoordinator(SearchMusicUseCase(searchRepo));
      final playlist = PlaylistCoordinator(CreatePlaylistUseCase(playlistRepo));
      final queue = QueueCoordinator();
      final radio = RadioCoordinator();
      final rec = RecommendationCoordinator(GenerateRecommendationsUseCase(musicRepo));

      final backend = MusicBackend(
        musicRepository: musicRepo,
        searchRepository: searchRepo,
        playlistRepository: playlistRepo,
        homeFeedCoordinator: homeFeed,
        searchCoordinator: search,
        playlistCoordinator: playlist,
        queueCoordinator: queue,
        radioCoordinator: radio,
        recommendationCoordinator: rec,
      );

      final result = await backend.homeFeedCoordinator.getTrendingRecommendations();
      expect(result.isSuccess, true);
    });
  });
}
