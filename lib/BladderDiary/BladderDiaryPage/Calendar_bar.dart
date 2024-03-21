// ignore: file_names
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/table_calendar.dart';

class Calender_Bar extends StatefulWidget {
  const Calender_Bar({super.key});

  @override
  State<Calender_Bar> createState() => _Calender_BarState();
}

class _Calender_BarState extends State<Calender_Bar> {
  @override
  Widget build(BuildContext context) {
    return const Table_calendar(yourCalendarFormat: CalendarFormat.week,);
  }
}