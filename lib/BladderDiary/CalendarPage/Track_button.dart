import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/BladderDiaryPage.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/table_calendar.dart';

class Track_button extends StatefulWidget {
  const Track_button({super.key});

  @override
  State<Track_button> createState() => _Track_buttonState();
}

class _Track_buttonState extends State<Track_button>{
 @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(150, 80)
            ),
            onPressed:() {
            debugPrint(today.toString());
            Navigator.push(
               context,
                MaterialPageRoute(builder: (context) => const BladderDiaryPage()),
               );
            },
            icon: const Icon(Icons.add,
            size: 30,),
            label: const Text("Track",
            style: TextStyle(
              fontSize: 24
            ),
            ),
          );
  }
}