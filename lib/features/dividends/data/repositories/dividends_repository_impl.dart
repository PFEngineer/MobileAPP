import '../../domain/entities/dividend.dart';
import '../../domain/repositories/dividends_repository.dart';
import '../datasources/dividends_local_data_source.dart';

/// Data-layer implementation of [DividendsRepository], backed by fixtures.
class DividendsRepositoryImpl implements DividendsRepository {
  const DividendsRepositoryImpl(this._dataSource);

  final DividendsLocalDataSource _dataSource;

  @override
  Future<List<DividendPayment>> getUpcomingPayments() =>
      _dataSource.fetchUpcomingPayments();

  @override
  Future<MonthlyDividends> getMonthlyReceived() =>
      _dataSource.fetchMonthlyReceived();
}
