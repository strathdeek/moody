import 'package:moody/data/models/mood.dart';
import 'package:moody/data/providers/mood_provider.dart';

class MoodRepository {
  final MoodProvider _moodProvider;

  MoodRepository(this._moodProvider);

  void add(Mood mood) {
    _moodProvider.update(mood);
  }

  void update(Mood mood) {
    _moodProvider.update(mood);
  }

  void delete(Mood mood) {
    _moodProvider.delete(mood);
  }

  List<Mood> get() {
    return _moodProvider.get();
  }
}
