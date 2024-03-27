import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Time_picker.dart';

TimeOfDay selectedTime = TimeOfDay.now();
class Time_picker extends StatefulWidget {
  const Time_picker({super.key});


  @override
  State<Time_picker> createState() => _Time_pickerState();
}

class _Time_pickerState extends State<Time_picker> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("${"${selectedTime.hour}".padLeft(2,'0')}:${"${selectedTime.minute}".padLeft(2,'0')}", style: TextStyle(fontSize: 50)),
          ElevatedButton(
            child: const Text("Choose time", style: TextStyle(fontSize: 16)),
           onPressed: () async {
             final TimeOfDay? timeOfDay = await showTimePicker(
              context: context,
               initialTime: selectedTime,
               initialEntryMode: TimePickerEntryMode.inputOnly,
               );
               if (timeOfDay != null) {
                 setState(() {
                  selectedTime = timeOfDay;
                 });  
               }        
          })
        ],
      )
    );
  }
}