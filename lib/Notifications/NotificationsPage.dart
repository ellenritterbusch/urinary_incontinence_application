import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/Notifications/SetNotifications.dart';

class NotificationPage extends StatefulWidget {

  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
            onPressed: (){SetNotifications().showNotificationWithActions();}
          , child: Text('Action Noti')),
          ElevatedButton(
            onPressed: ()async {await SetNotifications().scheduleDailyNotification();},
            child: Text('10 am noti'),
          )
          ]),
      )
    );
  }
}