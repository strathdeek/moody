import 'package:flutter/material.dart';
import 'package:moody/generated/l10n.dart';

enum MoodType {
  awesome,
  good,
  meh,
  bad,
  terrible,
}

extension MoodTypeExtension on MoodType {
  MaterialColor toColor() {
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
    return color;
  }

  String getTypeName() {
    var name;
    switch (this) {
      case MoodType.awesome:
        name = S.current.moodTypeAwesome;
        break;
      case MoodType.good:
        name = S.current.moodTypeGood;
        break;
      case MoodType.meh:
        name = S.current.moodTypeMeh;
        break;
      case MoodType.bad:
        name = S.current.moodTypeBad;
        break;
      case MoodType.terrible:
        name = S.current.moodTypeTerrible;
        break;
    }
    return name;
  }
}
