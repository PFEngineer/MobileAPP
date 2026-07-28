import '../entities/discover_content.dart';
import '../repositories/discover_repository.dart';

/// Fetches personalized insights.
class GetInsights {
  const GetInsights(this._repository);

  final DiscoverRepository _repository;

  Future<List<DiscoverInsight>> call() => _repository.getInsights();
}

/// Fetches recommended articles.
class GetRecommendedContent {
  const GetRecommendedContent(this._repository);

  final DiscoverRepository _repository;

  Future<List<DiscoverContent>> call() =>
      _repository.getRecommendedContent();
}
