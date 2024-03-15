import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/BladderDiaryPage.dart';

class Track_button extends StatelessWidget {
  const Track_button({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(200, 80)
            ),
            onPressed:() {
            
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