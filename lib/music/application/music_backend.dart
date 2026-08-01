import '../domain/repositories/music_repository.dart';
import '../domain/repositories/search_repository.dart';
import '../domain/repositories/playlist_repository.dart';
import 'home_feed_coordinator.dart';
import 'search_coordinator.dart';
import 'playlist_coordinator.dart';
import 'queue_coordinator.dart';
import 'radio_coordinator.dart';
import 'recommendation_coordinator.dart';

class MusicBackend {
  final MusicRepository musicRepository;
  final SearchRepository searchRepository;
  final PlaylistRepository playlistRepository;

  final HomeFeedCoordinator homeFeedCoordinator;
  final SearchCoordinator searchCoordinator;
  final PlaylistCoordinator playlistCoordinator;
  final QueueCoordinator queueCoordinator;
  final RadioCoordinator radioCoordinator;
  final RecommendationCoordinator recommendationCoordinator;

  MusicBackend({
    required this.musicRepository,
    required this.searchRepository,
    required this.playlistRepository,
    required this.homeFeedCoordinator,
    required this.searchCoordinator,
    required this.playlistCoordinator,
    required this.queueCoordinator,
    required this.radioCoordinator,
    required this.recommendationCoordinator,
  });
}
