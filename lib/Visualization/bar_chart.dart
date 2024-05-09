import 'package:flutter/material.dart';
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
}

class BarChartState extends State<BarChart> {
late Future <List<ChartData>> chartData;
late List<ChartData> mapLiveData;

 List<dynamic>? individualAccident;
 List<dynamic>? individualTime;
 List<dynamic>? individualStimulation;

dynamic accidentValue;
dynamic timeValue;
dynamic stimulationValue;

      
List<ChartData> mapChartData = [];
Future<List<ChartData>> getChartData() async {                                                          //Function to get data
  final dato = today.toString().substring(0,10);                                                        //variable that is choosen date (as string) on table calendar
  final anAccident = await DatabaseManager.databaseManager.getAccidentBladderDiary(dato);               //Accident data is retrieved from database as a List
  final timer = await DatabaseManager.databaseManager.getTimeBladderDiary(dato);                        //hours data for choosen date is retrieved from database
  final amountStimulation = await DatabaseManager.databaseManager.getOnDemandBladderDiary(dato);        //stimulation data for choosen date is retrieved from database


  for (var i = 0; i < anAccident.length-1; i++){                                                        //for loop to get data from 0 to amount of accidents for choosen date

    final individualAccident = anAccident[i];
    accidentValue = individualAccident['accident'];

    final  individualTime = timer[i];
    timeValue = individualTime['time'];
    final datoo = '$dato $timeValue';

    final individualStimulation = amountStimulation[i];
    stimulationValue = individualStimulation['stimtype'];

if (stimulationValue > 1) {                                                //Stimulation data can be 1 or 2. We only want 1.
  setState(() {                                                            //We set stimulation data = 2 to be 0.
    stimulationValue = 0;
  });

}

    mapChartData.add(                                                       //We add data
          ChartData(                                                        //To the required variables in ChartData class we add:
            date: datoo,                                                    //date data
            accident: accidentValue,                                        //Accident data
            amount_stimulation: stimulationValue,                           //stimulation data
          )
    );

    debugPrint('acci: ${accidentValue}');                                     //If these print, we enter the for loop.
    debugPrint('time: ${datoo}');
    debugPrint('Stim: ${stimulationValue}');

    
  }

  return mapChartData;
}



              

@override 
   void initState() {
    super.initState();
    chartData = getChartData();             //Data = function() 

}           


  @override
    Widget build(BuildContext context) {
        return  SizedBox(                                                      //Wrap in sizedBox
          height: 350,
          width: double.infinity,                                             //Width to infinity of screen
          child: Scaffold(                                                     //We create a sizedbox to insert graph in
            body: FutureBuilder<List<ChartData>>(                             //Wrap in futurebuilder so data can be inserted accourdingly
              future: chartData,                                              //Data is chartData
              builder: (context, snapshot){                                   //context is snapshot
                if (snapshot.hasData){                                        //If we have data, we return our chart
                  return SfCartesianChart(                                    //Chart
              title: const ChartTitle(text: 'Use of On-Demand'),              //Chart Title
              legend:  const Legend(                                          //Legends
                alignment: ChartAlignment.center,                             //PLacement = center
                isVisible: true,                                              //They are visible
                position: LegendPosition.bottom,                              //Position is under graph
                ),
              margin: const EdgeInsets.all(25),                                 //Margin aroung graph, so it fits
              primaryXAxis: DateTimeAxis(                                       //Primaryaxis is a DateTimeAxis (x-axis)
                minimum: DateTime(today.year, today.month, today.day, 00, 0),   //
                maximum: DateTime(today.year, today.month, today.day, 24, 0),   //
                dateFormat: DateFormat.Hm(),                                    //We want dateformat in forced 00:00
                interval: 4,                                                    //Interval of 4 hours
              ),
              enableSideBySideSeriesPlacement: true,                            //Makes the bars be beside each other, instead of on top of.
               plotAreaBorderWidth: 0,                                          //Creates at border around the graph
                series: <CartesianSeries<ChartData, DateTime>> [                 //We create bar series
      
                  ColumnSeries<ChartData, DateTime> (                                           //First bar serie "Accidents"
                      name:'Accidents',                                                         //Name of bar
                      dataSource: snapshot.data!,                                               //We get data from snapshot.data
                      width: 1,                                                                 //Bar width (between 0-1)
                      xValueMapper: (ChartData chartData, _) => DateTime.parse(chartData.date), //X value is data.x
                      yValueMapper: (ChartData chartData, _) => chartData.accident,             //Y value is data.y
                      color: const Color.fromARGB(255, 220, 202, 0),                          //Color of barseries
                      borderColor: Colors.yellow,                                             //Bordercolor in hope of thicker bars
                      borderWidth: 2,                                                           //Borderwidth = 2 pixels
                  ),
                  
                  ColumnSeries<ChartData, DateTime>(                             //Second bar serie, "Stimulations"
                      name: 'Stimulations',                                      //title
                      width: 1,                                                  //barwidth (must be between 0-1)
                      borderColor: Colors.blue,                               //bordercolor
                      borderWidth: 2,                                           //borderwidth = 2 pixels in hope of thick bars
                      dataSource: snapshot.data!,                               //Datasource 
                      xValueMapper: (ChartData chartData, _) => DateTime.parse(chartData.date),   //x-value
                      yValueMapper: (ChartData chartData, _) => chartData.amount_stimulation,     //y-value
                      color: Colors.blue,                                                       //color of bar
                  )
                ]
            );
            }
            else if (snapshot.hasError) {                                        //Error!
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();                           //Returns loading indicator
           }
           ),
                ),
        );
    } 
}
class ChartData {                                                        //Class ChartData is our data
        final String date;                                               //This one is dateTime
        // ignore: non_constant_identifier_names
        final num? accident;                                             //This is num? (? = nullable) and our accidentdata variable
        // ignore: non_constant_identifier_names
        final num? amount_stimulation;                                   //This is num? (? = nullable) and our stimulationdata variable

    ChartData(                                                           //We require the variables in the class! 
          {required this.date, 
          required this.accident, 
          // ignore: non_constant_identifier_names
          required this.amount_stimulation,
          }
          );
          
}