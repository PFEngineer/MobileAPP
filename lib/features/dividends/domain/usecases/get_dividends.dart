import '../entities/dividend.dart';
import '../repositories/dividends_repository.dart';

/// Fetches upcoming dividend payments.
class GetUpcomingPayments {
  const GetUpcomingPayments(this._repository);

  final DividendsRepository _repository;

  Future<List<DividendPayment>> call() => _repository.getUpcomingPayments();
}

/// Fetches the received-this-month summary.
class GetMonthlyReceived {
  const GetMonthlyReceived(this._repository);

  final DividendsRepository _repository;

  Future<MonthlyDividends> call() => _repository.getMonthlyReceived();
}
