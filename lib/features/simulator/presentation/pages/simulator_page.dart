import 'package:flutter/material.dart';

import 'package:analytics/analytics.dart';
import 'package:design_system/design_system.dart';

import '../../../../core/format/brl.dart';
import '../../../../core/widgets/line_area_chart.dart';
import '../viewmodels/simulator_view_model.dart';

/// 07. Simulador — Figma node 75:346.
class SimulatorPage extends StatefulWidget {
  const SimulatorPage({required this.viewModel, super.key});

  final SimulatorViewModel viewModel;

  @override
  State<SimulatorPage> createState() => _SimulatorPageState();
}

class _SimulatorPageState extends State<SimulatorPage> {
  late final TextEditingController _contributionController;
  late final TextEditingController _rateController;
  late final TextEditingController _yearsController;

  @override
  void initState() {
    super.initState();
    AnalyticsService.trackScreenView('Simulador');
    final vm = widget.viewModel;
    _contributionController =
        TextEditingController(text: Brl.format(vm.monthlyContribution));
    _rateController = TextEditingController(
      text: '${vm.annualRatePercent.toStringAsFixed(0)}% ao ano',
    );
    _yearsController = TextEditingController(text: '${vm.years} anos');
  }

  @override
  void dispose() {
    _contributionController.dispose();
    _rateController.dispose();
    _yearsController.dispose();
    super.dispose();
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
                    if (Navigator.of(context).canPop())
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DsSpacing.xs,
                      ),
                      child: Text('Simulador', style: DsTypography.heading2),
                    ),
                  ],
                ),
                const SizedBox(height: DsSpacing.lg),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: DsTextField(
                        label: 'Aporte mensal',
                        controller: _contributionController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onChanged: vm.setMonthlyContribution,
                      ),
                    ),
                    const SizedBox(width: DsSpacing.lg),
                    Expanded(
                      child: DsTextField(
                        label: 'Rentabilidade',
                        controller: _rateController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onChanged: vm.setAnnualRate,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: DsSpacing.lg),
                DsTextField(
                  label: 'Período',
                  controller: _yearsController,
                  keyboardType: TextInputType.number,
                  onChanged: vm.setYears,
                ),
                const SizedBox(height: DsSpacing.xl2),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: DsSpacing.xs),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Valor futuro estimado',
                        style: DsTypography.bodyMedium.copyWith(
                          fontSize: 13,
                          color: ds.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        Brl.format(vm.futureValue),
                        style: DsTypography.heading1.copyWith(
                          fontSize: 28,
                          fontWeight: DsTypography.bold,
                          color: ds.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: DsSpacing.xl),
                DsCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      LineAreaChart(
                        points: vm.chartPoints,
                        lineColor: DsColors.purple600,
                        fillColor: DsColors.purple100,
                        height: 138,
                        strokeWidth: 2.5,
                        showDots: true,
                      ),
                      const SizedBox(height: DsSpacing.md),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '0',
                            style: DsTypography.caption.copyWith(
                              fontSize: 10,
                              color: ds.textTertiary,
                            ),
                          ),
                          Text(
                            '${(vm.years / 2).round()} anos',
                            style: DsTypography.caption.copyWith(
                              fontSize: 10,
                              color: ds.textTertiary,
                            ),
                          ),
                          Text(
                            '${vm.years} anos',
                            style: DsTypography.caption.copyWith(
                              fontSize: 10,
                              color: ds.textTertiary,
                            ),
                          ),
                        ],
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
