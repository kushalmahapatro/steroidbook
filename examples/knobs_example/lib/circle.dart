import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

class Circle extends StatelessWidget {
  const Circle({super.key});

  static final double radius = 100;
  static final Color circleColor = Colors.yellow;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: Container(
        width: radius * 2,
        height: radius * 2,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100), color: Colors.yellow),
        child: CustomPaint(painter: LinePainter()),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(DoubleProperty('radius', radius));
    properties.add(ColorProperty('circleColor', circleColor));
    super.debugFillProperties(properties);
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    for (double i = 0; i < 360; i += 360 / 16) {
      final p1 = Offset(100 /* + radius * math.sin((180 / math.pi) * i)*/, 0);
      final p2 = Offset(size.height / 2,
          size.height /* + radius * math.sin((180 / math.pi) * i) */);
      final paint = Paint()
        ..color = Colors.black
        ..strokeWidth = 4;
      canvas.drawLine(p1, p2, paint);
    }
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => true;
}
