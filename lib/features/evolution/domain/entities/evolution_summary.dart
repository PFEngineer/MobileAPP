import 'package:flutter/foundation.dart';

/// Chart period options — Figma 05. Evolução chips (73:289).
enum EvolutionRange {
  oneMonth('1M'),
  sixMonths('6M'),
  oneYear('1A'),
  twoYears('2A'),
  max('Máx');

  const EvolutionRange(this.label);

  final String label;
}

/// Patrimony evolution for a period (Figma 05. Evolução).
@immutable
class EvolutionSummary {
  const EvolutionSummary({
    required this.total,
    required this.periodChange,
    required this.periodChangePercent,
    required this.periodLabel,
    required this.chartPoints,
    required this.monthLabels,
    required this.initialValue,
    required this.contributions,
    required this.profit,
  });

  final double total;
  final double periodChange;
  final double periodChangePercent;

  /// e.g. `no ano`
  final String periodLabel;

  /// Normalized values in `0..1` (0 = bottom, 1 = top), evenly spaced.
  final List<double> chartPoints;
  final List<String> monthLabels;
  final double initialValue;
  final double contributions;
  final double profit;
}
