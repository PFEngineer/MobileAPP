import 'package:flutter/material.dart';

import 'package:invest_app/core/analytics/analytics_service.dart';
import 'package:design_system/design_system.dart';

import '../../domain/entities/discover_content.dart';
import '../viewmodels/discover_view_model.dart';

/// 09. Descobrir — Figma node 77:396.
class DiscoverPage extends StatefulWidget {
  const DiscoverPage({required this.viewModel, super.key});

  final DiscoverViewModel viewModel;

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.trackScreenView('Descobrir');
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: DsSpacing.xs),
                  child: Text('Descobrir', style: DsTypography.heading2),
                ),
                const SizedBox(height: DsSpacing.lg),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: DsSpacing.xs),
                  child: Text(
                    'Insights para você',
                    style: DsTypography.bodyMedium.copyWith(
                      fontWeight: DsTypography.semiBold,
                      color: ds.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: DsSpacing.md),
                for (final DiscoverInsight insight in vm.insights)
                  DsCard(
                    onTap: () =>
                        AnalyticsService.trackClick('Insight ${insight.title}'),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                insight.title,
                                style: DsTypography.bodyMedium.copyWith(
                                  fontWeight: DsTypography.semiBold,
                                ),
                              ),
                              const SizedBox(height: DsSpacing.xs),
                              Text(
                                insight.subtitle,
                                style: DsTypography.labelMedium.copyWith(
                                  fontWeight: DsTypography.regular,
                                  color: ds.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: DsSpacing.md),
                        Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            // Figma orange/50 — the DS orange ramp only
                            // ships 500.
                            color: Color(0xFFFFF7ED),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            insight.emoji,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: DsSpacing.xl),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: DsSpacing.xs),
                  child: Text(
                    'Conteúdos recomendados',
                    style: DsTypography.bodyMedium.copyWith(
                      fontWeight: DsTypography.semiBold,
                      color: ds.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: DsSpacing.md),
                for (final DiscoverContent content in vm.contents) ...<Widget>[
                  _ContentCard(content: content),
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

class _ContentCard extends StatelessWidget {
  const _ContentCard({required this.content});

  final DiscoverContent content;

  // Figma thumbnails: purple/200 and the 50-tones missing from the DS ramps.
  static const Map<ContentTone, Color> _thumbColors = <ContentTone, Color>{
    ContentTone.purple: DsColors.purple200,
    ContentTone.blue: Color(0xFFEFF6FF),
    ContentTone.green: Color(0xFFECFDF5),
  };

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return DsCard(
      padding: const EdgeInsets.fromLTRB(
        DsSpacing.md,
        DsSpacing.md,
        14,
        DsSpacing.md,
      ),
      onTap: () => AnalyticsService.trackClick('Conteúdo ${content.title}'),
      child: Row(
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: _thumbColors[content.tone],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: DsSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  content.title,
                  style: DsTypography.bodyMedium.copyWith(
                    fontWeight: DsTypography.semiBold,
                  ),
                ),
                const SizedBox(height: DsSpacing.xs),
                Text(
                  '${content.readMinutes} min de leitura',
                  style: DsTypography.labelMedium.copyWith(
                    fontWeight: DsTypography.regular,
                    color: ds.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: DsSpacing.sm),
          Icon(Icons.chevron_right, color: ds.textTertiary),
        ],
      ),
    );
  }
}
