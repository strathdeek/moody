import 'package:moody/data/providers/preferences_provider.dart';

class PreferencesRepository {
  final PreferencesProvider _preferencesProvider;

  PreferencesRepository(this._preferencesProvider);

  bool get remindersEnabled => _preferencesProvider.remindersEnabled;

  void setReminderEnabled(bool remindersEnabled) {
    _preferencesProvider.setRemindersEnabled(remindersEnabled);
  }
}
