import 'package:flutter/widgets.dart';

import '../tokens/ds_radius.dart';
import '../tokens/ds_typography.dart';
import '../theme/ds_theme_extension.dart';
import 'ds_tone.dart';

/// Badge — Figma `Badge`. A small count or dot indicator.
///
/// Standalone by default; pass a [child] to anchor the badge on its top-right
/// corner (e.g. over an icon button).
class DsBadge extends StatelessWidget {
  const DsBadge.count(
    this.count, {
    this.tone = DsTone.danger,
    this.maxCount = 99,
    this.child,
    super.key,
  }) : _isDot = false;

  const DsBadge.dot({
    this.tone = DsTone.danger,
    this.child,
    super.key,
  })  : _isDot = true,
        count = 0,
        maxCount = 0;

  final int count;
  final int maxCount;
  final DsTone tone;
  final bool _isDot;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final colors = DsToneColors.of(context.dsColors, tone);
    final ds = context.dsColors;

    if (_isDot) {
      final Widget dot = Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: colors.solid,
          shape: BoxShape.circle,
          border: Border.all(color: ds.surface, width: 2),
        ),
      );
      return _anchor(dot);
    }

    final String text = count > maxCount ? '$maxCount+' : '$count';
    final Widget pill = Container(
      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.solid,
        borderRadius: DsRadius.fullAll,
        border: child != null ? Border.all(color: ds.surface, width: 2) : null,
      ),
      child: Text(
        text,
        style: DsTypography.caption.copyWith(
          color: colors.onSolid,
          fontWeight: DsTypography.semiBold,
          height: 1,
        ),
      ),
    );
    return _anchor(pill);
  }

  Widget _anchor(Widget badge) {
    if (child == null) return badge;
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        child!,
        Positioned(top: -6, right: -6, child: badge),
      ],
    );
  }
}
