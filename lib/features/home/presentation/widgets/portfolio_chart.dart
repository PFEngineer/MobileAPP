import 'package:flutter/material.dart';

import 'package:design_system/design_system.dart';

import '../../../../core/widgets/line_area_chart.dart';

/// Sparkline from the Figma hero (nodes 63:27/63:28): a 2px round-cap white
/// polyline over a soft white area fill closed to the chart's bottom edge.
class PortfolioChart extends StatelessWidget {
  const PortfolioChart({required this.points, super.key});

  /// Normalized values in `0..1` (0 = bottom, 1 = top), evenly spaced.
  final List<double> points;

  @override
  Widget build(BuildContext context) {
    return LineAreaChart(
      points: points,
      lineColor: DsColors.neutral0,
      fillColor: DsColors.neutral0.withValues(alpha: 0.18),
      height: 50,
      // Figma: the polyline spans the top 36px of the 50px chart box.
      lineBoxHeight: 36,
    );
  }
}
