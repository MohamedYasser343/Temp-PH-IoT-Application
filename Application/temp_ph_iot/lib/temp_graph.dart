import 'dart:convert';

import 'package:temp_ph_iot/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class TempGraph extends StatefulWidget {
  const TempGraph({super.key});

  @override
  State<TempGraph> createState() => _TempGraphState();
}

class _TempGraphState extends State<TempGraph> {
  List<TempReadings> _chartData = [];
  late TooltipBehavior _tooltipBehavior;
  bool isLoaded = false;

  Future<String> getChartData() async {
    if (!isLoaded) {
      await http.get(Uri.parse("$ServerIP/Data")).then((results) {
        var data = jsonDecode(results.body);
        double time = 0;

        for (var u in data) {
          _chartData.add(
              TempReadings(double.parse(u["Temp"].toString()), time));
          time = time + 5;
        }
        return "";
      });
    } else {
      return "";
    }
    return "";
  }

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  void dispose() {
    isLoaded = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: getChartData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SfCartesianChart(
                  backgroundColor: Color(0xFFffffff),
                  title: ChartTitle(
                    text: 'Temperature readings',
                    textStyle: TextStyle(
                      color: Color(0xFF03440C)
                    )
                  ),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: _tooltipBehavior,
                  series: <LineSeries>[
                    LineSeries<TempReadings, double>(
                      name: 'Temperature',
                      dataSource: _chartData,
                      xValueMapper: (TempReadings time, _) => time.time,
                      yValueMapper: (TempReadings temp, _) => temp.temp,
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: true),
                      enableTooltip: true,
                      color: Color(0xFF069E2D),
                      // width: 2,
                      opacity: 1,
                    )
                  ],
                  primaryXAxis:
                      NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                  // primaryYAxis: NumericAxis(
                  //     numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
                );
              }
            }),
      ),
    );
  }
}

class TempReadings {
  TempReadings(this.temp, this.time);
  final double temp;
  final double time;
}
