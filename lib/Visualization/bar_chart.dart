import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Table_calendar.dart';
import 'package:urinary_incontinence_application/Database/DatabaseManager.dart';
import 'package:table_calendar/table_calendar.dart';


// ignore: must_be_immutable
class BarChart extends StatefulWidget {  

   const BarChart({Key? key}) : super(key: key);
  
  @override
  // ignore: no_logic_in_create_state
  State<BarChart> createState() => BarChartState();

}

class BarChartState extends State<BarChart> {

late Future <List<ChartData>> chartData; 

 List<dynamic>? individualAccident;
 List<dynamic>? individualTime;
 List<dynamic>? individualStimulation;

 dynamic accidentValue;
 dynamic timeValue;
 dynamic stimulationValue;
      

 @override //Brug future! eller lav en funktion som bliver kaldt herinde
   void initState() {
    super.initState();
    chartData = getChartData(today);
} 

 
Future<List<ChartData>> getChartData(DateTime date) async {
  List<ChartData> mapChartData = [];
 
  final dateString = today.toString().substring(0,10);
  final anAccident = await DatabaseManager.databaseManager.getAccidentBladderDiary(dateString);
  final timer = await DatabaseManager.databaseManager.getTimeBladderDiary(dateString);
  final amountStimulation = await DatabaseManager.databaseManager.getOnDemandBladderDiary(dateString);


  for (var i = 0; i < anAccident.length; i++){

    final individualAccident = anAccident[i];
    accidentValue = individualAccident['accident'];

    final  individualTime = timer[i];
    timeValue = individualTime['time'];
    final dateTime = '$dateString $timeValue';
    date = DateTime.parse(dateTime);

    final individualStimulation = amountStimulation[i];
    stimulationValue = individualStimulation['stimtype'];

if (stimulationValue > 1) {
  setState(() {
    stimulationValue = 0;
  });

}

    mapChartData.add(
          ChartData(
            date: dateTime,
            accident: accidentValue,
            amount_stimulation: stimulationValue,
          )
    );

    // debugPrint('${amountStimulation}');

    
  }

  // debugPrint('$stimulationValue');
  return mapChartData;
}       

void _onDaySelected(DateTime selectedDay, DateTime focusedDay){ //funktion der sætter den valgte dag til den dag der skal være i fokus
  setState(() {
    today = selectedDay;
    debugPrint('$today');
  });
  chartData = getChartData(today);
}


  @override
    Widget build(BuildContext context) {
        return  Column(
          children: [
        // table calendar //
        Table_calendar(
          yourCalendarFormat: CalendarFormat.week, 
          onDaySelected: (DateTime newdate, DateTime focusedDay){
            setState(() {
            today = newdate;
            debugPrint('$today');
            });
            chartData = getChartData(today);
          }),
          // bar chart //
          SizedBox(
          height: 350,
          width: double.infinity,
        child: Scaffold(                                                     //We create a sizedbox to insert graph in
            // height: 350,
            // width: double.infinity,
            body: FutureBuilder<List<ChartData>>(
              future: chartData,
              builder: (context, snapshot){
                if (snapshot.hasData){
                  return SfCartesianChart(
              title: const ChartTitle(text: 'Use of On-Demand'),
              legend:  const Legend(
                alignment: ChartAlignment.center,
                isVisible: true,
                position: LegendPosition.bottom,
                ),
              margin: const EdgeInsets.all(25),                                 //Margin aroung graph, so it fits
              primaryXAxis: DateTimeAxis(
                minimum: DateTime(today.year, today.month, today.day, 00, 0),      //Minimum time on graph is yesterday at current time.
                maximum: DateTime(today.year, today.month, today.day, 24, 0),                                        //Maximum time on graph is chosen date
                dateFormat: DateFormat.Hm(),                                    //We want dateformat in forced 00:00
                desiredIntervals: 4,                                            //Here im truly lost
                interval: 4,                                                    //Interval of 4 hours
              ),
              enableSideBySideSeriesPlacement: true,                            //Makes the bars be beside each other, instead of on top of.
               plotAreaBorderWidth: 0,                                          //Creates at border around the graph
                series: <CartesianSeries<ChartData, DateTime>> [                 //We create bar series
                  
                  ColumnSeries<ChartData, DateTime> (                            //First bar serie "Accidents"
                      name:'Accidents',                                         //Name of bar
                      dataSource: snapshot.data!,                                    //We get data from chartData
                      width: 1,                                                 //Bar width
                      xValueMapper: (ChartData chartData, _) => DateTime.parse(chartData.date),              //X value is data.x
                      yValueMapper: (ChartData chartData, _) => chartData.accident,   //Y value    data.y
                      color: Colors.yellow,                                     //COlor
                  ),
                  
                  ColumnSeries<ChartData, DateTime>(                            //Second bar serie, "Stimulations"
                      name: 'Stimulations',
                      //opacity: 0.9,
                      width: 1,
                      dataSource: snapshot.data!,
                      xValueMapper: (ChartData chartData, _) => DateTime.parse(chartData.date),
                      yValueMapper: (ChartData chartData, _) => chartData.amount_stimulation,
                      color: Colors.blue,
                  )
                ]
            );
            }
            else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
           }
           ),
                ),
        )]
        );
    } 
}
class ChartData {       
        final String date;                                               //This one is dateTime
        // ignore: non_constant_identifier_names
        final num? accident;                                                    //This is num
        // ignore: non_constant_identifier_names
        final num? amount_stimulation;

    ChartData(
          {required this.date, 
          required this.accident, 
          // ignore: non_constant_identifier_names
          required this.amount_stimulation,
          }
          );
          
}