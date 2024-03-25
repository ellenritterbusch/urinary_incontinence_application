import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/DailyEvaluationPage/DailyEvaluationPage.dart';

class EvaluationButton extends StatefulWidget {
  final Color iconcolor;
  final Color bordercolor;
  final IconData yourIcon;
  final Function() onPressed;


  const EvaluationButton({required this.iconcolor, required this.bordercolor, required this.yourIcon, required this.onPressed});

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
            side: BorderSide(
              color: widget.bordercolor
          ), 
          fixedSize: Size(MediaQuery.of(context).size.width * 0.35, MediaQuery.of(context).size.width * 0.35),
          shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(23))),
          child: Icon(widget.yourIcon,  size: 80, color: widget.iconcolor),
          ),
      ),
      ]
    );
    
    
  }
}