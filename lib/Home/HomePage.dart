import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:urinary_incontinence_application/BladderDiary/BladderDiaryPage/Calendar_bar.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Table_calendar.dart';
import 'package:urinary_incontinence_application/Database/DatabaseManager.dart';
import 'package:urinary_incontinence_application/Visualization/History_Box.dart';
// import 'package:urinary_incontinence_application/Visualization/Bar_chart.dart';
import 'package:urinary_incontinence_application/Visualization/bar_chart.dart';
import 'package:urinary_incontinence_application/bluetooth/find_devices.dart';
import 'package:urinary_incontinence_application/Visualization/CreateFakeData.dart';

// import '../Visualization/HomePage/History_Box.dart';
DateTime? minimum;
DateTime? maximum;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var barchartManager = BarChart();

  void dayButton() {
    maximum = DateTime(today.year, today.month, today.day, 24, 0);
    minimum = DateTime(today.year, today.month, today.day, 00, 0);
  }

  void weekButton() {
    maximum = DateTime(today.year, today.month, today.day, 24, 0);
    minimum = DateTime(today.year, today.month, today.subtract(const Duration(days: 7)).day, 00, 0);
  }
// barData.getChartData(today)     //Du gør sådan her bros

// @override
//   void initState() async {
//     super.initState();
//     final getAccident = await DatabaseManager.databaseManager.getBladderDiary();
//     var accident = getAccident as List<ChartData>;
// }       
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(actions: <Widget>[
        const Data_Button(),

                      //Daybutton
        Padding(
          padding: const EdgeInsets.all(1.5),
          child: OutlinedButton(
              onPressed: () {  
                dayButton();
              }, 
              style: OutlinedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text('Day',
              style: TextStyle(color: Colors.black))
            ),
        ),

                          //Week button
        Padding(
          padding: const EdgeInsets.all(1.5),
          child: OutlinedButton(
            onPressed: () {  
              weekButton();
            }, 
            style: OutlinedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('Week',
            style: TextStyle(color: Colors.black))
            ),
        ),

                          //Month button
        Padding(
          padding: const EdgeInsets.all(1.5),
          child: OutlinedButton(
            onPressed: () {  }, 
            style: OutlinedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('Month',
            style: TextStyle(color: Colors.black))
            ),
        ),

                          //3 months button
        Padding(
          padding: const EdgeInsets.all(1.5),
          child: SizedBox(
            width: 108,
            child: OutlinedButton(
              onPressed: () {  }, 
              style: OutlinedButton.styleFrom(shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text('3 Months',
              style: TextStyle(color: Colors.black))
              ),
          ),
        )
      ],),
    body : 
        const SingleChildScrollView(
           child: Column(
             children: [
              const BarChart(),
              //const Divider(height: 3,),
              //const Data_Button(),
              History_Box(key: historyBoxKey)
             ],
           )
    ));
  }
}