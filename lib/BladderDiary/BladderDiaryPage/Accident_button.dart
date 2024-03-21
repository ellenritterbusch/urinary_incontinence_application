import 'package:flutter/material.dart';


class AccidentButton extends StatefulWidget {
  const AccidentButton({super.key});

  @override
  State<AccidentButton> createState() => _AccidentButtonState();
}

class _AccidentButtonState extends State<AccidentButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(150,200),
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

class NoAccidentButton extends StatefulWidget {
  const NoAccidentButton({super.key});

  @override
  State<NoAccidentButton> createState() => _NoAccidentButtonState();
}

class _NoAccidentButtonState extends State<NoAccidentButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(150,200)
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