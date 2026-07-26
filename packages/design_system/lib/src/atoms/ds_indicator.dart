import 'package:flutter/widgets.dart';

import '../tokens/ds_spacing.dart';
import '../theme/ds_theme_extension.dart';

/// Page / step indicator — Figma `Indicador`. A row of dots where the
/// [current] one is elongated and brand-colored.
class DsIndicator extends StatelessWidget {
  const DsIndicator({
    required this.count,
    required this.current,
    super.key,
  });

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(count, (i) {
        final bool active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: DsSpacing.xs / 2),
          width: active ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? ds.primary : ds.border,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
