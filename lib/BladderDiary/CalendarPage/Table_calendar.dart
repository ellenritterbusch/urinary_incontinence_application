import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

//global variables//
DateTime today = DateTime.now();

class Table_calendar extends StatefulWidget {
  final CalendarFormat yourCalendarFormat;
  //final double? yourRowHeight;

  const Table_calendar({super.key, required this.yourCalendarFormat});

  @override
  State<Table_calendar> createState() => _Table_calendarState();
} 

class _Table_calendarState extends State<Table_calendar> {

void _onDaySelected(DateTime day, DateTime focusedDay){ //funktion der sætter den valgte dag til den dag der skal være i fokus
  setState(() {
    today = day;
  });
}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TableCalendar(
        locale: "en_US",
        rowHeight: 50,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        availableGestures: AvailableGestures.all,

        ///Udseende detaljer///
        calendarStyle: CalendarStyle(     
          selectedDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle),
           todayDecoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(),
            shape: BoxShape.circle),
            todayTextStyle: const TextStyle(
              color: Colors.black)
           ),
        
        ///day specifications///
        firstDay:DateTime.utc(2024,01,01),
        lastDay: DateTime.now(),
        focusedDay: today,
        onDaySelected: _onDaySelected,
        selectedDayPredicate: (day) => isSameDay(day, today),

        calendarFormat: widget.yourCalendarFormat,

        ),
    );
  }
}

