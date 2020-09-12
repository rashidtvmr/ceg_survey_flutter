import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';

class AnswerSurveyPage extends StatefulWidget {
  AnswerSurveyPage({Key key}) : super(key: key);

  @override
  _AnswerSurveyPageState createState() => _AnswerSurveyPageState();
}

class _AnswerSurveyPageState extends State<AnswerSurveyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Surveys",
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
