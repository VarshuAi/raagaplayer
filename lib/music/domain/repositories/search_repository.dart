import '../../../../core/error/result.dart';
import '../../../../core/error/failures.dart';
import '../entities/search_result.dart';

abstract class SearchRepository {
  Future<Result<SearchResult, Failure>> search(String query);
  Future<Result<List<String>, Failure>> getSearchSuggestions(String query);
  Future<Result<List<String>, Failure>> getSearchHistory();
  Future<Result<void, Failure>> clearSearchHistory();
}
