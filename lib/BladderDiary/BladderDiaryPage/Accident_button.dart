import 'package:flutter/material.dart';



class Accident_Button extends StatefulWidget {
  final Function() onPressed;
  final String accidentText;
  final Icon icon;
  final Color bordercolor;


  const Accident_Button({Key? key, required this.onPressed, required this.accidentText,
   required this.icon, required this.bordercolor}): super(key:key);

  @override
  State<Accident_Button> createState() => _Accident_ButtonState();
}

// Accident Button //
class _Accident_ButtonState extends State<Accident_Button> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width * 0.38,MediaQuery.of(context).size.height * 0.20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
        side: BorderSide(color: widget.bordercolor)
        ),
        onPressed: widget.onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.accidentText, 
                style: TextStyle(fontSize: 15, color: Colors.black),
                textAlign: TextAlign.start,
                ),
                widget.icon,
            ]
          ),
    );
  }
  
}


class No_Accident_Button extends StatefulWidget {
  final Function() onPressed;
  final String accidentText;
  final Icon icon;
  final Icon stackIcon;
  final Color bordercolor;


  No_Accident_Button({Key? key, required this.onPressed, required this.accidentText,
   required this.icon, required this.bordercolor, required this.stackIcon}): super(key:key);

  @override
  State<No_Accident_Button> createState() => _No_Accident_ButtonState();
}

// Accident Button //
class _No_Accident_ButtonState extends State<No_Accident_Button> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width * 0.38,MediaQuery.of(context).size.height * 0.20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
        side: BorderSide(color: widget.bordercolor)
        ),
        onPressed: widget.onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.accidentText, 
                style: TextStyle(fontSize: 15, color: Colors.black),
                textAlign: TextAlign.start,
                ),
                Stack(
                  alignment: Alignment.center,
                    children: [
                    widget.stackIcon,  
                    widget.icon,
                  ],
                )
            ]
          ),
    );
  }
  
}




