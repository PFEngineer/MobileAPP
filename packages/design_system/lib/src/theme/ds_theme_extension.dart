import 'package:flutter/material.dart';

import '../tokens/ds_color_scheme.dart';

/// Carries the semantic [DsColorScheme] through Flutter's `ThemeData` so any
/// widget can read design-system colors via `Theme.of(context)` (or the
/// [DsThemeX] helpers below) without importing app state.
@immutable
class DsThemeExtension extends ThemeExtension<DsThemeExtension> {
  const DsThemeExtension({required this.colors});

  final DsColorScheme colors;

  @override
  DsThemeExtension copyWith({DsColorScheme? colors}) =>
      DsThemeExtension(colors: colors ?? this.colors);

  @override
  DsThemeExtension lerp(ThemeExtension<DsThemeExtension>? other, double t) {
    if (other is! DsThemeExtension) return this;
    return DsThemeExtension(colors: DsColorScheme.lerp(colors, other.colors, t));
  }
}

/// Ergonomic access to design-system tokens from a [BuildContext].
extension DsThemeX on BuildContext {
  /// Semantic colors for the active theme.
  ///
  /// Falls back to the light scheme if the extension is missing, so widgets
  /// never crash when dropped into a non-DS `MaterialApp`.
  DsColorScheme get dsColors =>
      Theme.of(this).extension<DsThemeExtension>()?.colors ??
      DsColorScheme.light();
}
