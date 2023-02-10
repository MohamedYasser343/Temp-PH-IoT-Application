import 'package:flutter/material.dart';
import 'package:temp_ph_iot/home_page.dart';

void main() {
  runApp(const MyApp());
}
const ServerIP = "http://<host>:<port>";

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CapStone App',
      home: HomePage(),
    );
  }
}
