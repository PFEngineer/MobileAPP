import '../../domain/entities/dashboard_stats.dart';
import '../../domain/entities/portfolio_summary.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_data_source.dart';

/// Data-layer implementation of [PortfolioRepository], backed by the local
/// fixture source. Swap the data source for an API client when one exists.
class PortfolioRepositoryImpl implements PortfolioRepository {
  const PortfolioRepositoryImpl(this._dataSource);

  final PortfolioLocalDataSource _dataSource;

  @override
  Future<PortfolioSummary> getSummary(ChartRange range) =>
      _dataSource.fetchSummary(range);

  @override
  Future<DashboardStats> getDashboardStats() =>
      _dataSource.fetchDashboardStats();

  @override
  Future<List<AllocationSlice>> getAllocation() => _dataSource.fetchAllocation();
}
