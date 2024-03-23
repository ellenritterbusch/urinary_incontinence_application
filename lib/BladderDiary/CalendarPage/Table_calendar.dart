import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/CalendarPage.dart';

//global variables//
DateTime today = DateTime.now();

class Table_calendar extends StatefulWidget {
  final CalendarFormat yourCalendarFormat;

  const Table_calendar({super.key, required this.yourCalendarFormat}); //constructor requires calendar format

  @override
  State<Table_calendar> createState() => _Table_calendarState();
   
} 

class _Table_calendarState extends State<Table_calendar> {
   TextEditingController _evaluationController = TextEditingController();
  //store the evaluations created
  Map<DateTime, List<Evaluation>> evaluations = {};
  late final ValueNotifier<List<Evaluation>> _selectedEvaluation;

  @override
  void initState(){
    super.initState();
    _selectedEvaluation = ValueNotifier(getEvaluationForDay(today));
  }

  List<Evaluation> getEvaluationForDay(DateTime day) {
    return evaluations[day] ?? [];
  }

void _onDaySelected(DateTime selectedDay, DateTime focusedDay){ //funktion der sætter den valgte dag til den dag der skal være i fokus
  setState(() {
    today = selectedDay;
  });
}

  @override
  Widget build(BuildContext context) {
    return Container(
      // floatingActionButton: FloatingActionButton(
      //       onPressed:() {
      //         showDialog(context: context, 
      //         builder: (context){
      //           return AlertDialog(
      //             content: TextField(controller: _evaluationController),
      //             actions: [
      //               ElevatedButton(
      //                 onPressed: (){
      //                   //store the evaluation into the map
      //                   evaluations.addAll({today!: [Evaluation(_evaluationController.text)]});
      //                   Navigator.of(context).pop();
      //                 },
      //                 child: Text('submit'),)
      //             ],
      //           );
      //         }
      //         );
      //       },
      //       child: Icon(Icons.add),
      //     ),
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
        onDaySelected: _onDaySelected,
        selectedDayPredicate: (day) => isSameDay(day, today),

        calendarFormat: widget.yourCalendarFormat,

        //builders
        // calendarBuilders: CalendarBuilders(
        //   markerBuilder:
        // ),

      ),
    );
  }
  

}

class Evaluation {
  final String title;
  Evaluation(this.title);
}

