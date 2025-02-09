import 'package:custom_paint/custom_paint/model/sketch_model.dart';
import 'package:flutter/material.dart';

class SketchPaint extends CustomPainter {
  const SketchPaint({
    required this.sketchList,
  });

  final List<SketchModel> sketchList;

  @override
  void paint(Canvas canvas, Size size) {
    for (final SketchModel sketch in sketchList) {
      final points = sketch.points;
      final path = Path();

      path.moveTo(points[0].dx, points[0].dy);
      for (int i = 1; i < points.length - 1; i++) {
        final p0 = points[i];
        final p1 = points[i + 1];
        path.quadraticBezierTo(
          p0.dx,
          p0.dy,
          (p0.dx + p1.dx) / 2,
          (p0.dy + p1.dy) / 2,
        );
      }
      Paint paint = Paint()
        ..color = sketch.color
        ..strokeWidth = sketch.size
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
