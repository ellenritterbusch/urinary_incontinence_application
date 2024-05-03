import 'package:flutter/material.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Calendar_bar.dart';
import 'package:urinary_incontinence_application/Visualization/History_Box.dart';
import 'package:urinary_incontinence_application/Visualization/bar_chart.dart';
import 'package:urinary_incontinence_application/bluetooth/find_devices.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(actions: <Widget>[
        ElevatedButton(onPressed: () {  } , child: const Text('Day')),
        ElevatedButton(onPressed: () {  }, child: const Text('Week')),
        ElevatedButton(onPressed: () {  }, child: const Text('Month')),
        ElevatedButton(onPressed: () {  }, child: const Text('3 Months'))
      ],),
      body: 
           Column(
             children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     ElevatedButton(onPressed: () {  } , child: const Text('Day')),
              //     ElevatedButton(onPressed: () {  }, child: const Text('Week')),
              //     ElevatedButton(onPressed: () {  }, child: const Text('Month')),
              //     ElevatedButton(onPressed: () {  }, child: const Text('3 Months')),
              //   ],
              // ),

              const Calender_Bar(),
               
              //const Divider(height: 2,),
               
              BarChart(),

              //const Divider(height: 2,),

              //Tooltip(),
             ],
           )
    );
  }
}