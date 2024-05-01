import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/Notifications/SetNotifications.dart';
import 'package:provider/provider.dart';


class SwitchStateNotifier extends ChangeNotifier {
  bool _dailyreminderSwitch = false;
  DateTime? _selectedDate;

  bool get dailyreminderSwitch => _dailyreminderSwitch;
  DateTime? get selectedDate => _selectedDate;

  void toggleDailySwitch(bool value) {
    if (_dailyreminderSwitch != value) {
      _dailyreminderSwitch = value;
      notifyListeners();
      if (_dailyreminderSwitch) {
        callDailyNotification();
      }
    }
  }

  void updateSelectedtime(DateTime newTime) {
    _selectedDate = newTime;
    notifyListeners();
    if (_dailyreminderSwitch) {
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
