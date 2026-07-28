import 'package:flutter/material.dart';

import 'package:design_system/design_system.dart';

import '../../../../core/format/brl.dart';
import '../../domain/entities/dashboard_stats.dart';

/// Stats card from Figma (node 64:14): 2×2 grid of profit and dividend
/// figures, tappable rows route to Evolução / Dividendos.
class StatsCard extends StatelessWidget {
  const StatsCard({
    required this.stats,
    this.onProfitTap,
    this.onDividendsTap,
    super.key,
  });

  final DashboardStats stats;
  final VoidCallback? onProfitTap;
  final VoidCallback? onDividendsTap;

  @override
  Widget build(BuildContext context) {
    return DsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: onProfitTap,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _StatCell(
                    label: 'Rentabilidade (Mês)',
                    value: '+${Brl.format(stats.profitMonth)}',
                    delta: '↑ ${Brl.percent(stats.profitMonthPercent)}',
                  ),
                ),
                const SizedBox(width: DsSpacing.md),
                Expanded(
                  child: _StatCell(
                    label: 'Rentabilidade (Ano)',
                    value: '+${Brl.format(stats.profitYear)}',
                    delta: '↑ ${Brl.percent(stats.profitYearPercent)}',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: DsSpacing.lg),
          InkWell(
            onTap: onDividendsTap,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: _StatCell(
                    label: 'Dividendos (Mês)',
                    value: Brl.format(stats.dividendsMonth),
                  ),
                ),
                const SizedBox(width: DsSpacing.md),
                Expanded(
                  child: _StatCell(
                    label: 'Dividendos (Ano)',
                    value: Brl.format(stats.dividendsYear),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCell extends StatelessWidget {
  const _StatCell({required this.label, required this.value, this.delta});

  final String label;
  final String value;
  final String? delta;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: DsTypography.labelMedium.copyWith(
            fontWeight: DsTypography.regular,
            color: ds.textSecondary,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: DsTypography.bodyLarge.copyWith(
            fontSize: 17,
            fontWeight: DsTypography.bold,
            color: ds.textPrimary,
          ),
        ),
        if (delta != null) ...<Widget>[
          const SizedBox(height: 3),
          Text(
            delta!,
            style: DsTypography.labelMedium.copyWith(color: ds.success),
          ),
        ],
      ],
    );
  }
}
