import '../../domain/entities/operation.dart';
import '../../domain/repositories/operations_repository.dart';

/// No-backend implementation: accepts the operation and drops it. Swap for a
/// real datasource when the API exists.
class OperationsRepositoryImpl implements OperationsRepository {
  const OperationsRepositoryImpl();

  @override
  Future<void> saveOperation(Operation operation) =>
      Future<void>.delayed(const Duration(milliseconds: 300));
}
