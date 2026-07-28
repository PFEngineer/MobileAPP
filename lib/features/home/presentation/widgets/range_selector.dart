import 'package:flutter/material.dart';

import 'package:design_system/design_system.dart';

import '../../domain/entities/portfolio_summary.dart';

/// Period chips from the Figma hero (node 63:29): pill chips, selected one
/// on a white pill with purple text, the rest transparent with white text.
class RangeSelector extends StatelessWidget {
  const RangeSelector({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final ChartRange selected;
  final ValueChanged<ChartRange> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          for (final ChartRange range in ChartRange.values) ...<Widget>[
            if (range != ChartRange.values.first)
              const SizedBox(width: DsSpacing.sm),
            _RangeChip(
              label: range.label,
              isSelected: range == selected,
              onTap: () => onSelected(range),
            ),
          ],
        ],
      ),
    );
  }
}

class _RangeChip extends StatelessWidget {
  const _RangeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? DsColors.neutral0 : Colors.transparent,
      borderRadius: DsRadius.fullAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: DsRadius.fullAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 6,
          ),
          child: Text(
            label,
            style: DsTypography.labelMedium.copyWith(
              fontWeight: DsTypography.semiBold,
              color: isSelected
                  ? DsColors.purple600
                  : DsColors.neutral0.withValues(alpha: 0.85),
            ),
          ),
        ),
      ),
    );
  }
}
