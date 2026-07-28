import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:design_system/design_system.dart';

import '../../../../core/format/brl.dart';
import '../../domain/entities/dashboard_stats.dart';

/// "Resumo da carteira" card from Figma (node 64:31): allocation donut with
/// a legend. Colors map asset classes to the DS semantic ramps.
class PortfolioBreakdownCard extends StatelessWidget {
  const PortfolioBreakdownCard({required this.slices, this.onTap, super.key});

  final List<AllocationSlice> slices;
  final VoidCallback? onTap;

  static const Map<AssetClass, Color> _colors = <AssetClass, Color>{
    AssetClass.stocks: DsColors.purple600,
    AssetClass.reits: DsColors.blue500,
    AssetClass.etfs: DsColors.green500,
    AssetClass.others: DsColors.orange500,
  };

  @override
  Widget build(BuildContext context) {
    final ds = context.dsColors;

    return DsCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Resumo da carteira',
            style: DsTypography.bodyLarge.copyWith(
              fontSize: 15,
              fontWeight: DsTypography.semiBold,
              color: ds.textPrimary,
            ),
          ),
          const SizedBox(height: DsSpacing.xl),
          Row(
            children: <Widget>[
              SizedBox(
                width: 92,
                height: 92,
                child: CustomPaint(
                  painter: _DonutPainter(
                    values: slices
                        .map((AllocationSlice s) => s.percent)
                        .toList(growable: false),
                    colors: slices
                        .map((AllocationSlice s) => _colors[s.assetClass]!)
                        .toList(growable: false),
                  ),
                ),
              ),
              const SizedBox(width: DsSpacing.xl),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (final AllocationSlice slice in slices) ...<Widget>[
                      if (slice != slices.first)
                        const SizedBox(height: DsSpacing.sm),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _colors[slice.assetClass],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: DsSpacing.sm),
                          Text(
                            '${slice.assetClass.label} '
                            '${Brl.percent(slice.percent, decimals: 1)}',
                            style: DsTypography.bodyMedium.copyWith(
                              fontSize: 13,
                              fontWeight: DsTypography.medium,
                              color: ds.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  const _DonutPainter({required this.values, required this.colors});

  final List<double> values;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final double total = values.fold(0, (double a, double b) => a + b);
    if (total <= 0) return;

    const double strokeWidth = 24;
    final Rect rect = Offset.zero & size;
    final Rect arcRect = rect.deflate(strokeWidth / 2);

    double startAngle = -math.pi / 2;
    for (int i = 0; i < values.length; i++) {
      final double sweep = values[i] / total * 2 * math.pi;
      canvas.drawArc(
        arcRect,
        startAngle,
        sweep,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..color = colors[i],
      );
      startAngle += sweep;
    }
  }

  @override
  bool shouldRepaint(_DonutPainter oldDelegate) =>
      !listEquals(oldDelegate.values, values) ||
      !listEquals(oldDelegate.colors, colors);
}
