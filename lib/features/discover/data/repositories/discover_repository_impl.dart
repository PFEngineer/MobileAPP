import '../../domain/entities/discover_content.dart';
import '../../domain/repositories/discover_repository.dart';
import '../datasources/discover_local_data_source.dart';

/// Data-layer implementation of [DiscoverRepository], backed by fixtures.
class DiscoverRepositoryImpl implements DiscoverRepository {
  const DiscoverRepositoryImpl(this._dataSource);

  final DiscoverLocalDataSource _dataSource;

  @override
  Future<List<DiscoverInsight>> getInsights() => _dataSource.fetchInsights();

  @override
  Future<List<DiscoverContent>> getRecommendedContent() =>
      _dataSource.fetchRecommendedContent();
}
