import 'package:flutter/material.dart';

import 'package:design_system/design_system.dart';

/// InvestAI wordmark from Figma (login node 145:490): a purple rounded logo
/// mark with two white chart polylines, next to "Invest" (dark) + "AI"
/// (purple).
class InvestaiLogo extends StatelessWidget {
  const InvestaiLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: DsColors.purple600,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const CustomPaint(painter: _LogoMarkPainter()),
        ),
        const SizedBox(width: DsSpacing.md),
        Text.rich(
          TextSpan(
            style: DsTypography.displayXl.copyWith(
              fontSize: 34,
              fontWeight: DsTypography.bold,
            ),
            children: const <TextSpan>[
              TextSpan(
                text: 'Invest',
                style: TextStyle(color: DsColors.neutral900),
              ),
              TextSpan(
                text: 'AI',
                style: TextStyle(color: DsColors.purple600),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Two chart polylines from the Figma logo mark (44×44 viewBox).
class _LogoMarkPainter extends CustomPainter {
  const _LogoMarkPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double s = size.width / 44;
    Paint stroke(double width, double opacity) => Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width * s
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..color = DsColors.neutral0.withValues(alpha: opacity);

    Path line(List<Offset> pts) {
      final Path p = Path()..moveTo(pts.first.dx * s, pts.first.dy * s);
      for (final Offset o in pts.skip(1)) {
        p.lineTo(o.dx * s, o.dy * s);
      }
      return p;
    }

    canvas.drawPath(
      line(const <Offset>[
        Offset(11, 24),
        Offset(17, 15),
        Offset(23, 21),
        Offset(33, 10),
      ]),
      stroke(4, 1),
    );
    canvas.drawPath(
      line(const <Offset>[
        Offset(12, 33),
        Offset(20, 26),
        Offset(27, 30),
        Offset(33, 24),
      ]),
      stroke(3, 0.6),
    );
  }

  @override
  bool shouldRepaint(_LogoMarkPainter oldDelegate) => false;
}
