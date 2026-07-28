import '../entities/operation.dart';
import '../repositories/operations_repository.dart';

/// Persists a manually recorded trade.
class SaveOperation {
  const SaveOperation(this._repository);

  final OperationsRepository _repository;

  Future<void> call(Operation operation) =>
      _repository.saveOperation(operation);
}
