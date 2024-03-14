import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/BladderDiaryPage.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Table_calendar.dart';
import 'package:urinary_incontinence_application/BladderDiary/DailyEvaluationPage/DailyEvaluationPage.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calendar"),
      ),
      body: 

      ////////// track and evaluate button //////////
      Column(
      children: [
        const Table_calendar(),         //Henviser til Table_calender klassen
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon( 
            onPressed: () {
              Navigator.push(
               context,
                MaterialPageRoute(builder: (context) => const DailyEvaluationPage()),
               );
            },
            icon: const Icon(Icons.add_reaction), 
            label: const Text("Evaluate")),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon(
            onPressed:() {
               Navigator.push(
               context,
                MaterialPageRoute(builder: (context) => const BladderDiaryPage()),
               );
            
            },
            icon: const Icon(Icons.add),
            label: const Text("Track")),
        )
      ],
      )
    );
  }
}