import 'package:mobile_app/core/analytics/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_app/app/di/app_dependencies.dart';
import 'package:mobile_app/app/router/app_router.dart';
import 'package:mobile_app/features/home/domain/entities/portfolio_summary.dart';
import 'package:mobile_app/main.dart';

void main() {
  setUpAll(AnalyticsService.disableForTesting);

  Widget buildApp() => MobileApp(router: AppRouter(AppDependencies()));

  /// The app opens on Login; sign in with a valid CPF to reach the shell.
  Future<void> logIn(WidgetTester tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump();
    await tester.enterText(
      find.byType(TextField).first,
      '529.982.247-25',
    );
    await tester.enterText(find.byType(TextField).last, 'secret1');
    await tester.tap(find.text('Entrar'));
    // Auth latency (700ms) + replacement transition + dashboard loads (150ms).
    // pumpAndSettle advances the fake clock through all of them and disposes
    // the login route so its widgets no longer match finders.
    await tester.pumpAndSettle(const Duration(seconds: 2));
  }

  testWidgets('login screen blocks an invalid CPF', (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pump();

    expect(find.text('Bem-vindo de volta! 👋'), findsOneWidget);

    // Invalid CPF + valid password: submit must not navigate; error shows and
    // we stay on the login screen (no dashboard, no pending timers).
    await tester.enterText(find.byType(TextField).first, '111.111.111-11');
    await tester.enterText(find.byType(TextField).last, 'secret1');
    await tester.tap(find.text('Entrar'));
    await tester.pump();

    expect(find.text('CPF inválido'), findsOneWidget);
    expect(find.text('Bem-vindo de volta! 👋'), findsOneWidget);
  });

  testWidgets('Dashboard renders the Figma hero, stats and breakdown',
      (tester) async {
    await logIn(tester);

    expect(find.text('Olá, Paulo 👋'), findsOneWidget);
    expect(find.text('Patrimônio total'), findsOneWidget);
    expect(find.text('R\$ 125.430,50'), findsOneWidget);
    for (final ChartRange range in ChartRange.values) {
      expect(find.text(range.label), findsOneWidget);
    }
    expect(find.text('Rentabilidade (Mês)'), findsOneWidget);
    expect(find.text('+R\$ 18.420,10'), findsOneWidget);
    expect(find.text('Resumo da carteira'), findsOneWidget);
    expect(find.text('Ações 55,6%'), findsOneWidget);
  });

  testWidgets('balance visibility toggle hides the amounts', (tester) async {
    await logIn(tester);

    await tester.tap(find.byIcon(Icons.visibility_outlined));
    await tester.pump();

    expect(find.text('R\$ ••••••'), findsOneWidget);
    expect(find.text('R\$ 125.430,50'), findsNothing);
  });

  testWidgets('bottom navigation switches to Carteira', (tester) async {
    await logIn(tester);

    await tester.tap(find.text('Carteira'));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('PETR4'), findsOneWidget);
    expect(find.text('TESOURO IPCA+ 2035'), findsOneWidget);
  });

  testWidgets('Investir hub reaches Dividendos', (tester) async {
    await logIn(tester);

    await tester.tap(find.text('Investir'));
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Nova operação'), findsOneWidget);

    await tester.tap(find.text('Dividendos'));
    // 1) run the post-frame push, 2) build the route (starts the mock load),
    // 3) let the 150ms fixture timer fire, 4) rebuild with data.
    await tester.pump();
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 600));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Próximos pagamentos'), findsOneWidget);
    expect(find.text('ITSA4'), findsOneWidget);
  });
}
