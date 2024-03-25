import 'package:flutter/material.dart';


class Accident_Button extends StatefulWidget {
  //final Function() onPressed;
  const Accident_Button({super.key});

  @override
  State<Accident_Button> createState() => _Accident_ButtonState();
}

class _Accident_ButtonState extends State<Accident_Button> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: Size(150,200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23))
         ),
      
    // Accident Button //
        onPressed: (){},
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Accident", 
                style: TextStyle(fontSize: 20, color: Colors.black),
                textAlign: TextAlign.start,
                ),
                Icon(Icons.water_drop, size: 80, color: Colors.yellow,),
                ],
          ));
}
}

class No_Accident_Button extends StatefulWidget {
  const No_Accident_Button({super.key});

  @override
  State<No_Accident_Button> createState() => _No_Accident_ButtonState();
}

class _No_Accident_ButtonState extends State<No_Accident_Button> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: Size(150,200),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23))
      ),
            

    // No Accident Button //
       onPressed: (){},
       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("No Accident", 
          style: TextStyle(fontSize: 18, color: Colors.black),
          textAlign: TextAlign.start,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
          Icon(Icons.water_drop, size: 70, color:  Colors.yellow.withOpacity(0.6),),
          Icon(Icons.dnd_forwardslash_outlined, size: 100,color: Colors.yellow,)
          ]
        ),
        ],
       ));
  
}

}