import '../../domain/entities/evolution_summary.dart';
import '../../domain/repositories/evolution_repository.dart';
import '../datasources/evolution_local_data_source.dart';

/// Data-layer implementation of [EvolutionRepository], backed by fixtures.
class EvolutionRepositoryImpl implements EvolutionRepository {
  const EvolutionRepositoryImpl(this._dataSource);

  final EvolutionLocalDataSource _dataSource;

  @override
  Future<EvolutionSummary> getEvolution(EvolutionRange range) =>
      _dataSource.fetchEvolution(range);
}
