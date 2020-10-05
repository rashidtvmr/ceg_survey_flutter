import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';

SnackBarWidget(String txt, String type, GlobalKey<ScaffoldState> contextKey) {
  final snackBar = SnackBar(
    content: Text(
      txt,
      style: TextStyle(
          color: type == "success" ? Colors.white : Colors.white, fontSize: 20),
    ),
    backgroundColor: type == "success" ? Colors.green : primary,
  );
  contextKey.currentState.showSnackBar(snackBar);
}
