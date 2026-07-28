import '../../domain/entities/evolution_summary.dart';

/// In-memory fixture source. The 1A series is the exact polyline from the
/// Figma chart (node 73:305, y values over a 102px box).
class EvolutionLocalDataSource {
  const EvolutionLocalDataSource();

  static const List<double> _figmaSeries1A = <double>[
    102, 88, 92, 66, 74, 46, 52, 22, 0,
  ];

  static const Map<EvolutionRange, List<double>> _series =
      <EvolutionRange, List<double>>{
    EvolutionRange.oneMonth: <double>[70, 74, 66, 60, 64, 52, 56, 44, 36],
    EvolutionRange.sixMonths: <double>[90, 80, 84, 70, 60, 64, 40, 28, 16],
    EvolutionRange.oneYear: _figmaSeries1A,
    EvolutionRange.twoYears: <double>[102, 96, 84, 88, 66, 54, 40, 20, 4],
    EvolutionRange.max: <double>[102, 100, 94, 84, 76, 60, 44, 22, 0],
  };

  static const Map<EvolutionRange, List<String>> _months =
      <EvolutionRange, List<String>>{
    EvolutionRange.oneMonth: <String>['S1', 'S2', 'S3', 'S4', ''],
    EvolutionRange.sixMonths:
        <String>['Jan', 'Fev', 'Mar', 'Abr', 'Mai'],
    EvolutionRange.oneYear:
        <String>['Jun/23', 'Set/23', 'Dez/23', 'Mar/24', 'Jun/24'],
    EvolutionRange.twoYears:
        <String>['Jun/22', 'Dez/22', 'Jun/23', 'Dez/23', 'Jun/24'],
    EvolutionRange.max:
        <String>['2020', '2021', '2022', '2023', '2024'],
  };

  Future<EvolutionSummary> fetchEvolution(EvolutionRange range) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return EvolutionSummary(
      total: 125430.50,
      periodChange: 18420.10,
      periodChangePercent: 16.75,
      periodLabel: switch (range) {
        EvolutionRange.oneMonth => 'no mês',
        EvolutionRange.sixMonths => 'no semestre',
        EvolutionRange.oneYear => 'no ano',
        EvolutionRange.twoYears => 'em 2 anos',
        EvolutionRange.max => 'desde o início',
      },
      chartPoints: _series[range]!
          .map((double y) => 1 - y / 102)
          .toList(growable: false),
      monthLabels: _months[range]!,
      initialValue: 107010.40,
      contributions: 25600.00,
      profit: 18420.10,
    );
  }
}
