import 'package:flutter/foundation.dart';

import '../../domain/usecases/calculate_future_value.dart';

/// Presentation state for the Simulador screen (MVVM). Pure computation —
/// no repository needed; the use case owns the financial math.
class SimulatorViewModel extends ChangeNotifier {
  SimulatorViewModel({required CalculateFutureValue calculateFutureValue})
      : _calculate = calculateFutureValue;

  final CalculateFutureValue _calculate;

  // Defaults from Figma 07. Simulador.
  double _monthlyContribution = 2000.00;
  double _annualRatePercent = 10;
  int _years = 20;

  double get monthlyContribution => _monthlyContribution;
  double get annualRatePercent => _annualRatePercent;
  int get years => _years;

  double get futureValue => _calculate(
        monthlyContribution: _monthlyContribution,
        annualRatePercent: _annualRatePercent,
        years: _years,
      );

  List<double> get chartPoints => _calculate.milestones(
        monthlyContribution: _monthlyContribution,
        annualRatePercent: _annualRatePercent,
        years: _years,
      );

  void setMonthlyContribution(String raw) {
    _monthlyContribution = _parseAmount(raw);
    notifyListeners();
  }

  void setAnnualRate(String raw) {
    _annualRatePercent = _parseAmount(raw);
    notifyListeners();
  }

  void setYears(String raw) {
    _years = int.tryParse(raw.replaceAll(RegExp(r'[^\d]'), '')) ?? 0;
    notifyListeners();
  }

  static double _parseAmount(String raw) {
    final String normalized = raw
        .replaceAll(RegExp(r'[^\d,\.]'), '')
        .replaceAll('.', '')
        .replaceAll(',', '.');
    return double.tryParse(normalized) ?? 0;
  }
}
