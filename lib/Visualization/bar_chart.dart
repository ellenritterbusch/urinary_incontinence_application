import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:urinary_incontinence_application/BladderDiary/CalendarPage/Table_calendar.dart';
import 'package:urinary_incontinence_application/Database/DatabaseManager.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:urinary_incontinence_application/Visualization/CreateFakeData.dart';
import 'package:urinary_incontinence_application/Visualization/History_Box.dart';

class BarChart extends StatefulWidget {  

  const BarChart({super.key});
  @override
  State<BarChart> createState() => BarChartState();
}

class BarChartState extends State<BarChart> {
final Data_ButtonState databutton = Data_ButtonState();
 late Future <List<ChartData>> chartData;                          //Define chartdata

 List<dynamic>? individualAccident;                              //Define list of accidents
 List<dynamic>? individualTime;                                 //Define list of times for incidents
 List<dynamic>? individualStimulation;                          //Define list of stimulations

 dynamic accidentValue;                                         //Define individual incidents
 dynamic timeValue;
 dynamic stimulationValue;
      
  // void dayButton() {
  //   maximum = DateTime(today.year, today.month, today.day, 24, 0);
  //   minimum = DateTime(today.year, today.month, today.day, 00, 0);

 @override
   void initState() {
    super.initState();
    chartData = getChartData();
} 

 
Future<List<ChartData>> getChartData() async {
  List<ChartData> mapChartData = [];             //Define list mapChartData
 
  //Chosen date on calendar_bar as string 
  final dateString = today.toString().substring(0,10);           
  //Fetch accidents from database                                      
  final accidents = await DatabaseManager.databaseManager.getAccidentBladderDiary(dateString);
  //Fetch time of acidents from database            
  final timer = await DatabaseManager.databaseManager.getTimeBladderDiary(dateString); 
  //Fetch ALL stimulations from database                
  final amountStimulation = await DatabaseManager.databaseManager.getOnDemandBladderDiary(dateString);  
  debugPrint(amountStimulation.toString());
  debugPrint('længden for accidents er:');  
  debugPrint(accidents.length.toString());
   debugPrint('længden for stimulations er:');  
  debugPrint(amountStimulation.length.toString());

  for (var i = 0; i < accidents.length; i++){  //For loop counter going from 0 - amount of accidents.
    final individualAccident = accidents[i];                              
    accidentValue = individualAccident['accident'];

    final  individualTime = timer[i];
    timeValue = individualTime['time'];
    final dateTime = '$dateString $timeValue';

    final individualStimulation = amountStimulation[i];
    stimulationValue = individualStimulation['stimtype'];

    if (stimulationValue > 1) {    //Stimulation data can be 1 or 2. We only want 1.
      setState(() {                //We set stimulation data = 2 to be 0.
    stimulationValue = 0;
    });}

    mapChartData.add(              //We insert the data into the variables from the ChartData class
      ChartData(
        date: dateTime,
        accident: accidentValue,
        amount_stimulation: stimulationValue,                           
      ));

    // debugPrint('acci: $accidentValue'); //If these print, we enter the for loop. Also used for testing
    // debugPrint('time: $dateTime');
    // debugPrint('Stim: $stimulationValue');    
  }
  return mapChartData;
}       


  @override
    Widget build(BuildContext context) {
        return  Column(
          children: [
        // Table calendar //
        Table_calendar(
          yourCalendarFormat: CalendarFormat.week, 
          onDaySelected: (DateTime newdate, DateTime focusedDay){
            setState(() {
            today = newdate;
            debugPrint('$today');
            });
            chartData = getChartData();                                      //ensures that data is updated when a new day is selected
            final History_BoxState?  historyBoxState = historyBoxKey.currentState;
              if (historyBoxState != null) {
                historyBoxState.fetchBladderDiaryData();
              }
          }),
          /////// Bar chart /////
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
              primaryXAxis: DateTimeAxis(                                       //Primaryaxis is a DateTimeAxis (x-axis)
                minimum: DateTime(today.year, today.month, today.day, 00, 0), //today.subtract(const Duration(days: 3)),   //
                maximum: DateTime(today.year, today.month, today.day, 24, 0),   //
                dateFormat: DateFormat.Hm(),                                    //We want dateformat in forced 00:00
                // interval: 4,                                                    //Interval of 4 hours
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
                      color:  Colors.yellow,                                                  //Color of barseries
                      borderColor: Colors.yellow,                                             //Bordercolor in hope of thicker bars
                      borderWidth: 3,                                                           //Borderwidth = 3 pixels                                                   
                  ),
                  
                  ColumnSeries<ChartData, DateTime>(                             //Second bar serie, "Stimulations"
                      name: 'Stimulations',                                      //title
                      width: 1,                                                  //barwidth (must be between 0-1)
                      borderColor: Colors.blue,                               //bordercolor
                      borderWidth: 3,                                           //borderwidth = 2 pixels in hope of thick bars
                      dataSource: snapshot.data!,                               //Datasource 
                      xValueMapper: (ChartData chartData, _) => DateTime.parse(chartData.date),   //x-value
                      yValueMapper: (ChartData chartData, _) => chartData.amount_stimulation,     //y-value
                      color: Colors.blue,                                                       //color of bar                                      
                  )
                ],
                annotations: [
                  CartesianChartAnnotation(
                    widget: snapshot.data!.isEmpty? const Text('No data available'): const Text(''), x: 180, y: 70)
                ],     //if data is empty we print that is not available
            );}
            else if (snapshot.hasError) {                            
              return Text("${snapshot.error}");
              } 
              return const CircularProgressIndicator();                           //Returns loading indicator
            }
           ),
         
          ),
        ),
        ////////////// data button ////////////////
         Data_Button(onButtonPressed: (){
          databutton.uploadFakeData();
          Future.delayed(Duration(seconds: 24)).then((_){       // we wait 24 seconds for the data to upload
            chartData = getChartData();
            final History_BoxState?  historyBoxState = historyBoxKey.currentState;
              if (historyBoxState != null) {
                historyBoxState.fetchBladderDiaryData();
              }  
         });
        })
          
        ]);
    } 
}
class ChartData {                                                        //Class ChartData is our data
        final String date;                                               //This one is dateTime
        final num? accident;                                             //This is num? (? = nullable) and our accidentdata variable
        final num? amount_stimulation;                                   //This is num? (? = nullable) and our stimulationdata variable

    ChartData(                                                           //We require the variables in the class! 
          {required this.date, 
          required this.accident, 
          // ignore: non_constant_identifier_names
          required this.amount_stimulation,
          }
          );
          
}