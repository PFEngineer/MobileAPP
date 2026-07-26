import 'package:flutter/widgets.dart';

import '../tokens/ds_radius.dart';
import '../tokens/ds_spacing.dart';
import '../tokens/ds_typography.dart';
import '../theme/ds_theme_extension.dart';
import 'ds_tone.dart';

/// Tag — Figma `Tag`. A small, non-interactive label carrying a semantic
/// [tone]. Use [solid] for high-emphasis, subtle (default) otherwise.
class DsTag extends StatelessWidget {
  const DsTag({
    required this.label,
    this.tone = DsTone.neutral,
    this.icon,
    this.solid = false,
    super.key,
  });

  final String label;
  final DsTone tone;
  final IconData? icon;
  final bool solid;

  @override
  Widget build(BuildContext context) {
    final colors = DsToneColors.of(context.dsColors, tone);
    final Color bg = solid ? colors.solid : colors.subtle;
    final Color fg = solid ? colors.onSolid : colors.onSubtle;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DsSpacing.sm,
        vertical: 3,
      ),
      decoration: BoxDecoration(color: bg, borderRadius: DsRadius.smAll),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (icon != null) ...<Widget>[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: DsSpacing.xs),
          ],
          Text(
            label,
            style: DsTypography.caption.copyWith(
              color: fg,
              fontWeight: DsTypography.medium,
            ),
          ),
        ],
      ),
    );
  }
}
