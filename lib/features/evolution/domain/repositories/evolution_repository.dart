import '../entities/evolution_summary.dart';

/// Domain contract for patrimony evolution data.
abstract interface class EvolutionRepository {
  Future<EvolutionSummary> getEvolution(EvolutionRange range);
}
