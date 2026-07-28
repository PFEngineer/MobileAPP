import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Generic sparkline/area chart used across features: a round-cap polyline
/// over a soft area fill closed to the bottom edge. Geometry follows the
/// Figma exports (hero 63:27, evolução 73:305, simulador 75:373).
class LineAreaChart extends StatelessWidget {
  const LineAreaChart({
    required this.points,
    required this.lineColor,
    required this.fillColor,
    this.height = 50,
    this.strokeWidth = 2,
    this.lineBoxHeight,
    this.showDots = false,
    super.key,
  });

  /// Normalized values in `0..1` (0 = bottom, 1 = top), evenly spaced.
  final List<double> points;
  final Color lineColor;
  final Color fillColor;
  final double height;
  final double strokeWidth;

  /// Height of the box the polyline spans; the fill always extends to the
  /// widget's bottom. Defaults to the full height.
  final double? lineBoxHeight;

  /// Draws markers along the line (Figma simulador 75:375..379).
  final bool showDots;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromHeight(height),
      painter: _LineAreaPainter(
        points: points,
        lineColor: lineColor,
        fillColor: fillColor,
        strokeWidth: strokeWidth,
        lineBoxHeight: lineBoxHeight,
        showDots: showDots,
      ),
    );
  }
}

class _LineAreaPainter extends CustomPainter {
  const _LineAreaPainter({
    required this.points,
    required this.lineColor,
    required this.fillColor,
    required this.strokeWidth,
    required this.lineBoxHeight,
    required this.showDots,
  });

  final List<double> points;
  final Color lineColor;
  final Color fillColor;
  final double strokeWidth;
  final double? lineBoxHeight;
  final bool showDots;

  @override
  void paint(Canvas canvas, Size size) {
    if (points.length < 2) return;
    final double box = lineBoxHeight ?? size.height;

    final Path line = Path();
    final List<Offset> dots = <Offset>[];
    for (int i = 0; i < points.length; i++) {
      final double x = size.width * i / (points.length - 1);
      final double y = box * (1 - points[i]);
      if (i == 0) {
        line.moveTo(x, y);
      } else {
        line.lineTo(x, y);
      }
      dots.add(Offset(x, y));
    }

    final Path area = Path.from(line)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(area, Paint()..color = fillColor);
    canvas.drawPath(
      line,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..color = lineColor,
    );

    if (showDots) {
      final Paint dotPaint = Paint()..color = lineColor;
      for (final Offset dot in dots) {
        canvas.drawCircle(dot, 3.5, dotPaint);
      }
    }
  }

  @override
  bool shouldRepaint(_LineAreaPainter oldDelegate) =>
      !listEquals(oldDelegate.points, points) ||
      oldDelegate.lineColor != lineColor ||
      oldDelegate.fillColor != fillColor ||
      oldDelegate.showDots != showDots;
}
