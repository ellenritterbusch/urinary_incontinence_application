import 'package:flutter/material.dart';

class Accident_Button extends StatefulWidget {
  const Accident_Button({super.key});

  @override
  State<Accident_Button> createState() => _Accident_ButtonState();
}

class _Accident_ButtonState extends State<Accident_Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(

    // Accident Button //
        onPressed: (){},
          icon: const Icon(Icons.water_drop),
          label: const Text("Accident"));

  
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
    return ElevatedButton.icon(

    // Accident Button //
        onPressed: (){},
          icon: const Icon(Icons.water_drop),
          label: const Text("No Accident"));

  
}
}