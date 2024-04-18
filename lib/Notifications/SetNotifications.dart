
import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:timezone/data/latest_all.dart' as tz;
//import 'package:timezone/timezone.dart' as tz;
//import 'package:urinary_incontinence_application/BladderDiary/DailyEvaluationPage/DailyEvaluationPage.dart';

// int id = 0;

// final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
//     StreamController<ReceivedNotification>.broadcast();
// final StreamController<String?> selectNotificationStream =
//     StreamController<String?>.broadcast();

// class ReceivedNotification {
//   ReceivedNotification({
//     required this.id,
//     required this.title,
//     required this.body,
//     required this.payload,
//   });

//   final int id;
//   final String? title;
//   final String? body;
//   final String? payload;
// }

// String? selectedNotificationPayload;

// /// A notification action which triggers a url launch event
// const String urlLaunchActionId = 'id_1';

// /// A notification action which triggers a App navigation event
// const String navigationActionId = 'id_3';

// /// Defines a iOS/MacOS notification category for text input actions.
// const String darwinNotificationCategoryText = 'textCategory';

// /// Defines a iOS/MacOS notification category for plain actions.
// const String darwinNotificationCategoryPlain = 'plainCategory';

// @pragma('vm:entry-point')
// void notificationTapBackground(NotificationResponse notificationResponse) {
//   // ignore: avoid_print
//   print('notification(${notificationResponse.id}) action tapped: '
//       '${notificationResponse.actionId} with'
//       ' payload: ${notificationResponse.payload}');
//   if (notificationResponse.input?.isNotEmpty ?? false) {
//     // ignore: avoid_print
//     print(
//         'notification action tapped with input: ${notificationResponse.input}');
//   }
// }


// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
// // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project

// // Future<void> main() async{


// const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('flutter_logo');
// final DarwinInitializationSettings initializationSettingsDarwin =
//     DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//         onDidReceiveLocalNotification:(int id, String? title, String? body, String? payload) async{
//           didReceiveLocalNotificationStream.add(
//         ReceivedNotification(
//           id: id,
//           title: title,
//           body: body,
//           payload: payload,
//         ),
//       );
//         },);
// final InitializationSettings initializationSettings = InitializationSettings(
//     android: initializationSettingsAndroid,
//     iOS: initializationSettingsDarwin,
//     macOS: initializationSettingsDarwin);

//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//     onDidReceiveNotificationResponse:
//         (NotificationResponse notificationResponse) {
//       switch (notificationResponse.notificationResponseType) {
//         case NotificationResponseType.selectedNotification:
//           selectNotificationStream.add(notificationResponse.payload);
//           break;
//         case NotificationResponseType.selectedNotificationAction:
//           if (notificationResponse.actionId == navigationActionId) {
//             selectNotificationStream.add(notificationResponse.payload);
//           }
//           break;
//       }
//     },
//     onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
//   );
// }

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

