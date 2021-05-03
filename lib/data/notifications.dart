import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moody/generated/l10n.dart';

bool notificationsScheduled = false;
final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initializeNotifications(BuildContext context) async {
  if (notificationsScheduled) {
    return;
  }

  const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final initializationSettingsIOS = IOSInitializationSettings();
  final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await _flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  await scheduleDailyNotifications(context);
}

Future<void> scheduleDailyNotifications(BuildContext context) async {
  await _flutterLocalNotificationsPlugin.periodicallyShow(
    0,
    S.of(context).notificationTitle,
    S.of(context).notificationDescription,
    RepeatInterval.daily,
    const NotificationDetails(
        android: AndroidNotificationDetails(
            'channelId', 'channelName', 'channelDescription')),
    androidAllowWhileIdle: true,
  );
  notificationsScheduled = true;
}

void cancelAllNotifications() {
  _flutterLocalNotificationsPlugin.cancelAll();
  notificationsScheduled = false;
}
