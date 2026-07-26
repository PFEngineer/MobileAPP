import 'package:flutter/material.dart';

import '../tokens/ds_radius.dart';
import '../tokens/ds_spacing.dart';
import '../tokens/ds_typography.dart';
import '../theme/ds_theme_extension.dart';

/// Radio button — Figma `Radio`. Generic over the option value [T]; selection
/// is [value] == [groupValue].
class DsRadio<T> extends StatelessWidget {
  const DsRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    super.key,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T>? onChanged;
  final String? label;

  bool get _enabled => onChanged != null;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    final Widget control = RadioGroup<T>(
      groupValue: groupValue,
      onChanged: (T? v) {
        if (_enabled && v != null) onChanged!(v);
      },
      child: SizedBox(
        width: 20,
        height: 20,
        child: Radio<T>(
          value: value,
          enabled: _enabled,
          activeColor: ds.primary,
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) return ds.primary;
            return ds.borderStrong;
          }),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
      ),
    );

    if (label == null) return control;

    return InkWell(
      onTap: _enabled ? () => onChanged!(value) : null,
      borderRadius: DsRadius.smAll,
      child: Padding(
        padding: const EdgeInsets.all(DsSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            control,
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
