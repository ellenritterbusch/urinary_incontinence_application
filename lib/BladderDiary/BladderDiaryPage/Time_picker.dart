import 'package:flutter/material.dart';

class Time_picker extends StatefulWidget {
  const Time_picker({super.key});

  @override
  State<Time_picker> createState() => _Time_pickerState();
}

class _Time_pickerState extends State<Time_picker> {
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("${selectedTime.hour}:${selectedTime.minute}", style: TextStyle(fontSize: 50)),
          //ElevatedButton(
            //child: const Text("Choose time", style: TextStyle(fontSize: 12)),
           // onPressed: () async {
             // final TimeOfDay? timeOfDay = await showTimePicker(
              //  context: context,
              //  initialTime: selectedTime,
              //  initialEntryMode: TimePickerEntryMode.dial,
              //  );
               // if (timeOfDay != null) {
               //   setState(() {
               //     selectedTime = timeOfDay;
               //   });
               // }
           // }

            //)
        ],
      )
    );
  }
}