import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/DailyEvaluationPage/DailyEvaluationPage.dart';

class EvaluationButton extends StatefulWidget {
  final Color iconcolor;
  //final bool visibility;
 // final Function setState;
  //final int dailyEvaluation;


  const EvaluationButton({required this.iconcolor});

@override
_EvaluationButtonState createState() => _EvaluationButtonState();
}

class _EvaluationButtonState extends State<EvaluationButton> {

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed:() {setState(() {
        //isVisible = widget.visibility;
        //widget.setState();
          });},
         style:  ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width * 0.25, MediaQuery.of(context).size.width * 0.25),
          shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(23))),
          child: Icon(
        Icons.sentiment_satisfied_rounded, size: 80, color: widget.iconcolor),
          ),
      ),
      ]
    );
    
    
  }
}