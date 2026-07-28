import 'package:flutter/foundation.dart';

import '../../../../core/format/brl.dart';
import '../../domain/entities/dashboard_stats.dart';
import '../../domain/entities/portfolio_summary.dart';
import '../../domain/usecases/get_dashboard_stats.dart';
import '../../domain/usecases/get_portfolio_summary.dart';

/// Presentation state + behavior for the Dashboard screen (MVVM).
///
/// The view observes this via [ListenableBuilder]; all formatting lives here
/// so widgets stay declarative.
class HomeViewModel extends ChangeNotifier {
  HomeViewModel({
    required GetPortfolioSummary getPortfolioSummary,
    required GetDashboardStats getDashboardStats,
    required GetPortfolioAllocation getPortfolioAllocation,
  })  : _getPortfolioSummary = getPortfolioSummary,
        _getDashboardStats = getDashboardStats,
        _getPortfolioAllocation = getPortfolioAllocation;

  final GetPortfolioSummary _getPortfolioSummary;
  final GetDashboardStats _getDashboardStats;
  final GetPortfolioAllocation _getPortfolioAllocation;

  PortfolioSummary? _summary;
  DashboardStats? _stats;
  List<AllocationSlice> _allocation = const <AllocationSlice>[];
  ChartRange _selectedRange = ChartRange.oneMonth;
  bool _isBalanceVisible = true;
  bool _isLoading = false;

  PortfolioSummary? get summary => _summary;
  DashboardStats? get stats => _stats;
  List<AllocationSlice> get allocation => _allocation;
  ChartRange get selectedRange => _selectedRange;
  bool get isBalanceVisible => _isBalanceVisible;
  bool get isLoading => _isLoading;

  String get greeting {
    final String name = _summary?.ownerFirstName ?? '';
    return name.isEmpty ? 'Olá 👋' : 'Olá, $name 👋';
  }

  String get formattedTotal {
    final PortfolioSummary? summary = _summary;
    if (summary == null) return '';
    if (!_isBalanceVisible) return 'R\$ ••••••';
    return Brl.format(summary.total);
  }

  /// e.g. `+ R$ 3.250,45 (2,66%) hoje`
  String get formattedPeriodChange {
    final PortfolioSummary? summary = _summary;
    if (summary == null) return '';
    if (!_isBalanceVisible) return '•••';
    final String sign = summary.isPositive ? '+' : '-';
    final String amount = Brl.format(summary.periodChange.abs());
    final String percent = Brl.percent(summary.periodChangePercent.abs());
    final String suffix =
        _selectedRange == ChartRange.oneDay ? ' hoje' : ' no período';
    return '$sign $amount ($percent)$suffix';
  }

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      final List<Object> results = await Future.wait(<Future<Object>>[
        _getPortfolioSummary(_selectedRange),
        _getDashboardStats(),
        _getPortfolioAllocation(),
      ]);
      _summary = results[0] as PortfolioSummary;
      _stats = results[1] as DashboardStats;
      _allocation = (results[2] as List<AllocationSlice>);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> selectRange(ChartRange range) async {
    if (range == _selectedRange && _summary != null) return;
    _selectedRange = range;
    _isLoading = true;
    notifyListeners();
    try {
      _summary = await _getPortfolioSummary(range);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void toggleBalanceVisibility() {
    _isBalanceVisible = !_isBalanceVisible;
    notifyListeners();
  }
}
