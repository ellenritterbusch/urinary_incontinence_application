import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class SetNotifications {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async{
    AndroidInitializationSettings initializationSettingsAndroid =
     AndroidInitializationSettings('app_icon');

  final DarwinInitializationSettings initializationSettingsDarwin =
     DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
       requestSoundPermission: true,
        onDidReceiveLocalNotification:(int id, String? title, String? body, String? payload) async{});

  final InitializationSettings initializationSettings = InitializationSettings(
     android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,);
  await flutterLocalNotificationsPlugin.initialize(
     initializationSettings,
     onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {});
  }

  Future showNotification(
    {int id=0,String? title, String? body, String? payload}) async {
      return flutterLocalNotificationsPlugin.show(id, title, body, await notificationDetails());
    }
  
  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
      importance: Importance.max),
      iOS: DarwinNotificationDetails()
    );
  }

}