import '../../domain/entities/goal.dart';

/// In-memory fixture source — exact values from Figma 06. Metas.
class GoalsLocalDataSource {
  const GoalsLocalDataSource();

  Future<List<Goal>> fetchGoals() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return const <Goal>[
      Goal(
        name: 'Aposentadoria',
        target: 2000000.00,
        saved: 1240500.00,
        deadlineLabel: 'Prazo: 31/12/2035',
        suggestedMonthlyContribution: 2800.00,
        projectedReturnLabel: '10,0% ao ano',
      ),
      Goal(
        name: 'Compra de imóvel',
        target: 500000.00,
        saved: 175000.00,
        deadlineLabel: 'Prazo: 31/12/2028',
      ),
    ];
  }
}
