import 'package:flutter/material.dart';

import '../tokens/ds_elevation.dart';
import '../tokens/ds_radius.dart';
import '../tokens/ds_spacing.dart';
import '../theme/ds_theme_extension.dart';

/// Card — Figma `Cards`. A surface container with DS radius, border and a soft
/// shadow. Becomes tappable when [onTap] is provided.
class DsCard extends StatelessWidget {
  const DsCard({
    required this.child,
    this.padding = const EdgeInsets.all(DsSpacing.lg),
    this.onTap,
    this.elevated = true,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final VoidCallback? onTap;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    final Widget content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: ds.surface,
        borderRadius: DsRadius.lgAll,
        border: Border.all(color: ds.border),
        boxShadow: elevated ? DsElevation.sm : DsElevation.none,
      ),
      child: child,
    );

    if (onTap == null) return content;

    return Material(
      color: Colors.transparent,
      borderRadius: DsRadius.lgAll,
      clipBehavior: Clip.antiAlias,
      child: InkWell(onTap: onTap, child: content),
    );
  }
}
