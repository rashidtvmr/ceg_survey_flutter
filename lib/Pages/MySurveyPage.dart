import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';

class MySurveyPage extends StatefulWidget {
  MySurveyPage({Key key}) : super(key: key);

  @override
  _MySurveyPageState createState() => _MySurveyPageState();
}

class _MySurveyPageState extends State<MySurveyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Survey",
          style: defaultTextStyle,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: primary),
      ),
      body: Container(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
