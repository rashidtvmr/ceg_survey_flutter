import 'package:flutter/material.dart';
import 'dart:math';

Color primary = Colors.blue;
TextStyle headerStyle = new TextStyle(
  fontWeight: FontWeight.w900,
  fontSize: 35,
  color: Colors.blue,
);

Widget emptyContainer = Container();
TextStyle boldFont = TextStyle(fontWeight: FontWeight.bold);
TextStyle textStyle = new TextStyle(fontSize: 15, color: Colors.blue);
TextStyle defaultTextStyle = new TextStyle(
    fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blue);
TextStyle secondaryTextStyle =
    new TextStyle(fontWeight: FontWeight.bold, fontSize: 10);

Color getRandomColor() {
  return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(.1);
}

Widget defaultHeight = SizedBox(
  height: 30,
);
Widget minHeight = SizedBox(
  height: 10,
);

Widget defaultWidth = SizedBox(
  width: 30,
);
Widget minWidth = SizedBox(
  width: 10,
);
