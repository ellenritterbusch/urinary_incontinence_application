import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Table_calendar.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Track_button.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Evaluate_button.dart';

class CalendarPage extends StatefulWidget {
  final String? payload;
  const CalendarPage({super.key, this.payload});

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
      body: Column(
      children: [
        Table_calendar(                                           //Instance of Table_Calendar
          yourCalendarFormat: CalendarFormat.month,
          onDaySelected: (DateTime newdate, DateTime focusedDay){
            setState(() {
            today = newdate;
            debugPrint('$today');
            });
          }),        
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Evaluate_button()     //Instance of Evaluate_button
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Track_button()       //Instance of Track_button 
          )
      ],
      )
    );
  }
}