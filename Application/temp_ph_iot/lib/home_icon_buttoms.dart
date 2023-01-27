// ignore_for_file: must_be_immutable

// import 'package:cap_app/chart_table.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CatigoryW extends StatefulWidget {
  String image;
  String text;
  Color color;

  CatigoryW({super.key, required this.image, required this.text,required this.color});

  @override
  State<CatigoryW> createState() => _CatigoryWState();
}

class _CatigoryWState extends State<CatigoryW> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 177,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xFF036016),
        ),
        child: Column(
          children: [
            Image.asset(
              widget.image,
              width: 120,
              height: 120,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.text,
              style: TextStyle(
                color: widget.color,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
