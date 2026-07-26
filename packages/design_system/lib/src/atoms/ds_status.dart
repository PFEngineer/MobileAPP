import 'package:flutter/widgets.dart';

import '../tokens/ds_spacing.dart';
import '../tokens/ds_typography.dart';
import '../theme/ds_theme_extension.dart';
import 'ds_tone.dart';

/// Status indicator — Figma `Status`. A colored dot plus a [label] conveying a
/// state (e.g. "Disponível", "Em viagem").
class DsStatus extends StatelessWidget {
  const DsStatus({
    required this.label,
    this.tone = DsTone.success,
    super.key,
  });

  final String label;
  final DsTone tone;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;
    final colors = DsToneColors.of(ds, tone);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: colors.solid,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: DsSpacing.sm),
        Text(
          label,
          style: DsTypography.labelMedium.copyWith(color: ds.textSecondary),
        ),
      ],
    );
  }
}
