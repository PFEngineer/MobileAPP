import 'package:flutter/foundation.dart';

import '../../domain/entities/dividend.dart';
import '../../domain/usecases/get_dividends.dart';

/// Presentation state for the Dividendos screen (MVVM).
class DividendsViewModel extends ChangeNotifier {
  DividendsViewModel({
    required GetUpcomingPayments getUpcomingPayments,
    required GetMonthlyReceived getMonthlyReceived,
  })  : _getUpcomingPayments = getUpcomingPayments,
        _getMonthlyReceived = getMonthlyReceived;

  final GetUpcomingPayments _getUpcomingPayments;
  final GetMonthlyReceived _getMonthlyReceived;

  static const List<String> tabs = <String>['Calendário', 'Histórico', 'Resumo'];

  List<DividendPayment> _payments = const <DividendPayment>[];
  MonthlyDividends? _received;
  int _tabIndex = 0;
  bool _isLoading = false;

  List<DividendPayment> get payments => _payments;
  MonthlyDividends? get received => _received;
  int get tabIndex => _tabIndex;
  bool get isLoading => _isLoading;

  Future<void> load() async {
    _isLoading = true;
    notifyListeners();
    try {
      final List<Object> results = await Future.wait(<Future<Object>>[
        _getUpcomingPayments(),
        _getMonthlyReceived(),
      ]);
      _payments = (results[0] as List<DividendPayment>);
      _received = results[1] as MonthlyDividends;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectTab(int index) {
    if (index == _tabIndex) return;
    _tabIndex = index;
    notifyListeners();
  }
}
