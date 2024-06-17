
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/CalendarPage.dart';
import 'package:urinary_incontinence_application/main.dart';


int id = 0;
int dailyReminderHour = 20;     //daily reminder notification is by default sat to 20:00
int dailyReminderMin = 00;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


//for initialization
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

//Everything a notification can maintain
class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

/// A notification action which triggers a url launch event
const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = '/DailyEvaluationPage';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}


 class SetNotifications {

 void initializeNotification() {                      //function tha intialize a lot of thigs. Must be done for notification to work

  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
    AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();

  const AndroidInitializationSettings initializationSettingsAndroid =                           //settings for android
    AndroidInitializationSettings('app_icon');      //Icon wich will appear in out notification

   DarwinInitializationSettings initializationSettingsDarwin =                                  //settings for IOS
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
        onDidReceiveLocalNotification: 
        (int id, String? title, String? body, String? payload) async{
          didReceiveLocalNotificationStream.add(
        ReceivedNotification(
          id: id,
          title: title,
          body: body,
          payload: payload,
        )); 
      });
        
   InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
    macOS: initializationSettingsDarwin);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,                      //function called when a notfication is tapped
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground);
  
 }
  
Future onNotificationTap(NotificationResponse notificationResponse) async{    //when notification called, then navigate to CalendarPage
   navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => const CalendarPage()));  
  }


       /////  functions  //////

///// daily notification ////
 Future<void> scheduleDailyNotification() async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Remember to evaluate your day!',
        '',
        _nextInstanceOfChosenTime(),
        const NotificationDetails(
          android: AndroidNotificationDetails('daily notification channel id',
              'daily notification channel name',
              channelDescription: 'daily notification description'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

    tz.TZDateTime _nextInstanceOfChosenTime() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, dailyReminderHour-2, dailyReminderMin);       //dailyReminder variable is the preffered time
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

    // action notification -- not used currently ///
  Future<void> showNotificationWithActions() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      actions: <AndroidNotificationAction>[
        AndroidNotificationAction(
          urlLaunchActionId,
          'Accident',
          icon: DrawableResourceAndroidBitmap('food'),
          contextual: true,
        ),
      ],
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );

    const DarwinNotificationDetails macOSNotificationDetails =
        DarwinNotificationDetails(
      categoryIdentifier: darwinNotificationCategoryPlain,
    );    

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
      macOS: macOSNotificationDetails,
    );
    await flutterLocalNotificationsPlugin.show(
        id++, 'Remember to register!', 'Register directly in the notification', notificationDetails,
        payload: 'item z');
  }

}
