import 'package:flutter/material.dart';

import '../tokens/ds_spacing.dart';
import '../tokens/ds_typography.dart';
import '../theme/ds_theme_extension.dart';

/// A single destination in a [DsBottomNavigation].
class DsBottomNavItem {
  const DsBottomNavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

/// Bottom navigation — Figma `Bottom Navigation`. Flat bar with a top hairline
/// border; the active destination is brand-colored.
class DsBottomNavigation extends StatelessWidget {
  const DsBottomNavigation({
    required this.items,
    required this.currentIndex,
    required this.onChanged,
    super.key,
  });

  final List<DsBottomNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Container(
      decoration: BoxDecoration(
        color: ds.surface,
        border: Border(top: BorderSide(color: ds.border)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: List<Widget>.generate(items.length, (i) {
              final DsBottomNavItem item = items[i];
              final bool active = i == currentIndex;
              final Color color = active ? ds.primary : ds.textTertiary;
              return Expanded(
                child: InkWell(
                  onTap: () => onChanged(i),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(item.icon, size: 24, color: color),
                      const SizedBox(height: DsSpacing.xs),
                      Text(
                        item.label,
                        style: DsTypography.caption.copyWith(
                          color: color,
                          fontWeight: active
                              ? DsTypography.semiBold
                              : DsTypography.regular,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
