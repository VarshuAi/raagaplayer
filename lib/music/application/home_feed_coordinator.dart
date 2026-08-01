import '../domain/entities/song.dart';
import '../domain/usecases/get_home_feed_use_case.dart';
import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';

class HomeFeedCoordinator {
  final GetHomeFeedUseCase getHomeFeedUseCase;

  HomeFeedCoordinator(this.getHomeFeedUseCase);

  Future<Result<List<Song>, Failure>> getTrendingRecommendations() {
    return getHomeFeedUseCase.execute();
  }
}
