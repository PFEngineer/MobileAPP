import '../../domain/entities/dividend.dart';

/// In-memory fixture source — exact values from Figma 04. Dividendos.
class DividendsLocalDataSource {
  const DividendsLocalDataSource();

  Future<List<DividendPayment>> fetchUpcomingPayments() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return const <DividendPayment>[
      DividendPayment(
        ticker: 'ITSA4',
        name: 'Itaúsa',
        initials: 'IT',
        dateLabel: '28/06',
        amount: 120.00,
        daysLeft: 6,
      ),
      DividendPayment(
        ticker: 'BBAS3',
        name: 'Banco do Brasil',
        initials: 'BB',
        dateLabel: '30/06',
        amount: 87.50,
        daysLeft: 8,
      ),
      DividendPayment(
        ticker: 'XPML11',
        name: 'XP Malls',
        initials: 'XP',
        dateLabel: '05/07',
        amount: 150.00,
        daysLeft: 13,
      ),
      DividendPayment(
        ticker: 'PETR4',
        name: 'Petrobras',
        initials: 'PE',
        dateLabel: '15/07',
        amount: 210.00,
        daysLeft: 23,
      ),
    ];
  }

  Future<MonthlyDividends> fetchMonthlyReceived() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    // Bar heights from the Figma `Gráfico` component (51:9), normalized to
    // its tallest bar (54px).
    return const MonthlyDividends(
      monthLabel: 'junho',
      total: 1250.00,
      deltaLabel: '+18,42% vs Maio',
      bars: <double>[28 / 54, 44 / 54, 22 / 54, 1, 36 / 54],
      highlightedBar: 3,
    );
  }
}
