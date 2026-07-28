import '../entities/discover_content.dart';

/// Domain contract for the Descobrir feed.
abstract interface class DiscoverRepository {
  Future<List<DiscoverInsight>> getInsights();

  Future<List<DiscoverContent>> getRecommendedContent();
}
