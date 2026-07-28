import '../../domain/entities/dashboard_stats.dart';
import '../../domain/entities/portfolio_summary.dart';

/// In-memory fixture source until a real API exists. The 1M series is the
/// exact polyline from the Figma hero (node 63:27, y values over a 36px box).
class PortfolioLocalDataSource {
  const PortfolioLocalDataSource();

  static const List<double> _figmaSeries1M = <double>[
    36, 30, 34, 20, 26, 14, 22, 8, 16, 4, 10, 0,
  ];

  static const Map<ChartRange, List<double>> _series =
      <ChartRange, List<double>>{
    ChartRange.oneDay: <double>[20, 24, 18, 22, 16, 20, 14, 18, 12, 16, 10, 8],
    ChartRange.oneMonth: _figmaSeries1M,
    ChartRange.sixMonths: <double>[34, 30, 32, 26, 28, 22, 24, 16, 18, 10, 6, 2],
    ChartRange.oneYear: <double>[36, 34, 30, 32, 26, 22, 24, 18, 14, 10, 8, 0],
    ChartRange.allTime: <double>[36, 35, 34, 32, 30, 26, 24, 20, 14, 10, 6, 0],
  };

  static const Map<ChartRange, (double, double)> _changeByRange =
      <ChartRange, (double, double)>{
    ChartRange.oneDay: (1150.20, 0.92),
    ChartRange.oneMonth: (3250.45, 2.66),
    ChartRange.sixMonths: (9840.12, 8.51),
    ChartRange.oneYear: (18230.80, 17.01),
    ChartRange.allTime: (45430.50, 56.79),
  };

  Future<PortfolioSummary> fetchSummary(ChartRange range) async {
    // Simulates transport latency so loading states stay honest.
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final (change, percent) = _changeByRange[range]!;
    return PortfolioSummary(
      ownerFirstName: 'Paulo',
      total: 125430.50,
      periodChange: change,
      periodChangePercent: percent,
      chartPoints: _series[range]!
          .map((double y) => 1 - y / 36)
          .toList(growable: false),
    );
  }

  Future<DashboardStats> fetchDashboardStats() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    // Figma 64:14 fixture values.
    return const DashboardStats(
      profitMonth: 2350.40,
      profitMonthPercent: 1.92,
      profitYear: 18420.10,
      profitYearPercent: 16.75,
      dividendsMonth: 1250.00,
      dividendsYear: 8340.00,
    );
  }

  Future<List<AllocationSlice>> fetchAllocation() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    // Figma 64:31 fixture values.
    return const <AllocationSlice>[
      AllocationSlice(assetClass: AssetClass.stocks, percent: 55.6),
      AllocationSlice(assetClass: AssetClass.reits, percent: 22.1),
      AllocationSlice(assetClass: AssetClass.etfs, percent: 12.3),
      AllocationSlice(assetClass: AssetClass.others, percent: 10.0),
    ];
  }
}
