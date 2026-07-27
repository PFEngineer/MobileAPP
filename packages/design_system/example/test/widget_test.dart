import 'package:flutter_test/flutter_test.dart';

import 'package:design_system_example/main.dart';

void main() {
  testWidgets('Gallery lists atom entries as buttons', (tester) async {
    await tester.pumpWidget(const DesignSystemExampleApp());

    expect(find.text('Design System'), findsOneWidget);
    expect(find.text('Átomos'), findsOneWidget);
    // Entries are rendered as list buttons.
    expect(find.text('Botões — estilos'), findsOneWidget);
    expect(find.text('Seleção'), findsOneWidget);
  });

  testWidgets('Tapping an entry opens its detail page', (tester) async {
    await tester.pumpWidget(const DesignSystemExampleApp());

    await tester.tap(find.text('Botões — estilos'));
    await tester.pumpAndSettle();

    // Detail page shows the button-styles demo.
    expect(find.text('Primário'), findsOneWidget);
    expect(find.text('Destrutivo'), findsOneWidget);
  });

  testWidgets('Molecules tab lists its entries', (tester) async {
    await tester.pumpWidget(const DesignSystemExampleApp());

    await tester.tap(find.text('Moléculas'));
    await tester.pumpAndSettle();

    expect(find.text('Card'), findsOneWidget);
    expect(find.text('List Item'), findsOneWidget);
  });
}
