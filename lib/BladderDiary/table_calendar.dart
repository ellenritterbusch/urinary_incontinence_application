import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class Table_calendar extends StatefulWidget {
  const Table_calendar({super.key});

  @override
  State<Table_calendar> createState() => _Table_calendarState();
}

class _Table_calendarState extends State<Table_calendar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TableCalendar(
        firstDay:DateTime.utc(2024,01,01),
        lastDay: DateTime.utc(2030,01,01),
        focusedDay: DateTime.now(), 
        ),
    );
  }
}

