import 'package:flutter/material.dart';
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

  ThemeMode get theme {
    if (_preferencesBox.containsKey(DarkModeEnabledKey)) {
      return _preferencesBox.get(DarkModeEnabledKey)
          ? ThemeMode.dark
          : ThemeMode.light;
    } else {
      return ThemeMode.system;
    }
  }

  void setTheme(ThemeMode themeMode) {
    if (themeMode == ThemeMode.dark) {
      _preferencesBox.put(DarkModeEnabledKey, true);
    } else if (themeMode == ThemeMode.light) {
      _preferencesBox.put(DarkModeEnabledKey, false);
    } else if (themeMode == ThemeMode.system) {
      _preferencesBox.delete(DarkModeEnabledKey);
    }
  }
}
