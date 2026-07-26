import 'package:flutter/material.dart';

import '../tokens/ds_radius.dart';
import '../theme/ds_theme_extension.dart';

/// Linear progress bar — Figma `Progress Linear`. Determinate when [value] is
/// in 0..1, indeterminate when null.
class DsLinearProgress extends StatelessWidget {
  const DsLinearProgress({
    this.value,
    this.height = 8,
    super.key,
  });

  final double? value;
  final double height;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;
    return ClipRRect(
      borderRadius: DsRadius.fullAll,
      child: LinearProgressIndicator(
        value: value,
        minHeight: height,
        backgroundColor: ds.surfaceAlt,
        valueColor: AlwaysStoppedAnimation<Color>(ds.primary),
      ),
    );
  }
}

/// Circular progress — Figma `Progress Circular`. Determinate when [value] is
/// in 0..1, indeterminate when null.
class DsCircularProgress extends StatelessWidget {
  const DsCircularProgress({
    this.value,
    this.size = 40,
    this.strokeWidth = 4,
    super.key,
  });

  final double? value;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: strokeWidth,
        backgroundColor: ds.surfaceAlt,
        valueColor: AlwaysStoppedAnimation<Color>(ds.primary),
      ),
    );
  }
}
