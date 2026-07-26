import 'dart:ui';

/// Primitive color palette.
///
/// These are the raw, context-free color values from the Figma
/// `📐 Foundations › 01. Cores` page (collection `Primitives`). They are the
/// lowest layer of the token system: never reference them directly from a
/// widget — go through [DsColorScheme]'s semantic roles instead, so themes and
/// future dark mode stay swappable.
abstract final class DsColors {
  const DsColors._();

  // Purple — brand primary ramp.
  static const Color purple50 = Color(0xFFF5F3FF);
  static const Color purple100 = Color(0xFFEDE9FE);
  static const Color purple200 = Color(0xFFDDD6FE);
  static const Color purple300 = Color(0xFFC4B5FD);
  static const Color purple400 = Color(0xFFA78BFA);
  static const Color purple500 = Color(0xFF8B5CF6);
  static const Color purple600 = Color(0xFF7C3AED);
  static const Color purple700 = Color(0xFF6D28D9);
  static const Color purple800 = Color(0xFF5B21B6);
  static const Color purple900 = Color(0xFF4C1D95);

  // Neutral — text, surfaces, borders.
  static const Color neutral0 = Color(0xFFFFFFFF);
  static const Color neutral50 = Color(0xFFF9FAFB);
  static const Color neutral100 = Color(0xFFF3F4F6);
  static const Color neutral200 = Color(0xFFE5E7EB);
  static const Color neutral300 = Color(0xFFD1D5DB);
  static const Color neutral400 = Color(0xFF9CA3AF);
  static const Color neutral500 = Color(0xFF6B7280);
  static const Color neutral600 = Color(0xFF4B5563);
  static const Color neutral700 = Color(0xFF374151);
  static const Color neutral800 = Color(0xFF1F2937);
  static const Color neutral900 = Color(0xFF111827);

  // Semantic ramps (single tone in the source; kept as primitives).
  static const Color green500 = Color(0xFF22C55E);
  static const Color red500 = Color(0xFFEF4444);
  static const Color orange500 = Color(0xFFF97316);
  static const Color blue500 = Color(0xFF3B82F6);
}
