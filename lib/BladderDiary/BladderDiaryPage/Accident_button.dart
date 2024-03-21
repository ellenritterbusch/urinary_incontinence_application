import 'package:flutter/material.dart';


class Accident_Button extends StatefulWidget {
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
         ),
      
    // Accident Button //
        onPressed: (){},
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.water_drop, size: 80,),
                Text("Accident", style: TextStyle(fontSize: 20),),],
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
        fixedSize: Size(150,200)
      ),
            

    // No Accident Button //
       onPressed: (){},
       child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.water_drop_outlined, size: 80,),
          Text("No Accident", style: TextStyle(fontSize: 18),),],
       ));
  
}

}