import 'package:flutter/material.dart';

import '../tokens/ds_color_scheme.dart';
import '../tokens/ds_typography.dart';
import 'ds_theme_extension.dart';

/// Builds the Material [ThemeData] for the app from design-system tokens.
///
/// Usage:
/// ```dart
/// MaterialApp(theme: DsTheme.light(), ...)
/// ```
abstract final class DsTheme {
  const DsTheme._();

  /// Light theme ("Claro").
  static ThemeData light() => _build(DsColorScheme.light());

  static ThemeData _build(DsColorScheme ds) {
    final ColorScheme material = ColorScheme(
      brightness: ds.brightness,
      primary: ds.primary,
      onPrimary: ds.onPrimary,
      secondary: ds.secondary,
      onSecondary: ds.onSecondary,
      error: ds.danger,
      onError: ds.onDanger,
      surface: ds.surface,
      onSurface: ds.textPrimary,
    );

    final TextTheme textTheme = const TextTheme(
      displayLarge: DsTypography.displayXl,
      headlineLarge: DsTypography.heading1,
      headlineMedium: DsTypography.heading2,
      headlineSmall: DsTypography.heading3,
      bodyLarge: DsTypography.bodyLarge,
      bodyMedium: DsTypography.bodyMedium,
      labelMedium: DsTypography.labelMedium,
      labelSmall: DsTypography.caption,
    ).apply(
      bodyColor: ds.textPrimary,
      displayColor: ds.textPrimary,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: material,
      scaffoldBackgroundColor: ds.background,
      fontFamily: DsTypography.fontFamily,
      textTheme: textTheme,
      extensions: <ThemeExtension<dynamic>>[
        DsThemeExtension(colors: ds),
      ],
    );
  }
}
