import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/DailyEvaluationPage/DailyEvaluationPage.dart';

class EvaluationButton extends StatefulWidget {
  final Color iconcolor;
  final IconData yourIcon;
  final Function() onPressed;
  //final int dailyEvaluation;


  const EvaluationButton({required this.iconcolor, required this.yourIcon, required this.onPressed});

@override
_EvaluationButtonState createState() => _EvaluationButtonState();
}

class _EvaluationButtonState extends State<EvaluationButton> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          onPressed: widget.onPressed,
         style:  ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width * 0.30, MediaQuery.of(context).size.width * 0.30),
          shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(23))),
          child: Icon(widget.yourIcon,  size: 60, color: widget.iconcolor),
          ),
      ),
      ]
    );
    
    
  }
}