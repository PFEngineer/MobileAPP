import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_app/main.dart';

void main() {
  testWidgets('Home renders with the design system', (tester) async {
    await tester.pumpWidget(const MobileApp());

    expect(find.text('Turbi'), findsOneWidget);
    expect(find.text('Bem-vindo'), findsOneWidget);
    expect(find.text('Começar'), findsOneWidget);
  });
}
