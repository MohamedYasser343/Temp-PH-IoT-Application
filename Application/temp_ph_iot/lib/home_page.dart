import 'package:temp_ph_iot/chart_table.dart';
import 'package:temp_ph_iot/graph_page.dart';
import 'package:flutter/material.dart';

import 'home_icon_buttoms.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF04773B),
      body: Column(
        children: [
          Stack(
            children: [
              Transform.rotate(
                origin: const Offset(30, -60),
                angle: 2.4,
                child: Container(
                  margin: const EdgeInsets.only(left: 75, top: 40),
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80),
                      gradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        colors: [Color(0xFF069E2D), Color(0xFF058E3F)],
                      )),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Temp & PH Application',
                      style: TextStyle(
                        color: Color(0xFF03440C),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'temperature and pH app',
                      style: TextStyle(
                        color: Color(0xFF03440C),
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return ChartTable();
                                  }));
                                },
                                child: CatigoryW(
                                  image: 'images/demoo.png',
                                  text: 'Table',
                                  color: const Color(0xFFAEC3B0),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return const Graph();
                                  }));
                                },
                                child: CatigoryW(
                                  image: 'images/demoo.png',
                                  text: 'Graphs',
                                  color: const Color(0xFFAEC3B0),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
