import 'package:flutter/material.dart';

import '../atoms/ds_button.dart';
import '../tokens/ds_icons.dart';
import '../tokens/ds_spacing.dart';
import '../tokens/ds_typography.dart';
import '../theme/ds_theme_extension.dart';

/// Empty State — Figma `18. Empty State`.
///
/// Full-width content section shown when a list, filter or product tab has no
/// results (e.g. Carteira with no BDRs). Composes an illustration, a title,
/// an optional description and up to two actions — a primary [DsButton]
/// (outline) and a secondary text button — all driven by design tokens.
///
/// The default illustration is asset-free (built from Material glyphs so the
/// package ships no SVGs); pass [illustration] to supply a custom one, or
/// [icon] to change the glyph inside the default.
class DsEmptyState extends StatelessWidget {
  const DsEmptyState({
    required this.title,
    this.description,
    this.illustration,
    this.icon = Icons.inventory_2_outlined,
    this.primaryActionLabel,
    this.onPrimaryAction,
    this.primaryActionIcon = DsIcons.plusCircle,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.padding = const EdgeInsets.symmetric(
      horizontal: DsSpacing.xl2,
      vertical: DsSpacing.xl3,
    ),
    super.key,
  });

  /// Headline, e.g. "Nenhum BDR encontrado".
  final String title;

  /// Supporting sentence explaining the empty result. Hidden when null.
  final String? description;

  /// Custom illustration. When null, a default brand illustration built from
  /// [icon] is used.
  final Widget? illustration;

  /// Glyph shown inside the default illustration. Ignored when [illustration]
  /// is provided.
  final IconData icon;

  /// Primary action (outline button). Rendered only when both the label and
  /// [onPrimaryAction] are non-null.
  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;

  /// Leading icon of the primary action.
  final IconData primaryActionIcon;

  /// Secondary action (text button), e.g. "Limpar filtros". Rendered only when
  /// both the label and [onSecondaryAction] are non-null.
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;

  /// Outer padding around the centered content.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;
    final bool hasPrimary =
        primaryActionLabel != null && onPrimaryAction != null;
    final bool hasSecondary =
        secondaryActionLabel != null && onSecondaryAction != null;

    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          illustration ?? _DefaultIllustration(icon: icon),
          const SizedBox(height: DsSpacing.xl),
          Text(
            title,
            textAlign: TextAlign.center,
            style: DsTypography.heading3.copyWith(color: ds.textPrimary),
          ),
          if (description != null) ...<Widget>[
            const SizedBox(height: DsSpacing.sm),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: Text(
                description!,
                textAlign: TextAlign.center,
                style: DsTypography.bodyMedium.copyWith(color: ds.textSecondary),
              ),
            ),
          ],
          if (hasPrimary) ...<Widget>[
            const SizedBox(height: DsSpacing.xl2),
            DsButton(
              label: primaryActionLabel!,
              onPressed: onPrimaryAction,
              variant: DsButtonVariant.outline,
              size: DsButtonSize.large,
              icon: primaryActionIcon,
            ),
          ],
          if (hasSecondary) ...<Widget>[
            SizedBox(height: hasPrimary ? DsSpacing.sm : DsSpacing.xl2),
            DsButton(
              label: secondaryActionLabel!,
              onPressed: onSecondaryAction,
              variant: DsButtonVariant.text,
            ),
          ],
        ],
      ),
    );
  }
}

/// Brand illustration for [DsEmptyState]: a soft primary circle holding a box
/// glyph, with a small paper plane escaping the top-right — echoing the Figma
/// artwork without shipping any SVG asset.
class _DefaultIllustration extends StatelessWidget {
  const _DefaultIllustration({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return SizedBox(
      width: 160,
      height: 160,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: ds.primarySubtle,
              shape: BoxShape.circle,
            ),
          ),
          Icon(icon, size: 72, color: ds.primary),
          Positioned(
            top: 16,
            right: 20,
            child: Transform.rotate(
              angle: -0.5,
              child: Icon(Icons.send, size: 28, color: ds.primaryHover),
            ),
          ),
        ],
      ),
    );
  }
}
