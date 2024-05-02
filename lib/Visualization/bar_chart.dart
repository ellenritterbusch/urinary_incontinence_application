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
  late List<ChartData> data;
  late TooltipBehavior _tooltip;

  @override
    Widget build(BuildContext context) {
      
        final List<ChartData> chartData = [
            ChartData(DateTime(2024, 5, 1, 12, 23), 35, 23),
            ChartData(DateTime(2024, 5, 1, 13, 56), 38, 49),
            ChartData(DateTime(2024, 5, 1, 15, 21), 34, 12),
            ChartData(DateTime(2024, 5, 1, 17, 13), 52, 33),
            ChartData(DateTime(2024, 5, 1, 20, 23), 40, 30),
        ];

        return  SizedBox(
          height: 350,
          width: double.infinity,
          child: SfCartesianChart(
            primaryXAxis: DateTimeAxis(
              dateFormat: DateFormat.Hm(),
            ),
            enableSideBySideSeriesPlacement: true,
              series: <CartesianSeries<ChartData, DateTime>>[
                ColumnSeries<ChartData, DateTime>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    color: Colors.blue,
                ),
                ColumnSeries<ChartData, DateTime>(
                    opacity: 0.9,
                    width: 0.4,
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
class ChartData {
        ChartData(this.x, this.y, this.y1);
        final DateTime x;
        final num y;
        final num y1;
    }


// @override
// Widget build(BuildContext context) {
// return Scaffold(
//   body: Center(
//     child: Container(
//       child: SfCartesianChart(
//         enableSideBySideSeriesPlacement: false,
//         series: <CartesianSeries<ChartData, int>>[
//                     ColumnSeries<ChartData, int>(
//                         dataSource: chartData,
//                         xValueMapper: (ChartData data, _) => data.x,
//                         yValueMapper: (ChartData data, _) => data.y
//                     ),
//                     ColumnSeries<ChartData, int>(
//                         opacity: 0.9,
//                         width: 0.4,
//                         dataSource: chartData,
//                         xValueMapper: (ChartData data, _) => data.x,
//                         yValueMapper: (ChartData data, _) => data.y1
//                     )
//                 ]
//       )
//     ),
//   )
// );
//   }