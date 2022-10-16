import 'package:customize/core/services/local_notification/custom_notification.dart';
import 'package:customize/features/presentation/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:get/get.dart';

class LocalNotificationService extends GetxService {
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;
  late IOSNotificationDetails iOSDetails;

  LocalNotificationService() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _executeNotifications();
  }

  Future<void> _executeNotifications() async {
    await _initializeTimezone();
    await _initializeNotifications();
  }

  Future<void> _initializeTimezone() async {
    tz.initializeTimeZones();
    final String? timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
  }

  Future<void> _initializeNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');

    final iOS = IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    Future<bool?> requestPermissions() async {
      if (GetPlatform.isIOS) {
        await localNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
        await localNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                MacOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            );
      } else if (GetPlatform.isAndroid) {
        final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
            localNotificationsPlugin.resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>();

        final bool? granted = await androidImplementation?.requestPermission();
        return granted;
      }
      return null;
    }

    await localNotificationsPlugin.initialize(
      InitializationSettings(
        android: android,
        iOS: iOS,
      ),
      onSelectNotification: _onSelectedNotification,
    );
  }

  void _onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: Get.overlayContext!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              await Get.offNamed(Routes.TRANSACTION_PAGE);
            },
          )
        ],
      ),
    );
  }

  void _onSelectedNotification(String? payload) {
    if (payload != null && payload.isNotEmpty) {
      Get.offNamed(payload);
    }
  }

  void showScheduleNotification({
    required CustomNotification customNotification,
    required DateTime dueDate,
  }) {
    androidDetails = AndroidNotificationDetails(
      'notification_reminder_key',
      'notification reminder',
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
    );

    iOSDetails = IOSNotificationDetails(
      presentAlert: true,
      presentSound: true,
    );

    localNotificationsPlugin.zonedSchedule(
      customNotification.id,
      customNotification.title,
      customNotification.body,
      tz.TZDateTime.from(dueDate, tz.local),
      NotificationDetails(
        iOS: iOSDetails,
        android: androidDetails,
      ),
      payload: customNotification.payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelNotifications(int notificationId) async {
    await localNotificationsPlugin.cancel(notificationId);
  }

  Future<void> checkForNotifications() async {
    final details =
        await localNotificationsPlugin.getNotificationAppLaunchDetails();

    if (details != null && details.didNotificationLaunchApp) {
      _onSelectedNotification(details.payload);
    }
  }
}
