import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/Database/DatabaseManager.dart';
import 'package:urinary_incontinence_application/Database/DatabaseModel.dart';
import 'package:urinary_incontinence_application/Notifications/SetNotifications.dart';

DatabaseModel databaseModelNoti = DatabaseModel.Noti(true, true, true);

const double _kItemExtent = 32.0;
List <int> timeOnDemand = <int> [
  0, //Instant
  1,
  3,
  5,
  1, //change to hours
  2,
  4,
  6,
  8,
  12,
];
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
    print("Listening to notification");
    SetNotifications.onClickNotification.stream.listen((event) {
      print(event);
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
  bool _allnotifications = false;     //Value for 
  bool _dailyreminder = false;        //Value for daily reminder switch
  bool _ondemand = false;             //Value for on-demand
  int _selectedOnDemandTime = 0;
  DateTime _selectedDailyEvTime =  DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
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
                value: _allnotifications,                                                                    //Switch value
                onChanged: (bool? value) {
                  setState(() async {
                    //databaseModelNoti.noti_all = true; 

                      //insert to database
                      await DatabaseManager.databaseManager.insertNotification(databaseModelNoti);
                      debugPrint('data is sucessfully inserted');
                      final _allnoti = await DatabaseManager.databaseManager.getNotification();
                      debugPrint('$_allnoti');

                    _allnotifications = value!;           //Ved ændring skift alle switch værdier
                    _dailyreminder = value;
                    _ondemand = value; 

                  });
                },
              ),



          const Divider(height: 10),              //Tilføjer mellemrum mellem, således at der kommer en streg



                                                       ///////////////////////7///// Daily evaluation reminder ////////////////////////

          SwitchListTile( 
            activeColor: Colors.white,                            //Gør switch hvid
            activeTrackColor: Colors.green,                       //Gør indre switch grøn ved aktiv
            tileColor: Colors.white,                              //Gør tile hvid                    
            title: const Text('Daily evaluation reminder', style: TextStyle(fontWeight: FontWeight.bold)),                           //Titel
            subtitle: const Text('Receive notification for the daily reminder'),      //Subtitel
            value: _dailyreminder,                                                 //Switch value
            onChanged: (bool? value) {
              setState(() async {
                //insert to database
                await DatabaseManager.databaseManager.insertNotification(databaseModelNoti);
                debugPrint('data is sucessfully inserted');
                final _dailyremind = await DatabaseManager.databaseManager.getNotification();
                debugPrint('$_dailyremind');

                _dailyreminder = value!;                                          //ON/OFF daily reminder
                _allnotifications = value ? value==true : value==false;           //ON/OFF ALLE NOTIFIKATIONer = Hvis value er true, så gør den falsk.
              });
            },
          ),
          ListTile(                                                             //Reminder time
              title: const Text('Daily evaluation reminder time', style: TextStyle(fontWeight: FontWeight.bold)),     //Titel
              isThreeLine: true,                                                                                      //Makes it big enough for 3 lines of text
              subtitle:
                  const Text('Enter desired time of the day to receive the daily evaluation reminder'),               //Subtitle
              trailing: CupertinoButton(                                                                              //Textbutton in cupertinostyle like iphone
                child: Text('${(_selectedDailyEvTime.hour < 10) ? ('0${_selectedDailyEvTime.hour}') : ('${_selectedDailyEvTime.hour}')}:${(_selectedDailyEvTime.minute < 10) ? ('0${_selectedDailyEvTime.minute}') : '${_selectedDailyEvTime.minute}'} ${(_selectedDailyEvTime.hour > 12) ? 'PM' : 'AM'}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,)),           //Tekst viser time og minut af newTime/_Selectid //Genovervej bold.
                onPressed: () => _showDialog(
                      CupertinoDatePicker(        //Opens white box in bottom of page
                        initialDateTime: _selectedDailyEvTime,        //Starts on selected time 
                        mode: CupertinoDatePickerMode.time,   //No date, only time
                        //minuteInterval: 10,
                        use24hFormat: true,                   //24h format
                        // This shows day of week alongside day of month
                        showDayOfWeek: false,
                        // This is called when the user changes the date:
                        onDateTimeChanged: (DateTime newTime) {
                          setState(() => _selectedDailyEvTime = newTime);
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
            onChanged: (bool? value) {                                                                        //What happens when changed
              setState(() async {
                      //insert to database
                      await DatabaseManager.databaseManager.insertNotification(databaseModelNoti);
                      debugPrint('data is sucessfully inserted');
                      final ondemandnoti = await DatabaseManager.databaseManager.getNotification();
                      debugPrint('$ondemandnoti');

                _ondemand = value!;                                                                           //Changes switch value
                _allnotifications = value ? value==true : value==false;                                       //Turns on all notifications, if off
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
