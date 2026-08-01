import '../domain/entities/song.dart';
import '../domain/usecases/generate_recommendations_use_case.dart';
import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';

class RecommendationCoordinator {
  final GenerateRecommendationsUseCase generateRecommendationsUseCase;

  RecommendationCoordinator(this.generateRecommendationsUseCase);

  Future<Result<List<Song>, Failure>> getRecommendations() {
    return generateRecommendationsUseCase.execute();
  }
}
