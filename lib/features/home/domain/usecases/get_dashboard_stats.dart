import '../entities/dashboard_stats.dart';
import '../repositories/portfolio_repository.dart';

/// Fetches the profit/dividend stats for the Dashboard card.
class GetDashboardStats {
  const GetDashboardStats(this._repository);

  final PortfolioRepository _repository;

  Future<DashboardStats> call() => _repository.getDashboardStats();
}

/// Fetches the portfolio allocation for the donut card.
class GetPortfolioAllocation {
  const GetPortfolioAllocation(this._repository);

  final PortfolioRepository _repository;

  Future<List<AllocationSlice>> call() => _repository.getAllocation();
}
