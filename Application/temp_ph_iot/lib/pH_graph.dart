import 'dart:convert';

import 'package:temp_ph_iot/main.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class HumGraph extends StatefulWidget {
  const HumGraph({super.key});

  @override
  State<HumGraph> createState() => _HumGraphState();
}

class _HumGraphState extends State<HumGraph> {
  List<HumReadings> _chartData = [];
  late TooltipBehavior _tooltipBehavior;
  bool isLoaded = false;

  Future<String> getChartData() async {
    if (!isLoaded) {
      await http.get(Uri.parse("$ServerIP/Data")).then((results) {
        var data = jsonDecode(results.body);
        double time = 0;

        for (var u in data) {
          _chartData.add(HumReadings(double.parse(u["PH"].toString()), time));
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
                  text: 'pH readings',
                  textStyle: TextStyle(
                    color: Color(0xFF03440C),
                  ),
                ),
                legend: Legend(isVisible: true),
                tooltipBehavior: _tooltipBehavior,
                series: <LineSeries>[
                  LineSeries<HumReadings, double>(
                    name: 'pH',
                    dataSource: _chartData,
                    xValueMapper: (HumReadings time, _) => time.time,
                    yValueMapper: (HumReadings temp, _) => temp.temp,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    color: Color(0xFF069E2D),
                    // width: 4,
                    opacity: 1,
                  )
                ],
                primaryXAxis:
                    NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
                // primaryYAxis: NumericAxis(
                //     numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
              );
            }
          },
        ),
      ),
    );
  }
}

class HumReadings {
  HumReadings(this.temp, this.time);
  final double temp;
  final double time;
}
