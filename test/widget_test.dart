import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_app/main.dart';

void main() {
  testWidgets('App boots into the design system gallery', (tester) async {
    await tester.pumpWidget(const MobileApp());

    // App bar title from the gallery is present.
    expect(find.text('Design System'), findsOneWidget);

    // Tabs render and default to the atoms tab.
    expect(find.text('Átomos'), findsOneWidget);
    expect(find.text('Primário'), findsWidgets);
  });

  testWidgets('Switching tabs renders molecules and organisms', (tester) async {
    await tester.pumpWidget(const MobileApp());

    await tester.tap(find.text('Moléculas'));
    await tester.pumpAndSettle();
    expect(find.text('Card'), findsOneWidget);

    await tester.tap(find.text('Organismos'));
    await tester.pumpAndSettle();
    expect(find.text('Top App Bar'), findsOneWidget);
  });
}
