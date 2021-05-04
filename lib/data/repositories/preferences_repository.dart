import 'package:flutter/material.dart';
import 'package:moody/data/providers/preferences_provider.dart';

class PreferencesRepository {
  final PreferencesProvider _preferencesProvider;

  PreferencesRepository(this._preferencesProvider);

  bool get remindersEnabled => _preferencesProvider.remindersEnabled;

  void setReminderEnabled(bool remindersEnabled) {
    _preferencesProvider.setRemindersEnabled(remindersEnabled);
  }

  ThemeMode get theme => _preferencesProvider.theme;

  void setTheme(ThemeMode theme) {
    _preferencesProvider.setTheme(theme);
  }
}
