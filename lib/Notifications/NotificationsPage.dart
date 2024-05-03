import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:urinary_incontinence_application/Database/DatabaseManager.dart';
import 'package:urinary_incontinence_application/Database/DatabaseModel.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Table_calendar.dart';
import 'package:urinary_incontinence_application/Notifications/SetNotifications.dart';
import 'package:urinary_incontinence_application/Notifications/SwitchStateNotifier.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

DatabaseModel databaseModelNoti = DatabaseModel.Noti(1,2,2,2);

const double _kItemExtent = 32.0;
List <int> timeOnDemand = <int> [
  0,1,3,5,1,2,4,6,8,12,];
class NotificationPage extends StatefulWidget {

  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  @override
  void initState(){
  listenToNotifications();  
  super.initState();
  }

  listenToNotifications() {
    debugPrint("Listening to notification");
    SetNotifications.onClickNotification.stream.listen((event) {
      debugPrint(event);
      Navigator.pushNamed(context, '/CalendarPage', arguments: event);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body:  const Center(
        child: NotificationsSettings(), 
      ),
    );
  }
}


class NotificationsSettings extends StatefulWidget {
  const NotificationsSettings({super.key});

  @override
  State<NotificationsSettings> createState() => _NotificationsSettings();
  
}

class _NotificationsSettings extends State<NotificationsSettings> {
  bool allnotifications = false;     //Value for all notification switch
  bool _dailyreminder = false;        //Value for daily reminder switch
  bool _ondemand = false;             //Value for on-demand
  //DateTime selectedDailyEvTime =  DateTime.now();
  DateTime selectedDailyEvTime = DateTime(today.year, today.month, today.day, 20, 0);
  int _selectedOnDemandTime = 3;
  DatabaseModel? get noti_ondemand => null;

    @override
    void initState(){
    super.initState();
    fetchSavedNotificationSettings(); 
    }

   Future<void> fetchSavedNotificationSettings() async {
    final changedAllNoti = await DatabaseManager.databaseManager.getAllNotification();
    final changedDailyNoti = await DatabaseManager.databaseManager.getDailyNotification();
    final allNotiList = changedAllNoti[0];
    final dailyNotiList = changedDailyNoti[0];
    final allNotiValue = allNotiList['allnotification'];
    final dailyNotiValue = dailyNotiList['dailynotification'];
    debugPrint('$allNotiValue');
    if (allNotiValue == 1){
      setState(() {
        allnotifications = true;
        _dailyreminder = true;
        _ondemand = true;
      });
      } else {
        setState(() {
          allnotifications = false;
        _dailyreminder = false;
        _ondemand = false;
        }); }
    if (dailyNotiValue == 1){
      setState(() {
        _dailyreminder = true;
      }); 
      } else{
        setState(() {
          _dailyreminder = false;
        });
      }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SwitchStateNotifier>(        //Den holder øje med om notification er on eller ej
        builder: (context, state, child){
          return Column(
          children: [
          const Divider(height: 20),              //Tilføjer mellemrum mellem, således at der kommer en streg
                                                  //////////////////////////////// PROFILE TAB I TOPPEN ///////////////////////////////////////////7
        ListTile(
          tileColor: Colors.white,
          title: const Text('Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,)),       //Profil tekst
          leading: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),                                      //Cirkelform
              padding: const EdgeInsets.all(20),
              backgroundColor: Colors.grey,                                     // <-- Button color
              foregroundColor: Colors.blueGrey,                                 // <-- Splash color
            ),
            child: const Icon(Icons.person, color: Colors.black),                //Person icon
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 22,),                //Pil icon
        ),

          const Divider(height: 10),              //Tilføjer mellemrum mellem, således at der kommer en streg


                                                      ///////////////////////////// Slå alle notifikationer til ////////////////////
          SwitchListTile(        
                activeColor: Colors.white,                      //Gør switch hvid
                activeTrackColor: Colors.green,                 //Gør indre switch grøn ved aktiv
                tileColor: Colors.white,                        //Gør tile hvid    
                title: const Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),           //Titel
                subtitle: const Text('Receive all notifications'),                                            //Subtitel
                value: allnotifications,                                                                   //Switch value
                onChanged: (bool? value) async {

                      if (allnotifications == true) {
                        databaseModelNoti.noti_all = 2;
                        } 
                      if (allnotifications == false) {
                          databaseModelNoti.noti_all = 1; 
                        }
                      
                      final allnoti = await DatabaseManager.databaseManager.getAllNotification();
                      if (allnoti.isEmpty){
                        await DatabaseManager.databaseManager.insertNotifications(databaseModelNoti);
                      } else  {
                      await DatabaseManager.databaseManager.updateAllNotification(databaseModelNoti);
                      debugPrint('data is first $allnoti');
                      final allnoti2 = await DatabaseManager.databaseManager.getAllNotification();
                      debugPrint('data is now $allnoti2');
                      }
                    
                  setState(()  {
                    allnotifications = value!;           //Ved ændring skift alle switch værdier
                   state.toggleDailySwitch(value);
                    _ondemand = value; }                  );
                }),


          const Divider(height: 10),              //Tilføjer mellemrum mellem, således at der kommer en streg


                                              //////////////////////////// Daily evaluation reminder ////////////////////////

          SwitchListTile( 
            activeColor: Colors.white,                            //Gør switch hvid
            activeTrackColor: Colors.green,                       //Gør indre switch grøn ved aktiv
            tileColor: Colors.white,                              //Gør tile hvid                    
            title: const Text('Daily evaluation reminder', style: TextStyle(fontWeight: FontWeight.bold)),                           //Titel
            subtitle: const Text('Receive notification for the daily reminder'),      //Subtitel
            value: state.dailyreminderSwitch,                                                 //Switch value
            onChanged: (value) async {
              state.toggleDailySwitch(value);
                if (_dailyreminder == true) {
                  databaseModelNoti.noti_eva = 2;
                } else {
                  databaseModelNoti.noti_eva = 1; 
                  } 
                      
                  final evaNoti = await DatabaseManager.databaseManager.getDailyNotification();
                  if(evaNoti.isEmpty){
                    await DatabaseManager.databaseManager.insertNotifications(databaseModelNoti);
                    debugPrint('data is sucessfully inserted');
                  } else {
                    final evaNotiNew = await DatabaseManager.databaseManager.updateDailyNotification(databaseModelNoti);
                    debugPrint('daily reminder is now $evaNotiNew'); 
                    }
              setState(()  {
                _dailyreminder = value!;                                          //ON/OFF daily reminder
              //  allnotifications = value ? value==true : value==false;           //ON/OFF ALLE NOTIFIKATIONer = Hvis value er true, så gør den falsk.
              });
            },
          ),
          ListTile(                                                             //Reminder time
              title: const Text('Daily evaluation reminder time', style: TextStyle(fontWeight: FontWeight.bold)),     //Titel
              isThreeLine: true,                                                                                      //Makes it big enough for 3 lines of text
              subtitle:
                  const Text('Enter desired time of the day to receive the daily evaluation reminder'),               //Subtitle
              trailing: CupertinoButton(                                                                              //Textbutton in cupertinostyle like iphone
                child: Text('${(selectedDailyEvTime.hour < 10) ? ('0${selectedDailyEvTime.hour}') : ('${selectedDailyEvTime.hour}')}:${(selectedDailyEvTime.minute < 10) ? ('0${selectedDailyEvTime.minute}') : '${selectedDailyEvTime.minute}'} ${(selectedDailyEvTime.hour > 12) ? 'PM' : 'AM'}',
                style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,)),           //Tekst viser time og minut af newTime/_Selectid //Genovervej bold.
                onPressed: () => _showDialog(
                      CupertinoDatePicker(        //Opens white box in bottom of page
                        initialDateTime: selectedDailyEvTime,        //Starts on selected time 
                        mode: CupertinoDatePickerMode.time,   //No date, only time
                        //minuteInterval: 1,
                        use24hFormat: true,                   //24h format
                        // This shows day of week alongside day of month
                        showDayOfWeek: false,
                        // This is called when the user changes the date:
                        onDateTimeChanged: (DateTime newTime) {
                          setState(() => selectedDailyEvTime = newTime);
                          dailyReminderHour = selectedDailyEvTime.hour;
                          dailyReminderMin = selectedDailyEvTime.minute;
                          state.updateSelectedtime(newTime);
                        },
                      ),
                ),
              ),
            ),


          const Divider(height: 10,),          //Tilføjer mellemrum mellem, således at der kommer en streg


                                                 //////////////////////////////// After ON-DEMAND stimuli ////////////////////////////////
          SwitchListTile(
            activeColor: Colors.white,                                                                      //Make switch white 
            activeTrackColor: Colors.green,                                                                 //Make switch green when active
            tileColor: Colors.white,                                                                        //Make tile white 
            title: const Text('Notification after on-demand', style: TextStyle(fontWeight: FontWeight.bold)), //Titel
            subtitle: const Text('Receive a notification after using the on-demand function with UCon'),      //Subtitel
            isThreeLine: true,                                                                                //Makes it three lines of text worthy
            value: _ondemand,                                                                                 //Switch value
            onChanged: (bool? value) async {     
                      databaseModelNoti.noti_ondemand = 1; 

                      if (_ondemand == true) {
                        databaseModelNoti.noti_ondemand = 1;
                        } else {
                          databaseModelNoti.noti_ondemand = 0; 
                        }
                      
                       final ondemandnoti = await DatabaseManager.databaseManager.getOnDemandNotification();
                      if(ondemandnoti == databaseModelNoti.noti_ondemand){
                        await DatabaseManager.databaseManager.insertNotifications(databaseModelNoti);
                        debugPrint('data is sucessfully inserted');
                      } else {
                        await DatabaseManager.databaseManager.updateOnDemandNotification(databaseModelNoti);
                        debugPrint('data is sucessfully updated');
                      }
                      
                      debugPrint('ondemandnoti = $ondemandnoti');
                      debugPrint('noti_ondemand = ${databaseModelNoti.noti_ondemand}');

                                                                                 //What happens when changed
              setState(()  {
                  
                _ondemand = value!;                                                                           //Changes switch value
               // _allnotifications = value ? value==false : value==true;                                       //Turns on all notifications, if off
              });
            },
          ),
          ListTile(
              title: const Text('Time after on-demand', style: TextStyle(fontWeight: FontWeight.bold)),                   //Title                
              subtitle:
                  const Text('Choose how long after an on-demand stimulation, you want to receive a notification'),       //Subtitle
              trailing: CupertinoButton(                                                                                  //Iphone text button
                padding: EdgeInsets.zero,
                                              // Display a CupertinoPicker with list of options.
                onPressed: () => _showDialog(
                  CupertinoPicker(
                    useMagnifier: false,
                    itemExtent: _kItemExtent,
                                              // This sets the initial item.
                    scrollController: FixedExtentScrollController(
                      initialItem: _selectedOnDemandTime,           //Starts with selectedtime
                    ),
                                             // This is called when selected item is changed.
                    onSelectedItemChanged: (int selectedItem) {
                      setState(() {
                        _selectedOnDemandTime = selectedItem;    
                      });
                    },
                    children:
                        List<Widget>.generate(timeOnDemand.length, (int index) {
                      return Center(child: Text('${timeOnDemand[index]}'));             
                    }),
                  ),
                ),
                                             // This displays the selected time name:
                child: Text(
                  '${_selectedOnDemandTime == 0 ? 'Instant' : '${timeOnDemand[_selectedOnDemandTime]}'} ${_selectedOnDemandTime == 0 ? ' ' : _selectedOnDemandTime <=3 ? 'min' : 'hours'}',
                  style: const TextStyle(
                    //fontSize: 19.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,                      //Genovervej
                  ),
                ),
              ),
              isThreeLine: true,
            ),

            const Divider(height: 10,),

        ]
      ); }
      )
    );
  }


    void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

}
