import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const double _kItemExtent = 32.0;
List <int> timeOnDemand = <int> [
  0,
  1,
  3,
  5,
  1,
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
  int _selectedTime = 0;
  DateTime _selectedTid =  DateTime.now();

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
                  setState(() {
                    _allnotifications = value!;
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
              setState(() {
                _dailyreminder = value!;                                          //ON/OFF daily reminder
                _allnotifications = value ? value==true : value==false;                                       //ON/OFF ALLE NOTIFIKATIONer
              });
            },
          ),
          ListTile(                                                             //Reminder time
              title: const Text('Daily evaluation reminder time', style: TextStyle(fontWeight: FontWeight.bold)),
              isThreeLine: true,
              subtitle:
                  const Text('Enter desired time of the day to receive the daily evaluation reminder'),
              trailing: CupertinoButton(
                child: Text('${(_selectedTid.hour < 10) ? ('0${_selectedTid.hour}') : ('${_selectedTid.hour}')}:${(_selectedTid.minute < 10) ? ('0${_selectedTid.minute}') : '${_selectedTid.minute}'}', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,)),           //Tekst viser time og minut af newTime/_Selectid //Genovervej bold.
                onPressed: () => _showDialog(
                      CupertinoDatePicker(
                        initialDateTime: _selectedTid,
                        mode: CupertinoDatePickerMode.time,
                        //minuteInterval: 10,
                        use24hFormat: true,
                        // This shows day of week alongside day of month
                        showDayOfWeek: false,
                        // This is called when the user changes the date.
                        onDateTimeChanged: (DateTime newTime) {
                          setState(() => _selectedTid = newTime);
                        },
                      ),
                ),
              ),
            ),




          const Divider(height: 10,),          //Tilføjer mellemrum mellem, således at der kommer en streg



                                                 //////////////////////////////// After ON-DEMAND stimuli ////////////////////////////////
          SwitchListTile(
            activeColor: Colors.white,                                                                      //Gør switch hvid
            activeTrackColor: Colors.green,                                                                 //Gør indre switch grøn ved aktiv
            tileColor: Colors.white,                                                                        //Gør tile hvid  
            title: const Text('Notification after on-demand', style: TextStyle(fontWeight: FontWeight.bold)), //Titel
            subtitle: const Text('Receive a notification after using the on-demand function with UCon'),      //Subtitel
            isThreeLine: true,
            value: _ondemand,                                                                                 //Switch value
            onChanged: (bool? value) {                                                                        //Hvad der sker når ændret
              setState(() {
                _ondemand = value!;
                _allnotifications = value ? value==true : value==false;  
              });
            },
          ),
          ListTile(
              title: const Text('Time after on-demand', style: TextStyle(fontWeight: FontWeight.bold)),                      
              subtitle:
                  const Text('Choose how long after an on-demand stimulation, you want to receive a notification'),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                                              // Display a CupertinoPicker with list of options.
                onPressed: () => _showDialog(
                  CupertinoPicker(
                    useMagnifier: false,
                    itemExtent: _kItemExtent,
                                              // This sets the initial item.
                    scrollController: FixedExtentScrollController(
                      initialItem: _selectedTime,
                    ),
                                             // This is called when selected item is changed.
                    onSelectedItemChanged: (int selectedItem) {
                      setState(() {
                        _selectedTime = selectedItem;
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
                  '${_selectedTime == 0 ? 'Instant' : '${timeOnDemand[_selectedTime]}'} ${_selectedTime == 0 ? ' ' : _selectedTime <=3 ? 'min' : 'hours'}',
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
  // DateTime getDateTime() {
  //   final now = DateTime.now();
  //   return DateTime(now.year, now.month, now.day, now.hour, 15);
  // }

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
