import 'package:flutter/material.dart';

import 'package:mobile_app/core/analytics/analytics_service.dart';
import 'package:design_system/design_system.dart';

import '../../../../core/format/brl.dart';
import '../../../../core/widgets/line_area_chart.dart';
import '../../domain/entities/evolution_summary.dart';
import '../viewmodels/evolution_view_model.dart';

/// 05. Evolução — Figma node 73:270. Pushed screen with a back chevron.
class EvolutionPage extends StatefulWidget {
  const EvolutionPage({required this.viewModel, super.key});

  final EvolutionViewModel viewModel;

  @override
  State<EvolutionPage> createState() => _EvolutionPageState();
}

class _EvolutionPageState extends State<EvolutionPage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.trackScreenView('Evolução');
    widget.viewModel.load();
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, _) {
            final vm = widget.viewModel;
            final EvolutionSummary? summary = vm.summary;
            return ListView(
              padding: const EdgeInsets.fromLTRB(
                DsSpacing.lg,
                DsSpacing.sm,
                DsSpacing.lg,
                DsSpacing.xl2,
              ),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () => Navigator.of(context).maybePop(),
                      child: Padding(
                        padding: const EdgeInsets.all(DsSpacing.xs),
                        child: Icon(
                          Icons.chevron_left,
                          size: 28,
                          color: ds.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: DsSpacing.sm),
                    Text(
                      'Evolução patrimonial',
                      style: DsTypography.heading3.copyWith(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: DsSpacing.lg),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: DsSpacing.xs),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Patrimônio',
                        style: DsTypography.bodyMedium.copyWith(
                          fontSize: 13,
                          color: ds.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        summary == null ? '' : Brl.format(summary.total),
                        style: DsTypography.heading1.copyWith(
                          fontSize: 28,
                          fontWeight: DsTypography.bold,
                        ),
                      ),
                      const SizedBox(height: DsSpacing.xs),
                      if (summary != null)
                        Text(
                          '+ ${Brl.format(summary.periodChange)} '
                          '(${Brl.percent(summary.periodChangePercent)}) '
                          '${summary.periodLabel}',
                          style: DsTypography.bodyMedium.copyWith(
                            fontSize: 13,
                            fontWeight: DsTypography.medium,
                            color: ds.success,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: DsSpacing.xl),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <Widget>[
                      for (final EvolutionRange range
                          in EvolutionRange.values) ...<Widget>[
                        if (range != EvolutionRange.values.first)
                          const SizedBox(width: DsSpacing.sm),
                        _RangeChip(
                          label: range.label,
                          isSelected: range == vm.selectedRange,
                          onTap: () {
                            AnalyticsService.trackClick(
                              'Evolução ${range.label}',
                            );
                            vm.selectRange(range);
                          },
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: DsSpacing.lg),
                if (summary != null) _EvolutionChartCard(summary: summary),
                const SizedBox(height: DsSpacing.lg),
                if (summary != null)
                  DsCard(
                    child: Column(
                      children: <Widget>[
                        _SummaryRow(
                          label: 'Patrimônio inicial',
                          value: Brl.format(summary.initialValue),
                        ),
                        const SizedBox(height: 14),
                        _SummaryRow(
                          label: 'Aportes',
                          value: Brl.format(summary.contributions),
                        ),
                        const SizedBox(height: 14),
                        _SummaryRow(
                          label: 'Rentabilidade',
                          value: '+ ${Brl.format(summary.profit)}',
                          valueColor: ds.success,
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Light-purple selected chip — Figma 73:294 (unlike the hero's white chip).
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
      color: isSelected ? DsColors.purple100 : Colors.transparent,
      borderRadius: DsRadius.fullAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: DsRadius.fullAll,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: Text(
            label,
            style: DsTypography.labelMedium.copyWith(
              fontWeight: DsTypography.semiBold,
              color: isSelected
                  ? DsColors.purple700
                  : context.dsColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

/// Chart card with axis labels (Figma 73:300).
class _EvolutionChartCard extends StatelessWidget {
  const _EvolutionChartCard({required this.summary});

  final EvolutionSummary summary;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;
    final TextStyle axisStyle = DsTypography.caption.copyWith(
      fontSize: 10,
      color: ds.textTertiary,
    );

    return DsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 116,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('150k', style: axisStyle),
                    Text('100k', style: axisStyle),
                    Text('50k', style: axisStyle),
                    Text('0', style: axisStyle),
                  ],
                ),
              ),
              const SizedBox(width: DsSpacing.md),
              Expanded(
                child: LineAreaChart(
                  points: summary.chartPoints,
                  lineColor: DsColors.purple600,
                  fillColor: DsColors.purple100,
                  height: 116,
                  strokeWidth: 2.5,
                  // Figma: polyline spans 102px of the 116px chart box.
                  lineBoxHeight: 102,
                ),
              ),
            ],
          ),
          const SizedBox(height: DsSpacing.sm),
          Padding(
            padding: const EdgeInsets.only(left: 36),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                for (final String label in summary.monthLabels)
                  Text(label, style: axisStyle),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          label,
          style: DsTypography.bodyMedium.copyWith(
            fontSize: 13,
            color: ds.textSecondary,
          ),
        ),
        Text(
          value,
          style: DsTypography.bodyMedium.copyWith(
            fontWeight: DsTypography.semiBold,
            color: valueColor ?? ds.textPrimary,
          ),
        ),
      ],
    );
  }
}
