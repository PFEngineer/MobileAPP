import 'package:flutter/foundation.dart';

/// Chart period options — Figma hero `range` chips.
enum ChartRange {
  oneDay('1D'),
  oneMonth('1M'),
  sixMonths('6M'),
  oneYear('1A'),
  allTime('Deste Sempre');

  const ChartRange(this.label);

  final String label;
}

/// Snapshot of the user's portfolio for a given [ChartRange].
@immutable
class PortfolioSummary {
  const PortfolioSummary({
    required this.ownerFirstName,
    required this.total,
    required this.periodChange,
    required this.periodChangePercent,
    required this.chartPoints,
  });

  final String ownerFirstName;

  /// Total patrimony in BRL.
  final double total;

  /// Absolute change in BRL for the selected period.
  final double periodChange;

  /// Percent change for the selected period (2.66 == 2,66%).
  final double periodChangePercent;

  /// Normalized chart values in `0..1` (0 = bottom, 1 = top), evenly spaced.
  final List<double> chartPoints;

  bool get isPositive => periodChange >= 0;
}
