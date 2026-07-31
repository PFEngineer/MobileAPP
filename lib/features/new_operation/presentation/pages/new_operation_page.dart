import 'package:flutter/material.dart';

import 'package:mobile_app/core/analytics/analytics_service.dart';
import 'package:design_system/design_system.dart';

import '../../../../core/format/brl.dart';
import '../../domain/entities/operation.dart';
import '../viewmodels/new_operation_view_model.dart';

/// 03. Nova Operação — Figma node 70:162. Fullscreen modal (✕ closes).
class NewOperationPage extends StatefulWidget {
  const NewOperationPage({required this.viewModel, super.key});

  final NewOperationViewModel viewModel;

  @override
  State<NewOperationPage> createState() => _NewOperationPageState();
}

class _NewOperationPageState extends State<NewOperationPage> {
  late final TextEditingController _quantityController;
  late final TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    AnalyticsService.trackScreenView('Nova Operação');
    _quantityController =
        TextEditingController(text: widget.viewModel.quantity.toString());
    _priceController =
        TextEditingController(text: Brl.format(widget.viewModel.unitPrice));
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickOption({
    required String title,
    required List<String> options,
    required String selected,
    required ValueChanged<String> onSelected,
  }) async {
    final ds = context.dsColors;
    final String? choice = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: ds.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: DsRadius.lgRadius),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(DsSpacing.lg),
              child: Text(title, style: DsTypography.heading3),
            ),
            for (final String option in options)
              DsListItem(
                title: option,
                trailing: option == selected
                    ? Icon(DsIcons.check, color: ds.primary)
                    : null,
                onTap: () => Navigator.of(context).pop(option),
              ),
            const SizedBox(height: DsSpacing.sm),
          ],
        ),
      ),
    );
    if (choice != null) onSelected(choice);
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.viewModel.date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) widget.viewModel.selectDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: widget.viewModel,
          builder: (context, _) {
            final vm = widget.viewModel;
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: DsSpacing.lg,
                    vertical: DsSpacing.sm,
                  ),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        customBorder: const CircleBorder(),
                        onTap: () => Navigator.of(context).maybePop(),
                        child: Padding(
                          padding: const EdgeInsets.all(DsSpacing.xs),
                          child: Icon(DsIcons.close, color: ds.textPrimary),
                        ),
                      ),
                      const SizedBox(width: DsSpacing.md),
                      Text(
                        'Nova operação',
                        style: DsTypography.heading3.copyWith(fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DsSpacing.lg,
                      vertical: DsSpacing.sm,
                    ),
                    children: <Widget>[
                      _SegmentedSide(
                        selected: vm.side,
                        onChanged: (OperationSide side) {
                          AnalyticsService.trackClick(
                            'Operação ${side.label}',
                          );
                          vm.selectSide(side);
                        },
                      ),
                      const SizedBox(height: DsSpacing.xl),
                      _FieldLabel('Ativo'),
                      _SelectField(
                        value: vm.asset,
                        onTap: () => _pickOption(
                          title: 'Ativo',
                          options: NewOperationViewModel.assetOptions,
                          selected: vm.asset,
                          onSelected: vm.selectAsset,
                        ),
                      ),
                      const SizedBox(height: DsSpacing.xl),
                      _FieldLabel('Quantidade'),
                      DsTextField(
                        controller: _quantityController,
                        keyboardType: TextInputType.number,
                        onChanged: vm.setQuantity,
                      ),
                      const SizedBox(height: DsSpacing.xl),
                      _FieldLabel('Preço unitário'),
                      DsTextField(
                        controller: _priceController,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        onChanged: vm.setUnitPrice,
                      ),
                      const SizedBox(height: DsSpacing.xl),
                      _FieldLabel('Data da operação'),
                      _SelectField(
                        value: vm.formattedDate,
                        icon: Icons.calendar_today_outlined,
                        onTap: _pickDate,
                      ),
                      const SizedBox(height: DsSpacing.xl),
                      _FieldLabel('Corretora'),
                      _SelectField(
                        value: vm.broker,
                        onTap: () => _pickOption(
                          title: 'Corretora',
                          options: NewOperationViewModel.brokerOptions,
                          selected: vm.broker,
                          onSelected: vm.selectBroker,
                        ),
                      ),
                      const SizedBox(height: DsSpacing.xl2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Taxas e emolumentos',
                            style: DsTypography.bodyMedium.copyWith(
                              fontSize: 13,
                              color: ds.textSecondary,
                            ),
                          ),
                          Text(
                            Brl.format(vm.fees),
                            style: DsTypography.bodyMedium.copyWith(
                              fontWeight: DsTypography.medium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: DsSpacing.lg),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Total da operação',
                            style: DsTypography.bodyLarge.copyWith(
                              fontSize: 15,
                              fontWeight: DsTypography.semiBold,
                            ),
                          ),
                          Text(
                            Brl.format(vm.total),
                            style: DsTypography.heading3.copyWith(
                              fontSize: 18,
                              fontWeight: DsTypography.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(DsSpacing.lg),
                  child: DsButton(
                    label: 'Salvar operação',
                    expanded: true,
                    isLoading: vm.isSaving,
                    onPressed: () async {
                      AnalyticsService.trackClick('Salvar operação');
                      await vm.save();
                      if (context.mounted) Navigator.of(context).maybePop();
                    },
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

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DsSpacing.sm),
      child: Text(
        label,
        style: DsTypography.bodyMedium.copyWith(
          fontSize: 13,
          fontWeight: DsTypography.medium,
          color: context.dsColors.textPrimary,
        ),
      ),
    );
  }
}

/// Read-only select field — Figma `Select` (47:2) / `Date Picker` (47:17).
class _SelectField extends StatelessWidget {
  const _SelectField({
    required this.value,
    required this.onTap,
    this.icon = Icons.keyboard_arrow_down,
  });

  final String value;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Material(
      color: ds.surface,
      borderRadius: DsRadius.smAll,
      child: InkWell(
        onTap: onTap,
        borderRadius: DsRadius.smAll,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 11,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: ds.border),
            borderRadius: DsRadius.smAll,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(value, style: DsTypography.bodyMedium),
              ),
              Icon(icon, size: 18, color: ds.textSecondary),
            ],
          ),
        ),
      ),
    );
  }
}

/// Segmented Compra/Venda control — Figma 71:183.
class _SegmentedSide extends StatelessWidget {
  const _SegmentedSide({required this.selected, required this.onChanged});

  final OperationSide selected;
  final ValueChanged<OperationSide> onChanged;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return Container(
      height: 44,
      padding: const EdgeInsets.all(DsSpacing.xs),
      decoration: BoxDecoration(
        color: DsColors.neutral100,
        borderRadius: DsRadius.mdAll,
      ),
      child: Row(
        children: <Widget>[
          for (final OperationSide side in OperationSide.values)
            Expanded(
              child: Material(
                color: side == selected ? ds.surface : Colors.transparent,
                borderRadius: BorderRadius.circular(9),
                elevation: side == selected ? 1 : 0,
                shadowColor: Colors.black26,
                child: InkWell(
                  onTap: () => onChanged(side),
                  borderRadius: BorderRadius.circular(9),
                  child: Center(
                    child: Text(
                      side.label,
                      style: DsTypography.bodyMedium.copyWith(
                        fontWeight: DsTypography.semiBold,
                        color: side == selected
                            ? ds.primary
                            : ds.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
