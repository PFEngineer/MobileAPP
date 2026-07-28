import 'dart:math' as math;

/// Compound-interest projection for recurring monthly contributions.
///
/// Converts the annual rate to its monthly equivalent and applies the
/// future-value-of-annuity formula.
class CalculateFutureValue {
  const CalculateFutureValue();

  double call({
    required double monthlyContribution,
    required double annualRatePercent,
    required int years,
  }) {
    final int months = years * 12;
    if (months <= 0) return 0;
    final double annualRate = annualRatePercent / 100;
    final double monthlyRate =
        math.pow(1 + annualRate, 1 / 12).toDouble() - 1;
    if (monthlyRate == 0) return monthlyContribution * months;
    return monthlyContribution *
        (math.pow(1 + monthlyRate, months) - 1) /
        monthlyRate;
  }

  /// Projection at evenly spaced milestones (for the chart), normalized to
  /// `0..1` of the final value.
  List<double> milestones({
    required double monthlyContribution,
    required double annualRatePercent,
    required int years,
    int count = 5,
  }) {
    final double total = call(
      monthlyContribution: monthlyContribution,
      annualRatePercent: annualRatePercent,
      years: years,
    );
    if (total <= 0) return List<double>.filled(count, 0);
    return List<double>.generate(count, (int i) {
      final int y = (years * i / (count - 1)).round();
      return call(
            monthlyContribution: monthlyContribution,
            annualRatePercent: annualRatePercent,
            years: y,
          ) /
          total;
    });
  }
}
