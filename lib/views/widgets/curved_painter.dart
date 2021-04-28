import 'package:flutter/material.dart';

class CurvedPainter extends CustomPainter {
  final Color color;
  CurvedPainter({
    required this.color,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 15;

    var path = Path();

    path.moveTo(0, size.height * 0.95);
    path.quadraticBezierTo(
        size.width * 0.25, size.height, size.width * 0.5, size.height * 0.925);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.85,
        size.width * 1.0, size.height * 0.9);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
