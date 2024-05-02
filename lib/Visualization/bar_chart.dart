import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class BarChart extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  BarChart({Key? key}) : super(key: key);

  @override
  BarChartState createState() => BarChartState();
}

class BarChartState extends State<BarChart> {
  late List<ChartData> data;                                        //Define list of ChartData called data
  late TooltipBehavior _tooltip;                                    //Who knows

  @override
    Widget build(BuildContext context) {
      
        final List<ChartData> chartData = [                         //We create our chartData here
            ChartData(DateTime(2024, 5, 1, 12, 23), 35, 23),
            ChartData(DateTime(2024, 5, 1, 13, 56), 38, 49),
            ChartData(DateTime(2024, 5, 1, 15, 21), 34, 12),
            ChartData(DateTime(2024, 5, 1, 17, 13), 52, 33),
            ChartData(DateTime(2024, 5, 1, 20, 15), 40, 30),
            ChartData(DateTime(2024, 5, 1, 21, 45), 16, 15),
            ChartData(DateTime(2024, 5, 1, 22, 23), 23, 30),
            ChartData(DateTime(2024, 5, 1, 23, 10), 40, 25),
            ChartData(DateTime(2024, 5, 2, 02, 40), 20, 10),
            ChartData(DateTime(2024, 5, 2, 05, 54), 23, 25),
            ChartData(DateTime(2024, 5, 2, 07, 10), 5, 13),
            ChartData(DateTime(2024, 5, 2, 10, 42), 2, 3),
        ];

        return  SizedBox(                                                     //We create a sizedbox to insert graph in
          height: 350,
          width: double.infinity,
          child: SfCartesianChart(
            margin: const EdgeInsets.all(25),                                 //Margin aroung graph, so it fits
            primaryXAxis: DateTimeAxis(
              minimum: DateTime.now().subtract(const Duration(days: 1)),      //Minimum time on graph is yesterday at current time.
              maximum: DateTime.now(),                                        //Maximum time on graph is right now
              dateFormat: DateFormat.Hm(),                                    //We want dateformat in forced 00:00
              desiredIntervals: 4,                                            //Here im truly lost
              interval: 4,                                                    //Interval of 4 hours
            ),
            enableSideBySideSeriesPlacement: true,                            //Makes the bars be beside each other, instead of on top of.
             plotAreaBorderWidth: 0,                                          //Creates at border around the graph
              series: <CartesianSeries<ChartData, DateTime>>[                 //We create bar series
                ColumnSeries<ChartData, DateTime>(                            //First bar serie "Accidents"
                    name:'Accidents',                                         //Name of bar
                    dataSource: chartData,                                    //We get data from chartData
                    width: 1,                                                 //Bar width
                    xValueMapper: (ChartData data, _) => data.x,              //X value is data.x
                    yValueMapper: (ChartData data, _) => data.y,              //Y value is data.y
                    color: Colors.blue,                                     //COlor
                ),
                ColumnSeries<ChartData, DateTime>(                            //Second bar serie, "Stimulations"
                    name: 'Stimulations',
                    //opacity: 0.9,
                    width: 1,
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y1,
                    color: Colors.yellow,
                )
              ]
          ),
        );
    }
    
}
class ChartData {                                                       //Create class ChartData
        ChartData(this.x, this.y, this.y1);                             //ChartData consists of x,y,y1
        final DateTime x;                                               //This one is dateTime
        final num y;                                                    //This is num
        final num y1;
    }