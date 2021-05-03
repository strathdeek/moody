import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moody/data/notifications.dart';
import 'package:moody/data/repositories/preferences_repository.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  final PreferencesRepository _preferencesRepository;
  ReminderCubit(this._preferencesRepository)
      : super(_preferencesRepository.remindersEnabled
            ? ReminderEnabled()
            : ReminderDisabled());

  void setRemindersEnabled(bool enabled, BuildContext context) {
    _preferencesRepository.setReminderEnabled(enabled);
    if (enabled) {
      scheduleDailyNotifications(context);
    } else {
      cancelAllNotifications();
    }
    emit(enabled ? ReminderEnabled() : ReminderDisabled());
  }
}
