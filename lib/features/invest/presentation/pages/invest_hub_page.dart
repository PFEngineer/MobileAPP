import 'package:flutter/material.dart';

import 'package:invest_app/core/analytics/analytics_service.dart';
import 'package:design_system/design_system.dart';

/// Landing of the "Investir" tab.
///
/// The Figma file groups Dividendos, Evolução, Metas and Simulador under the
/// Investir tab (their mocks show it active) but ships no hub screen, so this
/// is a minimal DS-only launcher for that section plus the Nova Operação
/// modal.
class InvestHubPage extends StatefulWidget {
  const InvestHubPage({required this.onOpen, super.key});

  /// Called with the destination route path.
  final ValueChanged<String> onOpen;

  @override
  State<InvestHubPage> createState() => _InvestHubPageState();
}

class _InvestHubPageState extends State<InvestHubPage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.trackScreenView('Investir');
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    Widget entry({
      required IconData icon,
      required String title,
      required String subtitle,
      required String route,
    }) {
      return Padding(
        padding: const EdgeInsets.only(bottom: DsSpacing.sm),
        child: Container(
          decoration: BoxDecoration(
            color: ds.surface,
            borderRadius: DsRadius.mdAll,
            border: Border.all(color: ds.border),
          ),
          child: DsListItem(
            title: title,
            subtitle: subtitle,
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: DsColors.purple100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 22, color: DsColors.purple700),
            ),
            trailing: Icon(Icons.chevron_right, color: ds.textTertiary),
            onTap: () {
              AnalyticsService.trackClick(title);
              widget.onOpen(route);
            },
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            DsSpacing.lg,
            DsSpacing.sm,
            DsSpacing.lg,
            DsSpacing.xl2,
          ),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DsSpacing.xs),
              child: Text('Investir', style: DsTypography.heading2),
            ),
            const SizedBox(height: DsSpacing.lg),
            entry(
              icon: DsIcons.plus,
              title: 'Nova operação',
              subtitle: 'Registre uma compra ou venda',
              route: '/nova-operacao',
            ),
            entry(
              icon: Icons.payments_outlined,
              title: 'Dividendos',
              subtitle: 'Calendário e histórico de proventos',
              route: '/dividendos',
            ),
            entry(
              icon: DsIcons.chart,
              title: 'Evolução patrimonial',
              subtitle: 'Acompanhe seu patrimônio no tempo',
              route: '/evolucao',
            ),
            entry(
              icon: Icons.flag_outlined,
              title: 'Metas',
              subtitle: 'Objetivos e progresso',
              route: '/metas',
            ),
            entry(
              icon: Icons.calculate_outlined,
              title: 'Simulador',
              subtitle: 'Projete seus investimentos',
              route: '/simulador',
            ),
          ],
        ),
      ),
    );
  }
}
