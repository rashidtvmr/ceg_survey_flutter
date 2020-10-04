import 'package:flutter/material.dart';

class SnackBarWidget extends StatelessWidget {
  var contextKey;
  final String txt, type;
  SnackBarWidget({Key key, this.txt, this.type, this.contextKey})
      : super(key: key);

  // showSnackBar(String txt, String type, GlobalKey<ScaffoldState> contextKey) {}
  @override
  Widget build(BuildContext context) {
    final snackBar = SnackBar(
      content: Text(
        txt,
        style: TextStyle(
            color: type == "success" ? Colors.white : Colors.white,
            fontSize: 20),
      ),
      backgroundColor: type == "success" ? Colors.green : Colors.blue,
    );
    contextKey.currentState.showSnackBar(snackBar);
    // return showSnackBar(txt, type, contextKey)
  }
}
