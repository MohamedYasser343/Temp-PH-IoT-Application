import 'package:temp_ph_iot/pH_graph.dart';
import 'package:temp_ph_iot/temp_graph.dart';
import 'package:flutter/material.dart';

import 'home_icon_buttoms.dart';

class Graph extends StatefulWidget {
  const Graph({super.key});

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF04773B),
      body: Stack(
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Graphs',
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
                  'temperature and pH graphs',
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
                                return TempGraph();
                              }));
                            },
                            child: CatigoryW(
                              image: 'images/demoo.png',
                              text: 'Temperature Graph',
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
                                return const HumGraph();
                              }));
                            },
                            child: CatigoryW(
                              image: 'images/demoo.png',
                              text: 'PH Graph',
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
      ),
    );
  }
}
