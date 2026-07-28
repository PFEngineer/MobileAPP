import '../entities/goal.dart';
import '../repositories/goals_repository.dart';

/// Fetches the user's savings goals.
class GetGoals {
  const GetGoals(this._repository);

  final GoalsRepository _repository;

  Future<List<Goal>> call() => _repository.getGoals();
}
