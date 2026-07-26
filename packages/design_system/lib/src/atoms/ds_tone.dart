import 'dart:ui';

import '../tokens/ds_color_scheme.dart';

/// Semantic tone shared by tags, badges and status indicators.
enum DsTone { neutral, primary, success, danger, warning, info }

/// A tone resolved against the active [DsColorScheme] into a solid color, a
/// subtle background, and the foreground to sit on that background.
class DsToneColors {
  const DsToneColors({
    required this.solid,
    required this.subtle,
    required this.onSolid,
    required this.onSubtle,
  });

  factory DsToneColors.of(DsColorScheme ds, DsTone tone) => switch (tone) {
        DsTone.neutral => DsToneColors(
            solid: ds.textSecondary,
            subtle: ds.surfaceAlt,
            onSolid: ds.textInverse,
            onSubtle: ds.textSecondary,
          ),
        DsTone.primary => DsToneColors(
            solid: ds.primary,
            subtle: ds.primarySubtle,
            onSolid: ds.onPrimary,
            onSubtle: ds.primaryPressed,
          ),
        DsTone.success => DsToneColors(
            solid: ds.success,
            subtle: ds.successSubtle,
            onSolid: ds.onSuccess,
            onSubtle: ds.success,
          ),
        DsTone.danger => DsToneColors(
            solid: ds.danger,
            subtle: ds.dangerSubtle,
            onSolid: ds.onDanger,
            onSubtle: ds.danger,
          ),
        DsTone.warning => DsToneColors(
            solid: ds.warning,
            subtle: ds.warningSubtle,
            onSolid: ds.onWarning,
            onSubtle: ds.warning,
          ),
        DsTone.info => DsToneColors(
            solid: ds.info,
            subtle: ds.infoSubtle,
            onSolid: ds.onInfo,
            onSubtle: ds.info,
          ),
      };

  final Color solid;
  final Color subtle;
  final Color onSolid;
  final Color onSubtle;
}
