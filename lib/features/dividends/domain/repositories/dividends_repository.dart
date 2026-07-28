import '../entities/dividend.dart';

/// Domain contract for dividend data.
abstract interface class DividendsRepository {
  Future<List<DividendPayment>> getUpcomingPayments();

  Future<MonthlyDividends> getMonthlyReceived();
}
