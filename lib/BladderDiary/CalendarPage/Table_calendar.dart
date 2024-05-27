import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';



DateTime today = DateTime.now();          //global variable used for the current date and time
class Table_calendar extends StatefulWidget {
  final CalendarFormat yourCalendarFormat;      //used to instansiate the class with a weekly format
  final Function(DateTime, DateTime) onDaySelected;   //used to call a fuction that sets the selected day to the new current day

  const Table_calendar({super.key, required this.yourCalendarFormat, required this.onDaySelected}); 

  @override
  State<Table_calendar> createState() => Table_calendarState();
   
} 

class Table_calendarState extends State<Table_calendar> {

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
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
      firstDay:DateTime.utc(2024,01,01),  //randomly sat to the first day of this year
      lastDay: DateTime.now(),            //ensure that a future day cannot be picked
      focusedDay: today,
      onDaySelected: widget.onDaySelected,    
      selectedDayPredicate: (day) => isSameDay(day, today),
      calendarFormat: widget.yourCalendarFormat,
    
    );
  }
}

