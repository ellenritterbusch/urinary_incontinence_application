import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/DailyEvaluationPage/DailyEvaluationPage.dart';

class Evaluate_button extends StatefulWidget {
  const Evaluate_button({super.key});

  @override
  State<Evaluate_button> createState() => _Evaluate_buttonState();
}

class _Evaluate_buttonState extends State<Evaluate_button> {
  @override
  Widget build(BuildContext context) {
      return ElevatedButton.icon( 
            onPressed: () {
              Navigator.push(
               context,
                MaterialPageRoute(builder: (context) => const DailyEvaluationPage('')),
               );
            },
            icon: const Icon(Icons.add_reaction_outlined,
            size: 30,), 
            label: const Text("Evaluate", 
            style: TextStyle(
              fontSize: 24
            ),),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width * 0.45, MediaQuery.of(context).size.height * 0.08),
            )
    );
  }
}