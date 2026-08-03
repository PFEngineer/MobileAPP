import 'package:flutter/material.dart';

import 'package:invest_app/core/analytics/analytics_service.dart';
import 'package:design_system/design_system.dart';

import '../../../../core/format/brl.dart';
import '../../../../core/widgets/underline_tabs.dart';
import '../../domain/entities/dividend.dart';
import '../viewmodels/dividends_view_model.dart';

/// 04. Dividendos — Figma node 72:183.
class DividendsPage extends StatefulWidget {
  const DividendsPage({required this.viewModel, super.key});

  final DividendsViewModel viewModel;

  @override
  State<DividendsPage> createState() => _DividendsPageState();
}

class _DividendsPageState extends State<DividendsPage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.trackScreenView('Dividendos');
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
                      child: Text('Dividendos', style: DsTypography.heading2),
                    ),
                  ],
                ),
                const SizedBox(height: DsSpacing.lg),
                UnderlineTabs(
                  tabs: DividendsViewModel.tabs,
                  selectedIndex: vm.tabIndex,
                  onChanged: (int index) {
                    AnalyticsService.trackClick(
                      'Dividendos ${DividendsViewModel.tabs[index]}',
                    );
                    vm.selectTab(index);
                  },
                ),
                const SizedBox(height: DsSpacing.lg),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: DsSpacing.xs),
                  child: Text(
                    'Próximos pagamentos',
                    style: DsTypography.bodyMedium.copyWith(
                      fontSize: 13,
                      fontWeight: DsTypography.semiBold,
                      color: ds.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: DsSpacing.md),
                for (final DividendPayment payment in vm.payments) ...<Widget>[
                  _PaymentListItem(payment: payment),
                  const SizedBox(height: DsSpacing.sm),
                ],
                const SizedBox(height: DsSpacing.lg),
                if (vm.received != null)
                  _ReceivedCard(received: vm.received!),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _PaymentListItem extends StatelessWidget {
  const _PaymentListItem({required this.payment});

  final DividendPayment payment;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Container(
      decoration: BoxDecoration(
        color: ds.surface,
        borderRadius: DsRadius.mdAll,
        border: Border.all(color: ds.border),
      ),
      child: DsListItem(
        title: payment.ticker,
        subtitle: '${payment.name} · ${payment.dateLabel}',
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: DsColors.neutral100,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Text(
            payment.initials,
            style: DsTypography.bodyMedium.copyWith(
              fontSize: 13,
              fontWeight: DsTypography.semiBold,
              color: ds.textPrimary,
            ),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  Brl.format(payment.amount),
                  style: DsTypography.bodyMedium.copyWith(
                    fontWeight: DsTypography.semiBold,
                    color: ds.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Faltam ${payment.daysLeft} dias',
                  style: DsTypography.labelMedium.copyWith(
                    color: ds.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(width: DsSpacing.sm),
            Icon(Icons.chevron_right, color: ds.textTertiary),
          ],
        ),
        onTap: () =>
            AnalyticsService.trackClick('Dividendo ${payment.ticker}'),
      ),
    );
  }
}

/// "Recebidos em junho" card with the mini bar chart (Figma 72:209 + 51:9).
class _ReceivedCard extends StatelessWidget {
  const _ReceivedCard({required this.received});

  final MonthlyDividends received;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return DsCard(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Recebidos em ${received.monthLabel}',
                  style: DsTypography.labelMedium.copyWith(
                    fontWeight: DsTypography.regular,
                    color: ds.textSecondary,
                  ),
                ),
                const SizedBox(height: DsSpacing.xs),
                Text(
                  Brl.format(received.total),
                  style: DsTypography.heading2.copyWith(
                    fontWeight: DsTypography.bold,
                  ),
                ),
                const SizedBox(height: DsSpacing.xs),
                Text(
                  received.deltaLabel,
                  style: DsTypography.labelMedium.copyWith(color: ds.success),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 96,
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                for (int i = 0; i < received.bars.length; i++)
                  Container(
                    width: 14,
                    height: 64 * received.bars[i],
                    decoration: BoxDecoration(
                      color: i == received.highlightedBar
                          ? DsColors.purple600
                          : DsColors.purple400,
                      borderRadius: BorderRadius.circular(3),
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
