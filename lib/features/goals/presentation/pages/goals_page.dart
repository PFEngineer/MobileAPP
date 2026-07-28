import 'package:flutter/material.dart';

import 'package:analytics/analytics.dart';
import 'package:design_system/design_system.dart';

import '../../../../core/format/brl.dart';
import '../../domain/entities/goal.dart';
import '../viewmodels/goals_view_model.dart';

/// 06. Metas — Figma node 74:308.
class GoalsPage extends StatefulWidget {
  const GoalsPage({required this.viewModel, super.key});

  final GoalsViewModel viewModel;

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.trackScreenView('Metas');
    widget.viewModel.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: DsColors.purple600,
        foregroundColor: DsColors.neutral0,
        shape: const CircleBorder(),
        onPressed: () => AnalyticsService.trackClick('Nova meta'),
        child: const Icon(DsIcons.plus, size: 28),
      ),
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
                            color: context.dsColors.textPrimary,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: DsSpacing.xs,
                      ),
                      child: Text('Metas', style: DsTypography.heading2),
                    ),
                  ],
                ),
                const SizedBox(height: DsSpacing.lg),
                for (final Goal goal in vm.goals) ...<Widget>[
                  _GoalCard(goal: goal),
                  const SizedBox(height: DsSpacing.md),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

/// Goal card (Figma 74:323 detailed / 74:380 compact).
class _GoalCard extends StatelessWidget {
  const _GoalCard({required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;
    final bool detailed = goal.suggestedMonthlyContribution != null;

    return DsCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      goal.name,
                      style: DsTypography.bodyMedium.copyWith(
                        fontSize: 13,
                        fontWeight: DsTypography.medium,
                        color: ds.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      Brl.format(goal.target),
                      style: DsTypography.heading3.copyWith(
                        fontWeight: DsTypography.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      goal.deadlineLabel,
                      style: DsTypography.labelMedium.copyWith(
                        fontWeight: DsTypography.regular,
                        color: ds.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 56,
                height: 56,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    DsCircularProgress(
                      value: goal.progress,
                      size: 56,
                      strokeWidth: 6,
                    ),
                    Text(
                      '${(goal.progress * 100).round()}%',
                      style: DsTypography.bodyMedium.copyWith(
                        fontSize: 13,
                        fontWeight: DsTypography.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          DsLinearProgress(value: goal.progress),
          if (detailed) ...<Widget>[
            const SizedBox(height: 14),
            _GoalRow(
              label: Brl.format(goal.saved),
              value: Brl.format(goal.target),
            ),
            const SizedBox(height: 14),
            _GoalRow(label: 'Falta', value: Brl.format(goal.remaining)),
            const SizedBox(height: 14),
            _GoalRow(
              label: 'Aporte mensal sugerido',
              value: Brl.format(goal.suggestedMonthlyContribution!),
            ),
            const SizedBox(height: 14),
            _GoalRow(
              label: 'Rentabilidade projetada',
              value: goal.projectedReturnLabel!,
            ),
            const SizedBox(height: 14),
            Material(
              color: DsColors.purple100,
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () =>
                    AnalyticsService.trackClick('Detalhes ${goal.name}'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  child: Text(
                    'Ver detalhes',
                    style: DsTypography.bodyMedium.copyWith(
                      fontWeight: DsTypography.semiBold,
                      color: DsColors.purple700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _GoalRow extends StatelessWidget {
  const _GoalRow({required this.label, required this.value});

  final String label;
  final String value;

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
            fontSize: 13,
            fontWeight: DsTypography.semiBold,
            color: ds.textPrimary,
          ),
        ),
      ],
    );
  }
}
