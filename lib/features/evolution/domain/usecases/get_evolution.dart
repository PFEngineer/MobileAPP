import '../entities/evolution_summary.dart';
import '../repositories/evolution_repository.dart';

/// Fetches the patrimony evolution for a period.
class GetEvolution {
  const GetEvolution(this._repository);

  final EvolutionRepository _repository;

  Future<EvolutionSummary> call(EvolutionRange range) =>
      _repository.getEvolution(range);
}
