import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:urinary_incontinence_application/Visualization/Bar_chart.dart';


DateTime today = DateTime.now();
class Table_calendar extends StatefulWidget {
  final CalendarFormat yourCalendarFormat;
  final Function(DateTime, DateTime) onDaySelected;

  const Table_calendar({super.key, required this.yourCalendarFormat, required this.onDaySelected}); //constructor requires calendar format

  @override
  State<Table_calendar> createState() => Table_calendarState();
   
} 

class Table_calendarState extends State<Table_calendar> {
  BarChart barchartManager = BarChart();

  void _onDaySelected(DateTime selectedDay){ //funktion der sætter den valgte dag til den dag der skal være i fokus
  setState(() {
    today = selectedDay;
    debugPrint('$today');
  });
  
}

  @override
  Widget build(BuildContext context) {
    return Container(
    
      child: TableCalendar(
        locale: "en_US",
        rowHeight: MediaQuery.of(context).size.height * 0.07,
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
        onDaySelected: widget.onDaySelected, 
        selectedDayPredicate: (day) => isSameDay(day, today),
        calendarFormat: widget.yourCalendarFormat,

      ),
    );
  }
}

