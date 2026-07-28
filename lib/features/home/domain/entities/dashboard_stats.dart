import 'package:flutter/foundation.dart';

/// Profit and dividend figures for the Dashboard stats card (Figma 64:14).
@immutable
class DashboardStats {
  const DashboardStats({
    required this.profitMonth,
    required this.profitMonthPercent,
    required this.profitYear,
    required this.profitYearPercent,
    required this.dividendsMonth,
    required this.dividendsYear,
  });

  final double profitMonth;
  final double profitMonthPercent;
  final double profitYear;
  final double profitYearPercent;
  final double dividendsMonth;
  final double dividendsYear;
}

/// Asset classes used in the portfolio allocation donut (Figma 64:31).
enum AssetClass {
  stocks('Ações'),
  reits('FIIs'),
  etfs('ETFs'),
  others('Outros');

  const AssetClass(this.label);

  final String label;
}

/// One slice of the portfolio allocation.
@immutable
class AllocationSlice {
  const AllocationSlice({required this.assetClass, required this.percent});

  final AssetClass assetClass;

  /// 0..100
  final double percent;
}
