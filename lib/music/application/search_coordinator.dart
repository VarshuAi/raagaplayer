import '../domain/entities/search_result.dart';
import '../domain/usecases/search_music_use_case.dart';
import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';

class SearchCoordinator {
  final SearchMusicUseCase searchMusicUseCase;

  SearchCoordinator(this.searchMusicUseCase);

  Future<Result<SearchResult, Failure>> search(String query) {
    return searchMusicUseCase.execute(query);
  }
}
