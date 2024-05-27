import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/Notifications/SetNotifications.dart';


class SwitchStateNotifier extends ChangeNotifier {
  bool dailyreminderSwitch = false;
  DateTime? _selectedDate;

  //bool get dailyreminderSwitch => dailyreminderSwitch;
  DateTime? get selectedDate => _selectedDate;

  void toggleDailySwitch(bool value) {
    if (dailyreminderSwitch != value) {
      dailyreminderSwitch = value;
      notifyListeners();
      if (dailyreminderSwitch) {
        callDailyNotification();
      }
    }
  }

  void updateSelectedtime(DateTime newTime) {
    _selectedDate = newTime;
    notifyListeners();
    if (dailyreminderSwitch) {
      callDailyNotification();
    }
  }

  void callDailyNotification() {
    // This is your notification function
    //debugPrint('Notification scheduled for $_selectedDate because switch is ON');
    SetNotifications().scheduleDailyNotification();
    // Trigger the notification logic here
  }
}