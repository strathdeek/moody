import 'package:hive/hive.dart';
import 'package:moody/data/constants/hive.dart';
import 'package:moody/data/models/mood.dart';

class MoodProvider {
  final Box<Mood> _moodBox = Hive.box(MoodBoxKey);

  void add(Mood mood) {
    _moodBox.put(mood.id, mood);
  }

  void update(Mood mood) {
    _moodBox.put(mood.id, mood);
  }

  void delete(Mood mood) {
    _moodBox.delete(mood.id);
  }

  List<Mood> get() {
    var moodEntries = _moodBox.values.toList();
    return moodEntries;
  }
}
