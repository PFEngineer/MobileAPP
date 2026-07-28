import '../entities/goal.dart';

/// Domain contract for savings goals.
abstract interface class GoalsRepository {
  Future<List<Goal>> getGoals();
}
