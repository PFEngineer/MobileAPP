import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('tokens', () {
    test('primitive palette matches Figma foundations', () {
      expect(DsColors.purple500, const Color(0xFF8B5CF6));
      expect(DsColors.neutral900, const Color(0xFF111827));
      expect(DsColors.green500, const Color(0xFF22C55E));
    });

    test('spacing follows the 4px base scale', () {
      expect(DsSpacing.xs, 4);
      expect(DsSpacing.md, 12);
      expect(DsSpacing.xl8, 96);
    });

    test('typography uses Inter with the documented sizes', () {
      expect(DsTypography.fontFamily, 'Inter');
      expect(DsTypography.displayXl.fontSize, 40);
      expect(DsTypography.caption.fontSize, 11);
    });
  });

  group('theme', () {
    test('light theme carries the DS color extension', () {
      final theme = DsTheme.light();
      final ext = theme.extension<DsThemeExtension>();
      expect(ext, isNotNull);
      expect(ext!.colors.primary, DsColors.purple500);
      expect(ext.colors.brightness, Brightness.light);
    });

    testWidgets('context.dsColors falls back to light without a DS theme',
        (tester) async {
      late DsColorScheme captured;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              captured = context.dsColors;
              return const SizedBox();
            },
          ),
        ),
      );
      expect(captured.primary, DsColors.purple500);
    });
  });

  group('components render', () {
    testWidgets('button variants build without error', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: DsTheme.light(),
          home: Scaffold(
            body: Column(
              children: <Widget>[
                DsButton(label: 'A', onPressed: () {}),
                const DsButton(label: 'Loading', onPressed: null, isLoading: true),
                DsButton(
                  label: 'Outline',
                  variant: DsButtonVariant.outline,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );
      expect(find.text('A'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('tag and badge build', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: DsTheme.light(),
          home: const Scaffold(
            body: Column(
              children: <Widget>[
                DsTag(label: 'Novo', tone: DsTone.success),
                DsBadge.count(5),
              ],
            ),
          ),
        ),
      );
      expect(find.text('Novo'), findsOneWidget);
      expect(find.text('5'), findsOneWidget);
    });
  });
}
