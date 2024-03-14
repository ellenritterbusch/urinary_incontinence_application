import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Accident_button.dart';

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
      Row(children: [Accident_Button(), No_Accident_Button()] 
      ),
    );
  }
}