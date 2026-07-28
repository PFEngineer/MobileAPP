import 'package:flutter/foundation.dart';

/// An upcoming dividend payment (Figma 04. Dividendos list items).
@immutable
class DividendPayment {
  const DividendPayment({
    required this.ticker,
    required this.name,
    required this.initials,
    required this.dateLabel,
    required this.amount,
    required this.daysLeft,
  });

  final String ticker;
  final String name;
  final String initials;
  final String dateLabel;
  final double amount;
  final int daysLeft;
}

/// Monthly received summary with the mini bar chart (Figma 72:209).
@immutable
class MonthlyDividends {
  const MonthlyDividends({
    required this.monthLabel,
    required this.total,
    required this.deltaLabel,
    required this.bars,
    required this.highlightedBar,
  });

  final String monthLabel;
  final double total;
  final String deltaLabel;

  /// Normalized bar heights in `0..1`.
  final List<double> bars;
  final int highlightedBar;
}
