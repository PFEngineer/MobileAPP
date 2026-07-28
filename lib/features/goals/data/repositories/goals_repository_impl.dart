import '../../domain/entities/goal.dart';
import '../../domain/repositories/goals_repository.dart';
import '../datasources/goals_local_data_source.dart';

/// Data-layer implementation of [GoalsRepository], backed by fixtures.
class GoalsRepositoryImpl implements GoalsRepository {
  const GoalsRepositoryImpl(this._dataSource);

  final GoalsLocalDataSource _dataSource;

  @override
  Future<List<Goal>> getGoals() => _dataSource.fetchGoals();
}
