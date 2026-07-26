import 'package:flutter/material.dart';

import '../tokens/ds_spacing.dart';
import '../tokens/ds_typography.dart';
import '../theme/ds_theme_extension.dart';

/// Tabs — Figma `Tabs`. Underline-style segmented control driven by
/// [selectedIndex]; reports taps through [onChanged].
class DsTabs extends StatelessWidget {
  const DsTabs({
    required this.tabs,
    required this.selectedIndex,
    required this.onChanged,
    super.key,
  });

  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: ds.border)),
      ),
      child: Row(
        children: List<Widget>.generate(tabs.length, (i) {
          final bool active = i == selectedIndex;
          return Expanded(
            child: InkWell(
              onTap: () => onChanged(i),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: DsSpacing.md),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: active ? ds.primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  tabs[i],
                  textAlign: TextAlign.center,
                  style: DsTypography.bodyMedium.copyWith(
                    color: active ? ds.primary : ds.textSecondary,
                    fontWeight:
                        active ? DsTypography.semiBold : DsTypography.regular,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
