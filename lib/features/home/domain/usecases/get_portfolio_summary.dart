import '../entities/portfolio_summary.dart';
import '../repositories/portfolio_repository.dart';

/// Fetches the portfolio snapshot for a chart period.
class GetPortfolioSummary {
  const GetPortfolioSummary(this._repository);

  final PortfolioRepository _repository;

  Future<PortfolioSummary> call(ChartRange range) =>
      _repository.getSummary(range);
}
