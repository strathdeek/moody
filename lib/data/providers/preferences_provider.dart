import 'package:hive/hive.dart';
import 'package:moody/data/constants/hive.dart';

class PreferencesProvider {
  final Box _preferencesBox = Hive.box<bool>(PreferencesBoxKey);

  bool get remindersEnabled =>
      _preferencesBox.containsKey(RemindersEnabledKey) &&
      _preferencesBox.get(RemindersEnabledKey);

  void setRemindersEnabled(bool remindersEnabled) {
    _preferencesBox.put(RemindersEnabledKey, remindersEnabled);
  }
}
