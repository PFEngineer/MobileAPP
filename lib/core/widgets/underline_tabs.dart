import 'package:flutter/material.dart';

import 'package:design_system/design_system.dart';

/// Scrollable underline tabs — Figma `Tabs` (50:19) as used in Carteira and
/// Dividendos: left-aligned, 24px gap, 2px brand underline on the active tab.
/// (The DS `DsTabs` stretches tabs to fill the width; these designs need the
/// scrollable left-aligned variant.)
class UnderlineTabs extends StatelessWidget {
  const UnderlineTabs({
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

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          for (int i = 0; i < tabs.length; i++) ...<Widget>[
            if (i > 0) const SizedBox(width: DsSpacing.xl2),
            InkWell(
              onTap: () => onChanged(i),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      tabs[i],
                      style: DsTypography.bodyMedium.copyWith(
                        fontWeight: i == selectedIndex
                            ? DsTypography.semiBold
                            : DsTypography.medium,
                        color: i == selectedIndex
                            ? ds.primary
                            : ds.textSecondary,
                      ),
                    ),
                    const SizedBox(height: DsSpacing.sm),
                    Container(
                      height: 2,
                      color:
                          i == selectedIndex ? ds.primary : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
