// ignore: file_names
import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/accident_button.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Calendar_bar.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Time_picker.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Save_button.dart';


class BladderDiaryPage extends StatefulWidget {
  const BladderDiaryPage({super.key});

  @override
  State<BladderDiaryPage> createState() => _BladderDiaryState();
}

class _BladderDiaryState extends State<BladderDiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bladder Diary"),
      ),
      body:     
  
    
    // Track Button navigates to Bladder Diary //
      const Column(
      children: [
        Calender_Bar(), 
        Padding(
        padding: EdgeInsets.all(20.0)), 
        Row(mainAxisAlignment: MainAxisAlignment.center,
          children:[ 
            AccidentButton(),
            Padding(
            padding: EdgeInsets.all(8.0)),
            NoAccidentButton(),    
        ]
        ),
        TimePicker(),
        Padding(
          padding: EdgeInsets.all(40.0)),
        Save_Button(),
      ]),
         );
  }
  }
       
      