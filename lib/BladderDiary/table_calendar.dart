import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class Table_calendar extends StatefulWidget {
  const Table_calendar({super.key});

  @override
  State<Table_calendar> createState() => _Table_calendarState();
}

class _Table_calendarState extends State<Table_calendar> {
DateTime today = DateTime.now();

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
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        availableGestures: AvailableGestures.all,
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle),
           todayDecoration: BoxDecoration(
            color: Colors.transparent,
            //backgroundBlendMode: BlendMode.colorBurn,
            shape: BoxShape.circle),
            todayTextStyle: TextStyle(color: Colors.black)
           ),
        
        firstDay:DateTime.utc(2024,01,01),
        lastDay: DateTime.utc(2030,01,01),
        focusedDay: today,
        onDaySelected: _onDaySelected,
        selectedDayPredicate: (day) => isSameDay(day, today),
        ),
    );
  }
}

