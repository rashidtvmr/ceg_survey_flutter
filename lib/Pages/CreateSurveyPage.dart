import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';

class CreateSurveyPage extends StatefulWidget {
  CreateSurveyPage({Key key}) : super(key: key);

  @override
  _CreateSurveyPageState createState() => _CreateSurveyPageState();
}

class _CreateSurveyPageState extends State<CreateSurveyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Survey",
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
