import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:farmfresh/utility/app_constants.dart';
import 'package:farmfresh/utility/app_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_broadcast_receiver/flutter_broadcast_receiver.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();
  notify(message);
}

class PushNotificationsManager {
  PushNotificationsManager._();
  factory PushNotificationsManager() => _instance;
  static final PushNotificationsManager _instance =
      PushNotificationsManager._();
  bool _initialized = false;
  Future<void> init() async {
    initNotificationChanel();
    if (!_initialized) {
      await Firebase.initializeApp();

      FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
      AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        } else {
          FirebaseMessaging.instance.getToken().then((value) {
            AppStorage().token = value;
            BroadcastReceiver()
                .publish<String>(AppConstant.updateToken, arguments: value);
          });

          FirebaseMessaging.onMessage.listen((RemoteMessage message) {
            notify(message);
          });
        }
      });
      _initialized = true;
    }
  }

  void initNotificationChanel() {
    AwesomeNotifications().initialize(
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
            channelGroupKey: 'Farm_Fresh',
            channelKey: 'farm_fress_key',
            channelName: 'Farm Fresh',
            channelDescription: 'Notification channel Farm Fresh',
            importance: NotificationImportance.High,
            defaultColor: Colors.orange,
            ledColor: Colors.white)
      ],
    );
  }
}

void notify(RemoteMessage message) {
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: Random().nextInt(100),
          channelKey: 'farm_fress_key',
          title: message.notification?.title ?? "",
          body: message.notification?.body ?? ""));
}
