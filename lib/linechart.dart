import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<MoodData> _chartData;
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  List<MoodData> getChartData() {
    final List<MoodData> chartData = [
      MoodData(2017, 2),
      MoodData(2018, 3),
      MoodData(2019, 5),
      MoodData(2020, 3),
      MoodData(2021, 2)
    ];
    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: 200,
        child: SfCartesianChart(
          tooltipBehavior: _tooltipBehavior,
          series: <ChartSeries>[
            LineSeries<MoodData, double>(
              name: 'emoji_point',
              dataSource: _chartData,
              xValueMapper: (MoodData moodData, _) => moodData.date,
              yValueMapper: (MoodData moodData, _) => moodData.emoji_point,
              dataLabelSettings: DataLabelSettings(isVisible: true),
              enableTooltip: true,
            )
          ],
          primaryXAxis: NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
          ),
          primaryYAxis: NumericAxis(
            labelFormat: '{value}',
            interval: 1,
            maximum: 5,
          ),
        ),
      ),
    ));
  }
}

class MoodData {
  MoodData(this.date, this.emoji_point);

  final double date;
  final double emoji_point;
}
