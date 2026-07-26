import 'package:flutter/material.dart';

import '../tokens/ds_radius.dart';
import '../tokens/ds_spacing.dart';
import '../tokens/ds_typography.dart';
import '../theme/ds_theme_extension.dart';

/// Checkbox — Figma `Checkbox`. Optional trailing [label] makes the whole row
/// tappable.
class DsCheckbox extends StatelessWidget {
  const DsCheckbox({
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

    final Widget box = SizedBox(
      width: 20,
      height: 20,
      child: Checkbox(
        value: value,
        onChanged: _enabled ? (v) => onChanged!(v ?? false) : null,
        activeColor: ds.primary,
        checkColor: ds.onPrimary,
        side: BorderSide(color: ds.borderStrong, width: 1.5),
        shape: const RoundedRectangleBorder(borderRadius: DsRadius.xsAll),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
    );

    if (label == null) return box;

    return InkWell(
      onTap: _enabled ? () => onChanged!(!value) : null,
      borderRadius: DsRadius.smAll,
      child: Padding(
        padding: const EdgeInsets.all(DsSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            box,
            const SizedBox(width: DsSpacing.sm),
            Text(
              label!,
              style: DsTypography.bodyMedium.copyWith(
                color: _enabled ? ds.textPrimary : ds.textDisabled,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
