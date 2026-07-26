import 'package:flutter_test/flutter_test.dart';

import 'package:design_system_example/main.dart';

void main() {
  testWidgets('Example app boots into the gallery', (tester) async {
    await tester.pumpWidget(const DesignSystemExampleApp());

    expect(find.text('Design System'), findsOneWidget);
    expect(find.text('Átomos'), findsOneWidget);
  });
}
