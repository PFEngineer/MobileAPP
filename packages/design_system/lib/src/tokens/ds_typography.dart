import 'package:flutter/widgets.dart';

/// Type scale — Figma `02. Tipografia`. Family is Inter with the size /
/// line-height / weight pairs defined in the foundations.
///
/// The Inter font files are NOT bundled here to keep the package asset-free and
/// self-contained; when absent, Flutter falls back to the platform font. To
/// render Inter exactly, add the Inter `.ttf` files as assets to this package
/// (family "Inter") or provide them from the host app.
abstract final class DsTypography {
  const DsTypography._();

  static const String fontFamily = 'Inter';

  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;

  static const TextStyle displayXl = TextStyle(
    fontFamily: fontFamily,
    fontSize: 40,
    height: 48 / 40,
    fontWeight: bold,
  );

  static const TextStyle heading1 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 30,
    height: 40 / 30,
    fontWeight: semiBold,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    height: 32 / 24,
    fontWeight: semiBold,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: semiBold,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: regular,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: regular,
  );

  static const TextStyle labelMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 16 / 12,
    fontWeight: medium,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontFamily,
    fontSize: 11,
    height: 16 / 11,
    fontWeight: regular,
  );
}
