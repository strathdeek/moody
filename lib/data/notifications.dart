import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:moody/generated/l10n.dart';

bool notificationsScheduled = false;

Future<void> initializeNotifications(BuildContext context) async {
  if (notificationsScheduled) {
    return;
  }

  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  const initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final initializationSettingsIOS = IOSInitializationSettings();
  final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

  await flutterLocalNotificationsPlugin.periodicallyShow(
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
