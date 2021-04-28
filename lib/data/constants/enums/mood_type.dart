import 'package:flutter/material.dart';

enum MoodType {
  awesome,
  good,
  meh,
  bad,
  terrible,
}

extension MoodTypeExtension on MoodType {
  Color toColor() {
    var color;
    switch (this) {
      case MoodType.awesome:
        color = Colors.green;
        break;
      case MoodType.good:
        color = Colors.lime;
        break;
      case MoodType.meh:
        color = Colors.amber;
        break;
      case MoodType.bad:
        color = Colors.orange;
        break;
      case MoodType.terrible:
        color = Colors.red;
        break;
    }
    return color.shade400;
  }
}

extension MoodTypeConversion on double {
  MoodType toMoodType() {
    var mood;
    if (this > 80) {
      mood = MoodType.awesome;
    } else if (this > 60) {
      mood = MoodType.good;
    } else if (this > 40) {
      mood = MoodType.meh;
    } else if (this > 20) {
      mood = MoodType.bad;
    } else {
      mood = MoodType.terrible;
    }
    return mood;
  }
}
