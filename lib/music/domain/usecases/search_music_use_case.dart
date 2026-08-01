import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/search_result.dart';
import '../repositories/search_repository.dart';

class SearchMusicUseCase {
  final SearchRepository repository;

  SearchMusicUseCase(this.repository);

  Future<Result<SearchResult, Failure>> execute(String query) {
    return repository.search(query);
  }
}
