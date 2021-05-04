import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:moody/data/notifications.dart';
import 'package:moody/data/repositories/preferences_repository.dart';
import 'package:moody/generated/l10n.dart';
import 'package:permission_handler/permission_handler.dart';

part 'reminder_state.dart';

class ReminderCubit extends Cubit<ReminderState> {
  final PreferencesRepository _preferencesRepository;
  ReminderCubit(this._preferencesRepository)
      : super(_preferencesRepository.remindersEnabled
            ? ReminderEnabled()
            : ReminderDisabled());

  void setRemindersEnabled(bool enabled, BuildContext context) async {
    var permissionStatus = await Permission.notification.request();

    if (enabled) {
      if (permissionStatus != PermissionStatus.granted) {
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(S.of(context).pageSettingsRemindersAlertTitle),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(S.of(context).pageSettingsRemindersAlertDescription),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  await openAppSettings();
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).pageSettingsRemindersAlertAccept),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(S.of(context).pageSettingsRemindersAlertDecline),
              ),
            ],
          ),
        );
      } else {
        _preferencesRepository.setReminderEnabled(enabled);
        await scheduleDailyNotifications(context);
        emit(ReminderEnabled());
      }
    } else {
      cancelAllNotifications();
      emit(ReminderDisabled());
    }
  }
}
