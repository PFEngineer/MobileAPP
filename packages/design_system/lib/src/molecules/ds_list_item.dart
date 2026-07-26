import 'package:flutter/material.dart';

import '../tokens/ds_radius.dart';
import '../tokens/ds_spacing.dart';
import '../tokens/ds_typography.dart';
import '../theme/ds_theme_extension.dart';

/// List item — Figma `List Item`. A row with optional [leading], a [title],
/// optional [subtitle], and optional [trailing]; tappable via [onTap].
class DsListItem extends StatelessWidget {
  const DsListItem({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: DsRadius.mdAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: DsSpacing.lg,
            vertical: DsSpacing.md,
          ),
          child: Row(
            children: <Widget>[
              if (leading != null) ...<Widget>[
                leading!,
                const SizedBox(width: DsSpacing.md),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      style: DsTypography.bodyMedium.copyWith(
                        color: ds.textPrimary,
                        fontWeight: DsTypography.medium,
                      ),
                    ),
                    if (subtitle != null) ...<Widget>[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: DsTypography.caption.copyWith(
                          color: ds.textTertiary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) ...<Widget>[
                const SizedBox(width: DsSpacing.md),
                trailing!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
