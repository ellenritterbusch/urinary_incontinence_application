import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Table_calendar.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Track_button.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Evaluate_button.dart';

class CalendarPage extends StatefulWidget {
  final String? payload;
  const CalendarPage({this.payload});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
        leading: null,
      ),
      body: 

      ////////// Opbygning af siden //////////
      const Column(
      children: [
        Table_calendar(yourCalendarFormat: CalendarFormat.month,),         //Henviser til Table_calender klassen
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Evaluate_button()     //Henviser til Evaluate_button klassen
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Track_button()       //Henviser til Track_button klassen
          )
      ],
      )
    );
  }
}