import 'package:flutter/material.dart';
import 'package:moody/data/constants/enums/mood_type.dart';

import 'curved_painter.dart';
import 'emote_painter.dart';

class EmoteBanner extends StatelessWidget {
  final MoodType moodType;
  const EmoteBanner({
    Key? key,
    required this.moodType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          size: Size.fromHeight(460),
          painter: CurvedPainter(color: moodType.toColor()),
        ),
        CustomPaint(
          size: Size.fromHeight(400),
          painter: EmotePainter(emotion: moodType),
        )
      ],
    );
  }
}
