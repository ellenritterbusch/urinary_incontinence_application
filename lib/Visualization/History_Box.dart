import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/Database/DatabaseManager.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Table_calendar.dart';
import 'package:urinary_incontinence_application/Visualization/CreateFakeData.dart';


class History_Box extends StatefulWidget {
  const History_Box({Key? key}) : super(key: key);

  @override
  State<History_Box> createState() => _History_BoxState();
}

class _History_BoxState extends State<History_Box> {
  dynamic amountAccident;
  int accidentcounter = 0;
  dynamic stimType;
  int stimTypecounter = 0;
  dynamic stimTimeSetting;
  int stimTimecounter = 0;
  late int hours;
  late int minutes;
  String totalStimTime = '';


  @override
  void initState() {
    super.initState();
    updateData();
  }

  void updateData()  async{
              String date = today.toString().substring(0 ,10);
              debugPrint(date);
               
              accidentcounter = 0; // accidentcounter
              amountAccident = await DatabaseManager.databaseManager.getBladderDiaryAccident(date); //snak med database
              int amountAccidentlength = amountAccident.length;
                //debugPrint('$accidentcounter');
              for (int i = 0; i< amountAccidentlength; i++) {
                dynamic individualAccident = amountAccident[i];
                int accident = individualAccident['accident'];
                //debugPrint('$accident'); 
               if (accident != 0) {
                 accidentcounter++;
               }
              } setState(() {
                accidentcounter = accidentcounter;
              },);
              //debugPrint('$accidentcounter');

              stimTypecounter = 0; // Resetting stimTypecounter
              stimType = await DatabaseManager.databaseManager.getBladderDiaryStimType(date); // Retrieving data from the database
              //debugPrint('$stimType');
              int stimTypelength = stimType.length;
              for (int i = 0; i < stimTypelength; i++) {
                dynamic individualStimType = stimType[i];
                int stim = individualStimType['stimtype']; // Renamed to avoid conflict
                  //debugPrint('$stimType'); 
              if (stim == 1) {
                stimTypecounter++;
               }
              } setState(() {
                stimTypecounter = stimTypecounter;
              });
              //debugPrint('$stimTypecounter');


             stimTimecounter = 0; // Resetting stimTimecounter
             stimTimeSetting = await DatabaseManager.databaseManager.getBladderDiaryStimTimeSetting(date); // Retrieving data from the database
             //debugPrint('$stimTimeSetting');
             int stimTimeSettinglength = stimTimeSetting.length;
             for (int i = 0; i < stimTimeSettinglength; i++) {
              dynamic individualStimTimeSetting = stimTimeSetting[i];
              int stimTime = individualStimTimeSetting['stimtimesetting'];
                debugPrint('$stimTimeSetting');
              if (stimTime != 0) {
                stimTimecounter += stimTime;
              }
              if (stimTimecounter >= 60) {
                int hours = stimTimecounter ~/ 60; // Get the number of hours
                int minutes = stimTimecounter % 60; // Get the remaining minutes
                debugPrint('$hours hour(s) $minutes minutes');
                  setState(() {
                  stimTimecounter = stimTimecounter;
                   if (minutes == 0) {
                    totalStimTime = ('$hours hour(s)');
                }  else {
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
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [    //const Data_Button(), kan indkommenteres hvis vi skal hente data fra i dag
        SizedBox(height: 20),
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),),
            Text('History', style:
            TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 2, 80, 144))),
          ]
        ),
          SizedBox(
            width: 350,
            height: 300.0,
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
                    TextStyle(fontSize: 35, fontWeight: FontWeight.normal, color: Color.fromARGB(255, 2, 80, 144)),),
                    Padding(
                      padding: EdgeInsets.all(8.0)),
                  Text('On-demand stimulations', style: //printer antal on demand stimuleringer
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 2, 80, 144)),),
                  Text('$stimTypecounter', style: //
                    TextStyle(fontSize: 35, fontWeight: FontWeight.normal, color: Color.fromARGB(255, 2, 80, 144)),),
                    Padding(
                      padding: EdgeInsets.all(8.0)),
                  Text('Continous stimulation', style: //printer samlede tid continous stimulering
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 2, 80, 144)),),
                  Text(totalStimTime, style: //
                    TextStyle(fontSize: 35, fontWeight: FontWeight.normal, color: Color.fromARGB(255, 2, 80, 144)),),
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