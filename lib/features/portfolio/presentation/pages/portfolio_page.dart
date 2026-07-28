import 'package:flutter/material.dart';

import 'package:analytics/analytics.dart';
import 'package:design_system/design_system.dart';

import '../../../../core/format/brl.dart';
import '../../../../core/widgets/underline_tabs.dart';
import '../../domain/entities/asset.dart';
import '../viewmodels/portfolio_view_model.dart';
import '../widgets/asset_list_item.dart';

/// 02. Carteira — Figma node 68:40.
class PortfolioPage extends StatefulWidget {
  const PortfolioPage({required this.viewModel, this.onAddOperation, super.key});

  final PortfolioViewModel viewModel;
  final VoidCallback? onAddOperation;

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.trackScreenView('Carteira');
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
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('Carteira', style: DsTypography.heading2),
                      ),
                      IconButton(
                        icon: Icon(DsIcons.search, color: ds.textPrimary),
                        onPressed: () =>
                            AnalyticsService.trackClick('Buscar ativo'),
                      ),
                      IconButton(
                        icon: Icon(Icons.tune, color: ds.textPrimary),
                        onPressed: () =>
                            AnalyticsService.trackClick('Filtrar carteira'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: DsSpacing.md),
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
                        Brl.format(125430.50),
                        style: DsTypography.heading1.copyWith(
                          fontSize: 28,
                          fontWeight: DsTypography.bold,
                        ),
                      ),
                      const SizedBox(height: DsSpacing.xs),
                      Text(
                        '+ ${Brl.format(3250.45)} (${Brl.percent(2.66)}) hoje',
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
                UnderlineTabs(
                  tabs: <String>[
                    'Todos',
                    ...AssetCategory.values
                        .map((AssetCategory c) => c.label),
                  ],
                  selectedIndex: vm.selectedCategory == null
                      ? 0
                      : AssetCategory.values.indexOf(vm.selectedCategory!) + 1,
                  onChanged: (int index) {
                    final AssetCategory? category =
                        index == 0 ? null : AssetCategory.values[index - 1];
                    AnalyticsService.trackClick(
                      'Categoria ${category?.label ?? 'Todos'}',
                    );
                    vm.selectCategory(category);
                  },
                ),
                const SizedBox(height: DsSpacing.lg),
                if (vm.assets.isEmpty)
                  if (!vm.isLoading)
                    Padding(
                      padding: const EdgeInsets.only(top: DsSpacing.xl2),
                      child: _emptyState(vm),
                    )
                  else
                    const SizedBox.shrink()
                else
                  for (final Asset asset in vm.assets) ...<Widget>[
                    AssetListItem(
                      asset: asset,
                      onTap: () =>
                          AnalyticsService.trackClick('Ativo ${asset.ticker}'),
                    ),
                    const SizedBox(height: DsSpacing.sm),
                  ],
              ],
            );
          },
        ),
      ),
    );
  }

  /// Shown when the selected product tab has no matching assets.
  Widget _emptyState(PortfolioViewModel vm) {
    final AssetCategory? category = vm.selectedCategory;
    final bool filtered = category != null;
    final String product = category?.label ?? 'produtos';

    return DsEmptyState(
      title: 'Nenhum ativo encontrado',
      description: filtered
          ? 'Você ainda não possui ${category.label} na sua carteira ou não há '
              'itens que correspondam aos filtros.'
          : 'Comece a investir para ver seus ativos aqui.',
      primaryActionLabel: 'Explorar $product',
      onPrimaryAction: () => AnalyticsService.trackClick('Explorar $product'),
      secondaryActionLabel: filtered ? 'Limpar filtros' : null,
      onSecondaryAction: filtered
          ? () {
              AnalyticsService.trackClick('Limpar filtros');
              vm.selectCategory(null);
            }
          : null,
    );
  }
}
