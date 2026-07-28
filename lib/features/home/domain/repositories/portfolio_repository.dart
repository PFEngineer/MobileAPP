import '../entities/dashboard_stats.dart';
import '../entities/portfolio_summary.dart';

/// Domain contract for portfolio data. Implemented in the data layer; the
/// dependency arrow is always presentation -> domain <- data.
abstract interface class PortfolioRepository {
  Future<PortfolioSummary> getSummary(ChartRange range);

  Future<DashboardStats> getDashboardStats();

  Future<List<AllocationSlice>> getAllocation();
}
