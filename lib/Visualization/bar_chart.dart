import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Table_calendar.dart';
import 'package:urinary_incontinence_application/Database/DatabaseManager.dart';


// ignore: must_be_immutable
class BarChart extends StatefulWidget {  

   // ignore: prefer_const_constructors_in_immutables
   BarChart(
    {super.key}
    );
  
  @override
  // ignore: no_logic_in_create_state
  State<BarChart> createState() => BarChartState();


 //BarChart({super.key});
  // ignore: no_logic_in_create_state
  // BarChartState createState() => BarChartState(
  //   accident,
  //   stimulations,
  // );
}

class BarChartState extends State<BarChart> {
late List accident = [];
late Future <List<ChartData>> chartData;
late List<ChartData> mapLiveData;
late dynamic stimulation = [];
late dynamic accidentValue;
late dynamic timeValue;
late dynamic stimulationValue;


    // Future getAccident() async {
    //   final date = today.toString().substring(0,10);
    //   final anAccident = await DatabaseManager.databaseManager.getAccidentBladderDiary(date);
    //   final accidenta =  anAccident;
    //   // debugPrint(accidenta);
    //   // final int allaccident = accidenta['accident'];
      
    //   for (int i = 0; i > anAccident.length; i++){
    //     dynamic individualAccident = anAccident[i];
    //     accidentValue = individualAccident['accident'];
    //   }
    //   debugPrint('$anAccident');
      
    //   // setState(()  {
    //   //   accident = allaccident;
    //   //   debugPrint('Accidents: $accident');
    //   // });
    //   // return anAccident;
    //   // debugPrint('${getAccident} accidents');
    //   // final uheld = getAccident[0];
    //   // return accidenta;
      
    //   }

  //  Future <dynamic> getStimulation() async {
  //     final amountStimulation = await DatabaseManager.databaseManager.getOnDemandBladderDiary(today.toString());
  //     final stimulationa = amountStimulation;
  //     setState(() {
  //       stimulation = stimulationa[0];
  //       debugPrint('Stimulations: $stimulation');
  //     });
  //     // debugPrint('$today');
  //     // final num stimulationa = amountStimulation ;
  //     // return amountStimulation;
  //     // debugPrint('${amountStimulation} stimulations');
  //     // return  amountStimulation;
  //   }

    // Future<List<ChartData>> returnvalue() async {
    //   // dynamic stimuli = await getStimulation();
    //   // dynamic accidenta = await getAccident();
    //    List<ChartData> chartData = [                                 //Our data. Here we choose our data.
    //       ChartData(today, accident, stimulation)
    //   ];
    //   return chartData;
    // }

              

@override //Brug future! eller lav en funktion som bliver kaldt herinde
   void initState() {
    super.initState();
    chartData = getChartData2();
    //  getAccident();
    // getStimulation();
    // returnvalue();
}           

Future<List<ChartData>> getChartData2() async {
  final List<ChartData> chartData = [
       ChartData(date:'2024-05-08 10:00:04Z',accident:20, amount_stimulation: 35),
        ChartData(date:'2024-05-08 12:30:04Z',accident:10, amount_stimulation: 20),
        ChartData(date:'2024-05-08 14:00:04Z',accident:20, amount_stimulation: 35),
        ChartData(date:'2024-05-08 18:30:04Z',accident:15, amount_stimulation: 10),
            ChartData(date:'2024-05-09 06:00:04Z',accident:20, amount_stimulation: 35),
             ChartData(date:'2024-05-09 06:30:04Z',accident:10, amount_stimulation: 20),
              ChartData(date:'2024-05-09 05:00:04Z',accident:20, amount_stimulation: 35),
               ChartData(date:'2024-05-09 05:30:04Z',accident:15, amount_stimulation: 10),
        ];
  return chartData;
}


// Future<List<ChartData>> getChartData() async {
//   List<ChartData> mapChartData = [];
//   final dato = today.toString().substring(0,10);
//   final anAccident = await DatabaseManager.databaseManager.getAccidentBladderDiary(dato);
//   final time = await DatabaseManager.databaseManager.getTimeBladderDiary(dato);
//   final amountStimulation = await DatabaseManager.databaseManager.getOnDemandBladderDiary(today.toString());


//   for (int i = 0; i > anAccident.length; i++){

//     dynamic individualAccident = anAccident[i];
//     accidentValue = individualAccident['accident'];

//     dynamic individualTime = time;
//     timeValue = individualTime['time'];
//     String date = ('$dato + $time')[i];


//     dynamic individualStimulation = amountStimulation[i];
//     stimulationValue = individualStimulation['stimType'];
//     // DateTime datoo = DateTime.parse(date);
//     mapChartData.add(
//           ChartData(
//             date: date[i],
//             accident: accidentValue[i],
//             amount_stimulation: stimulationValue[i],
//           )
//     );
//   }
//   return mapChartData;
// }




  @override
    Widget build(BuildContext context) {
        return  SizedBox(
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
            return CircularProgressIndicator();
           }
           ),
                ),
        );
    } 
}
class ChartData {       
        final String date;                                               //This one is dateTime
        // ignore: non_constant_identifier_names
        final num? accident;                                                    //This is num
        // ignore: non_constant_identifier_names
        final num? amount_stimulation;

        List<dynamic>? mappedData;
    ChartData(
          {required this.date, 
          this.accident, 
          // ignore: non_constant_identifier_names
          this.amount_stimulation,
          this.mappedData,}
          );
          
}