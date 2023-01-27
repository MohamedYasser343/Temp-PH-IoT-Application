import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class ChartTable extends StatefulWidget {
  const ChartTable({super.key});

  @override
  State<ChartTable> createState() => _ChartTableState();
}

List<DataRow> DataRowsFormatted = [];

class _ChartTableState extends State<ChartTable> {
  Future getData() async {
    DataRowsFormatted.clear();
    var results = await http.get(Uri.parse("$ServerIP/Data"));
    if (results.statusCode == 200) {
      var data = jsonDecode(results.body);
      List<Readings> datas = [];
      for (var u in data) {
        Readings data = Readings(u["Temp"].toString(), u["PH"].toString());
        datas.add(data);
      }
      for (var u in datas) {
        List<DataCell> currentCells = [];
        currentCells.add(
          DataCell(
            Text(
              u.temperature.toString(),
              style: TextStyle(
                color: Color(0xFF03440C),
              ),
            ),
          ),
        );
        currentCells.add(
          DataCell(
            Text(
              u.pH.toString(),
              style: TextStyle(
                color: Color(0xFF03440C),
              ),
            ),
          ),
        );
        DataRowsFormatted.add(
          DataRow(cells: currentCells),
        );
      }
      return DataRowsFormatted;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCBEF43),
      body: FutureBuilder(
        future: getData(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Chart Table Data',
                              style: TextStyle(
                                color: Color(0xFF03440C),
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: DataTable(
                          columns: const [
                            DataColumn(
                              label: Text(
                                'Temperature',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF03440C)),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'PH of soil',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF03440C)),
                              ),
                            )
                          ],
                          rows: DataRowsFormatted,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}

class Readings {
  Readings(this.temperature, this.pH);
  final String temperature, pH;
}
