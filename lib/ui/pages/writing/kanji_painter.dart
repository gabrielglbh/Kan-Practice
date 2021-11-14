import 'dart:ui';

import 'package:flutter/material.dart';

class KanjiPainter extends CustomPainter {
  List<Offset?> points;
  double size;
  KanjiPainter({required this.points, required this.size});

  List<Offset> offsetPoints = [];

  @override
  void paint(Canvas canvas, Size size) {
    Paint kanjiPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 10
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round;

    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(this.size/2, 0), Offset(this.size/2, 900), paint);
    canvas.drawLine(Offset(0, this.size/2), Offset(900, this.size/2), paint);

    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, kanjiPaint);
      } else if (points[i] != null && points[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(points[i]!);
        offsetPoints.add(Offset(points[i]!.dx + 0.1, points[i]!.dy + 0.1));
        canvas.drawPoints(PointMode.points, offsetPoints, kanjiPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}