import 'package:flutter/material.dart';

import '../tokens/ds_spacing.dart';
import '../tokens/ds_typography.dart';
import '../theme/ds_theme_extension.dart';

/// Switch / toggle — Figma `Switch`. Optional leading [label] fills the row and
/// pushes the control to the trailing edge.
class DsSwitch extends StatelessWidget {
  const DsSwitch({
    required this.value,
    required this.onChanged,
    this.label,
    super.key,
  });

  final bool value;
  final ValueChanged<bool>? onChanged;
  final String? label;

  bool get _enabled => onChanged != null;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    final Widget control = Switch(
      value: value,
      onChanged: _enabled ? onChanged : null,
      activeThumbColor: ds.onPrimary,
      activeTrackColor: ds.primary,
      inactiveThumbColor: ds.surface,
      inactiveTrackColor: ds.borderStrong,
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    if (label == null) return control;

    return InkWell(
      onTap: _enabled ? () => onChanged!(!value) : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: DsSpacing.xs),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                label!,
                style: DsTypography.bodyMedium.copyWith(
                  color: _enabled ? ds.textPrimary : ds.textDisabled,
                ),
              ),
            ),
            const SizedBox(width: DsSpacing.sm),
            control,
          ],
        ),
      ),
    );
  }
}
