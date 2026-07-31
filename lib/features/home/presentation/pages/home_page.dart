import 'package:flutter/material.dart';

import 'package:mobile_app/core/analytics/analytics_service.dart';
import 'package:design_system/design_system.dart';

import '../viewmodels/home_view_model.dart';
import '../widgets/home_hero.dart';
import '../widgets/portfolio_breakdown_card.dart';
import '../widgets/stats_card.dart';

/// 01. Dashboard — Figma node 63:2: purple hero, stats card and portfolio
/// breakdown. The view is passive: all state lives in [HomeViewModel].
class HomePage extends StatefulWidget {
  const HomePage({required this.viewModel, this.onNavigate, super.key});

  final HomeViewModel viewModel;

  /// Central navigation hook — receives an [AppRoutes] path.
  final ValueChanged<String>? onNavigate;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.trackScreenView('Home');
    widget.viewModel.load();
  }

  void _go(String path) => widget.onNavigate?.call(path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: widget.viewModel,
        builder: (context, _) {
          final vm = widget.viewModel;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                HomeHero(
                  viewModel: vm,
                  onProfileTap: () {
                    AnalyticsService.trackClick('Perfil');
                    _go('/perfil');
                  },
                  onAssistantTap: () {
                    AnalyticsService.trackClick('Assistente IA');
                    _go('/assistente');
                  },
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    DsSpacing.xl,
                    DsSpacing.xl,
                    DsSpacing.xl,
                    DsSpacing.none,
                  ),
                  child: vm.stats == null
                      ? const SizedBox.shrink()
                      : StatsCard(
                          stats: vm.stats!,
                          onProfitTap: () {
                            AnalyticsService.trackClick('Rentabilidade');
                            _go('/evolucao');
                          },
                          onDividendsTap: () {
                            AnalyticsService.trackClick('Dividendos');
                            _go('/dividendos');
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(DsSpacing.xl),
                  child: vm.allocation.isEmpty
                      ? const SizedBox.shrink()
                      : PortfolioBreakdownCard(
                          slices: vm.allocation,
                          onTap: () {
                            AnalyticsService.trackClick('Resumo da carteira');
                            _go('/carteira');
                          },
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
