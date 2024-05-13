import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/Database/DatabaseManager.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Table_calendar.dart';

final GlobalKey<History_BoxState> historyBoxKey = GlobalKey<History_BoxState>();
class History_Box extends StatefulWidget {
  const History_Box({Key? key}) : super(key: key);

  @override
  State<History_Box> createState() => History_BoxState();
}

class History_BoxState extends State<History_Box> {
  dynamic amountAccident;
  dynamic stimType;
  dynamic stimTimeSetting;
  int accidentcounter = 0;
  int stimTypecounter = 0;
  int stimTimecounter = 0;
  late int hours;
  late int minutes;
  String totalStimTime = '';


  @override
  void initState() {
    super.initState();
    fetchBladderDiaryData(); // updates data when entering the page
  }

  void fetchBladderDiaryData()  async{
              String date = today.toString().substring(0 ,10); // fetch data from today auto
               
              accidentcounter = 0; // Resetting accidentcounter
              amountAccident = await DatabaseManager.databaseManager.getBladderDiaryAccident(date); // communication with database
              int amountAccidentlength = amountAccident.length;
              
              for (int i = 0; i< amountAccidentlength; i++) { // first value + next value +..+ in the length of amountAccident in database
                dynamic individualAccident = amountAccident[i];
                int accident = individualAccident['accident'];
               if (accident != 0) {
                 accidentcounter++;
               }
              } setState(() {
                accidentcounter = accidentcounter;
              },);

              stimTypecounter = 0; // Resetting stimTypecounter
              stimType = await DatabaseManager.databaseManager.getBladderDiaryStimType(date); // Retrieving data from the database
              int stimTypelength = stimType.length;

              for (int i = 0; i < stimTypelength; i++) { // first value + next value +..+ in the length of stimType in database
                dynamic individualStimType = stimType[i];
                int stim = individualStimType['stimtype']; 
              if (stim == 1) { // stimType 1 = On-demand
                stimTypecounter++;
               }
              } setState(() {
                stimTypecounter = stimTypecounter;
              });

             stimTimecounter = 0; // Resetting stimTimecounter
             stimTimeSetting = await DatabaseManager.databaseManager.getBladderDiaryStimTimeSetting(date); // Retrieving data from the database
             int stimTimeSettinglength = stimTimeSetting.length;

             for (int i = 0; i < stimTimeSettinglength; i++) { // first value + next value +..+ in the length of stimTime in database
              dynamic individualStimTimeSetting = stimTimeSetting[i];
              int stimTime = individualStimTimeSetting['stimtimesetting'];

              if (stimTime != 0) {
                stimTimecounter += stimTime;
              } if (stimTimecounter >= 60) {
                int hours = stimTimecounter ~/ 60; // Get the number of hours
                int minutes = stimTimecounter % 60; // Get the remaining minutes
                debugPrint('$hours hour(s) $minutes minutes');
                  setState(() {
                  stimTimecounter = stimTimecounter;
                  if (minutes == 0) {
                    totalStimTime = ('$hours hour(s)');
                  } else {
                    totalStimTime = ('$hours hour(s) $minutes minutes');
                    } 
                    }); 
                  } else {
                      minutes = stimTimecounter;
                    setState(() {
                      totalStimTime = ('$minutes minutes');
                    });
                    }
            } 
  }

  @override
  Widget build(BuildContext context) { // History box start with headline "History"
    return Column( 
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
        const SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),),
            Text('History', style:
            TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 2, 80, 144))),
          ]
        ),
          SizedBox( // the box itself
            width: 350,
            height: 270.0,
          child: Card(
            color: const Color.fromARGB(255, 242, 245, 248),
            child: Row( 
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),),
              
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [
                  Text('Accidents', style: //printer antal accidents
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 2, 80, 144)),),
                  Text('$accidentcounter', style:
                    TextStyle(fontSize: 30, fontWeight: FontWeight.normal, color: Color.fromARGB(255, 2, 80, 144)),),
                    Padding(
                      padding: EdgeInsets.all(8.0)),
                  Text('On-demand stimulations', style: //printer antal on demand stimuleringer
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 2, 80, 144)),),
                  Text('$stimTypecounter', style: //
                    TextStyle(fontSize: 30, fontWeight: FontWeight.normal, color: Color.fromARGB(255, 2, 80, 144)),),
                    Padding(
                      padding: EdgeInsets.all(8.0)),
                  Text('Continous stimulation', style: //printer samlede tid continous stimulering
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 2, 80, 144)),),
                  Text(totalStimTime, style: //
                    TextStyle(fontSize: 30, fontWeight: FontWeight.normal, color: Color.fromARGB(255, 2, 80, 144)),),
          ],
          ),
                //VerticalDivider( //den lodrette linje der skiller information i boxen
                  //width: 100,
                  //thickness: 2,
                  //indent: 0,
                  //endIndent: 0,
                  //color: Color.fromARGB(255, 40, 85, 162),),

             // const Column(
              //  mainAxisAlignment: MainAxisAlignment.center,
               // crossAxisAlignment: CrossAxisAlignment.center,
                 // Text('Use of app', style:
                   // TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                 // Padding(
                   // padding: EdgeInsets.all(20.0)),
                 // Text('1h 3min', style:
                   // TextStyle(fontSize: 18, fontWeight: FontWeight.normal),),),],
              //)
            ]   
          )
          )
    )
          ]
    );
    // children 
  }
}