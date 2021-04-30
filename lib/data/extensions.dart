import 'dart:math' as math;

import 'constants/enums/mood_type.dart';

extension DoubleExtension on double {
  double roundToDigits(int digits) {
    return (this * math.pow(10, digits)).round() / math.pow(10, digits);
  }

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
