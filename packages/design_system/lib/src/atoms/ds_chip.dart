import 'package:flutter/material.dart';

import '../tokens/ds_radius.dart';
import '../tokens/ds_spacing.dart';
import '../tokens/ds_typography.dart';
import '../theme/ds_theme_extension.dart';

/// Chip — Figma `Chip`. Interactive filter/choice chip with a [selected]
/// state; optional [onDeleted] renders a trailing remove affordance.
class DsChip extends StatelessWidget {
  const DsChip({
    required this.label,
    this.selected = false,
    this.onSelected,
    this.onDeleted,
    this.icon,
    super.key,
  });

  final String label;
  final bool selected;
  final ValueChanged<bool>? onSelected;
  final VoidCallback? onDeleted;
  final IconData? icon;

  bool get _enabled => onSelected != null;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    final Color bg = selected ? ds.primarySubtle : ds.surface;
    final Color fg = selected ? ds.primaryPressed : ds.textSecondary;
    final Color borderColor = selected ? ds.primary : ds.border;

    return Material(
      color: bg,
      shape: RoundedRectangleBorder(
        borderRadius: DsRadius.fullAll,
        side: BorderSide(color: borderColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _enabled ? () => onSelected!(!selected) : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DsSpacing.md,
            vertical: DsSpacing.sm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (icon != null) ...<Widget>[
                Icon(icon, size: 16, color: fg),
                const SizedBox(width: DsSpacing.xs),
              ],
              Text(
                label,
                style: DsTypography.labelMedium.copyWith(
                  color: fg,
                  fontWeight: DsTypography.medium,
                ),
              ),
              if (onDeleted != null) ...<Widget>[
                const SizedBox(width: DsSpacing.xs),
                GestureDetector(
                  onTap: onDeleted,
                  child: Icon(Icons.close, size: 16, color: fg),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
