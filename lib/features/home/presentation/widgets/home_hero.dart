import 'package:flutter/material.dart';

import 'package:invest_app/core/analytics/analytics_service.dart';
import 'package:design_system/design_system.dart';

import '../viewmodels/home_view_model.dart';
import 'portfolio_chart.dart';
import 'range_selector.dart';

/// Purple hero from Figma (node 63:3): greeting, quick actions, total
/// patrimony with visibility toggle, sparkline and period chips.
class HomeHero extends StatelessWidget {
  const HomeHero({
    required this.viewModel,
    this.onProfileTap,
    this.onAssistantTap,
    super.key,
  });

  final HomeViewModel viewModel;
  final VoidCallback? onProfileTap;
  final VoidCallback? onAssistantTap;

  // Figma: hero bottom corners use 28, between DsRadius.xl2 (24) and the
  // next step — kept literal to match the design exactly.
  static const double _bottomRadius = 28;

  @override
  Widget build(BuildContext context) {
    final Color white85 = DsColors.neutral0.withValues(alpha: 0.85);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: DsColors.purple600,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(_bottomRadius),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            DsSpacing.xl2,
            DsSpacing.sm,
            DsSpacing.xl2,
            DsSpacing.xl2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      viewModel.greeting,
                      style: DsTypography.bodyLarge.copyWith(
                        fontWeight: DsTypography.semiBold,
                        color: DsColors.neutral0,
                      ),
                    ),
                  ),
                  _HeroCircleButton(
                    onTap: () => onProfileTap?.call(),
                    child: const _AvatarDot(),
                  ),
                  const SizedBox(width: DsSpacing.sm),
                  _HeroCircleButton(
                    onTap: () => onAssistantTap?.call(),
                    child: const _CardOutline(),
                  ),
                ],
              ),
              const SizedBox(height: DsSpacing.xl2),
              Row(
                children: <Widget>[
                  Text(
                    'Patrimônio total',
                    style: DsTypography.bodyMedium.copyWith(
                      fontSize: 13,
                      color: white85,
                    ),
                  ),
                  const SizedBox(width: DsSpacing.lg),
                  InkWell(
                    customBorder: const CircleBorder(),
                    onTap: () {
                      viewModel.toggleBalanceVisibility();
                      AnalyticsService.trackClick('Visibilidade do saldo');
                    },
                    child: Icon(
                      viewModel.isBalanceVisible
                          ? DsIcons.eye
                          : Icons.visibility_off_outlined,
                      size: DsSpacing.lg,
                      color: white85,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: DsSpacing.xs),
              Text(
                viewModel.formattedTotal,
                style: DsTypography.heading1.copyWith(
                  fontWeight: DsTypography.bold,
                  color: DsColors.neutral0,
                ),
              ),
              const SizedBox(height: DsSpacing.xs),
              Text(
                viewModel.formattedPeriodChange,
                style: DsTypography.bodyMedium.copyWith(
                  fontSize: 13,
                  fontWeight: DsTypography.medium,
                  // Figma green/50 — the DS green ramp only ships 500.
                  color: const Color(0xFFECFDF5),
                ),
              ),
              const SizedBox(height: DsSpacing.xl2),
              PortfolioChart(
                points: viewModel.summary?.chartPoints ?? const <double>[],
              ),
              const SizedBox(height: DsSpacing.lg),
              RangeSelector(
                selected: viewModel.selectedRange,
                onSelected: (range) {
                  AnalyticsService.trackClick('Período ${range.label}');
                  viewModel.selectRange(range);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 36px translucent circle button (Figma nodes 63:18 / 63:20).
class _HeroCircleButton extends StatelessWidget {
  const _HeroCircleButton({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: DsColors.neutral0.withValues(alpha: 0.16),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: SizedBox(width: 36, height: 36, child: Center(child: child)),
      ),
    );
  }
}

/// Avatar placeholder: solid white dot (Figma node 63:18).
class _AvatarDot extends StatelessWidget {
  const _AvatarDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: const BoxDecoration(
        color: DsColors.neutral0,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// Card glyph: 14px square with a 1.5px white outline (Figma node 63:21).
class _CardOutline extends StatelessWidget {
  const _CardOutline();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        border: Border.all(color: DsColors.neutral0, width: 1.5),
        borderRadius: const BorderRadius.all(Radius.circular(3)),
      ),
    );
  }
}
