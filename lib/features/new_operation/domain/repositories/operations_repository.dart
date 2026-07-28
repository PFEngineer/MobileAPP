import '../entities/operation.dart';

/// Domain contract for recording operations.
abstract interface class OperationsRepository {
  Future<void> saveOperation(Operation operation);
}
