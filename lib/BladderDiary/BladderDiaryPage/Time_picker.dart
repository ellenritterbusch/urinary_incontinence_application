import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({super.key});

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("${selectedTime.hour}:${selectedTime.minute}", style: const TextStyle(fontSize: 50)),
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