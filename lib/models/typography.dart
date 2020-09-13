import 'package:flutter/material.dart';
import 'dart:math';

TextStyle headerStyle = new TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 35,
  color: Colors.blue,
);
TextStyle textStyle = new TextStyle(fontSize: 15, color: Colors.blue);
TextStyle defaultTextStyle = new TextStyle(
    fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue);
TextStyle secondaryTextStyle =
    new TextStyle(fontWeight: FontWeight.bold, fontSize: 10);

Color getRandomColor() {
  Random random = new Random();
  return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(.8);
}

Widget defaultHeight = SizedBox(
  height: 30,
);

Color primary = Colors.blue;
