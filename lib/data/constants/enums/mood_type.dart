import 'package:flutter/material.dart';

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
    var string = toString();
    var name = string.substring(string.indexOf('.') + 1);
    name = name[0].toUpperCase() + name.substring(1);
    return name;
  }
}
