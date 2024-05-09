import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Calendar_bar.dart';
import 'package:urinary_incontinence_application/Database/DatabaseManager.dart';
import 'package:urinary_incontinence_application/Visualization/History_Box.dart';
import 'package:urinary_incontinence_application/Visualization/bar_chart.dart';
import 'package:urinary_incontinence_application/bluetooth/find_devices.dart';
import 'package:urinary_incontinence_application/Visualization/CreateFakeData.dart';

// import '../Visualization/HomePage/History_Box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



// @override
//   void initState() async {
//     super.initState();
//     final getAccident = await DatabaseManager.databaseManager.getBladderDiary();
//     var accident = getAccident as List<ChartData>;
// }       

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(actions: const <Widget>[
        // ElevatedButton(onPressed: () {  } , child: const Text('Day')),
        // ElevatedButton(onPressed: () {  }, child: const Text('Week')),
        // ElevatedButton(onPressed: () {  }, child: const Text('Month')),
        // ElevatedButton(onPressed: () {  }, child: const Text('3 Months'))
      ],),
      body: 
            Column(
             children: [
               const Calender_Bar(),
               
              // const Divider(height: 2,),
               
              BarChart(),

              const Divider(height: 3,),
              const Data_Button(),
              
              //History_Box()
              //Tooltip(),
             ],
           )
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //    return const Scaffold(
  //     body: History_Box(),
  //    );
  // }
}