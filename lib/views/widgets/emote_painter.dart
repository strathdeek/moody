import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:moody/data/constants/enums/mood_type.dart';

class EmotePainter extends CustomPainter {
  final MoodType emotion;
  final double _y_offset = 10;
  EmotePainter({
    required this.emotion,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    switch (emotion) {
      case MoodType.awesome:
        canvas.drawLine(
            Offset(150, _y_offset + 50), Offset(150, _y_offset + 150), paint);
        canvas.drawLine(
            Offset(250, _y_offset + 50), Offset(250, _y_offset + 150), paint);
        canvas.drawArc(
            Rect.fromPoints(
                Offset(100, _y_offset + 150), Offset(300, _y_offset + 250)),
            0,
            pi,
            true,
            paint);
        break;
      case MoodType.good:
        canvas.drawLine(
            Offset(150, _y_offset + 50), Offset(150, _y_offset + 150), paint);
        canvas.drawLine(
            Offset(250, _y_offset + 50), Offset(250, _y_offset + 150), paint);
        canvas.drawArc(
            Rect.fromPoints(
                Offset(100, _y_offset + 150), Offset(300, _y_offset + 250)),
            0,
            pi,
            false,
            paint);
        break;
      case MoodType.meh:
        canvas.drawLine(
            Offset(150, _y_offset + 50), Offset(150, _y_offset + 150), paint);
        canvas.drawLine(
            Offset(250, _y_offset + 50), Offset(250, _y_offset + 150), paint);
        canvas.drawLine(
            Offset(100, _y_offset + 250), Offset(300, _y_offset + 250), paint);
        break;
      case MoodType.bad:
        canvas.drawLine(
            Offset(150, _y_offset + 50), Offset(150, _y_offset + 150), paint);
        canvas.drawLine(
            Offset(250, _y_offset + 50), Offset(250, _y_offset + 150), paint);
        canvas.drawArc(
            Rect.fromPoints(
                Offset(100, _y_offset + 300), Offset(300, _y_offset + 200)),
            pi,
            pi,
            false,
            paint);
        break;
      case MoodType.terrible:
        canvas.drawLine(
            Offset(150, _y_offset + 100), Offset(150, _y_offset + 150), paint);
        canvas.drawLine(
            Offset(125, _y_offset + 25), Offset(175, _y_offset + 75), paint);
        canvas.drawLine(
            Offset(250, _y_offset + 100), Offset(250, _y_offset + 150), paint);
        canvas.drawLine(
            Offset(225, _y_offset + 75), Offset(275, _y_offset + 25), paint);
        canvas.drawArc(
            Rect.fromPoints(
                Offset(100, _y_offset + 300), Offset(300, _y_offset + 200)),
            pi,
            pi,
            false,
            paint);
        break;
      default:
        break;
    }

    var pb = ParagraphBuilder(
      ParagraphStyle(
        textAlign: TextAlign.center,
        fontSize: 36.0,
      ),
    );
    var emotionName =
        emotion.toString().substring(emotion.toString().lastIndexOf('.') + 1);
    emotionName = emotionName.replaceRange(0, 1, emotionName[0].toUpperCase());

    pb.addText(emotionName);
    var paragraph = pb.build();
    paragraph.layout(ParagraphConstraints(width: 300));
    canvas.drawParagraph(paragraph, Offset(50, _y_offset + 325));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
