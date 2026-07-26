import 'package:flutter/material.dart';

import '../tokens/ds_color_scheme.dart';
import '../tokens/ds_typography.dart';
import '../theme/ds_theme_extension.dart';

/// Avatar size — Figma `Avatar`.
enum DsAvatarSize { sm, md, lg, xl }

/// Avatar — shows a network [imageUrl] when provided, otherwise the [initials]
/// on a subtle brand background. An optional [showStatus] dot marks presence.
class DsAvatar extends StatelessWidget {
  const DsAvatar({
    this.imageUrl,
    this.initials,
    this.size = DsAvatarSize.md,
    this.showStatus = false,
    this.statusColor,
    super.key,
  });

  final String? imageUrl;
  final String? initials;
  final DsAvatarSize size;
  final bool showStatus;
  final Color? statusColor;

  double get _diameter => switch (size) {
        DsAvatarSize.sm => 32,
        DsAvatarSize.md => 40,
        DsAvatarSize.lg => 56,
        DsAvatarSize.xl => 72,
      };

  double get _fontSize => switch (size) {
        DsAvatarSize.sm => 12,
        DsAvatarSize.md => 14,
        DsAvatarSize.lg => 18,
        DsAvatarSize.xl => 24,
      };

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    final Widget circle = Container(
      width: _diameter,
      height: _diameter,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: ds.primarySubtle,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: imageUrl != null
          ? Image.network(
              imageUrl!,
              width: _diameter,
              height: _diameter,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => _initials(ds),
            )
          : _initials(ds),
    );

    if (!showStatus) return circle;

    final double dot = _diameter * 0.28;
    return SizedBox(
      width: _diameter,
      height: _diameter,
      child: Stack(
        children: <Widget>[
          circle,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: dot,
              height: dot,
              decoration: BoxDecoration(
                color: statusColor ?? ds.success,
                shape: BoxShape.circle,
                border: Border.all(color: ds.surface, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _initials(DsColorScheme ds) => Text(
        (initials ?? '?').toUpperCase(),
        style: DsTypography.labelMedium.copyWith(
          fontSize: _fontSize,
          fontWeight: DsTypography.semiBold,
          color: ds.onSecondary,
        ),
      );
}
