import 'dart:collection';
import 'dart:convert';

import 'package:Survey_App/models/Form.dart';
import 'package:Survey_App/models/typography.dart';
import 'package:Survey_App/widget/MiniProgressBar.dart';
import 'package:Survey_App/widget/SnackBarWidget.dart';

import 'package:provider/provider.dart';
import 'package:Survey_App/models/ParseForm.dart';
import 'package:Survey_App/models/app.dart';
import 'package:Survey_App/models/typography.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class SurveyPage extends StatefulWidget {
  var sInfo;
  SurveyPage({Key key, this.sInfo}) : super(key: key);

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = GlobalKey<ScaffoldState>();
    String appBarTitle = "Loading...";

    return ChangeNotifierProvider(
      create: (context) => ParseForm(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: primary),
          title: Text(widget.sInfo['surveyTitle'], style: defaultTextStyle),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 10, top: 5, right: 10),
            decoration: BoxDecoration(),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Title",
                  style: boldFont,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Text(widget.sInfo['surveyTitle']),
                ),
                Text(
                  "Description",
                  style: boldFont,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Text(widget.sInfo['surveyDesc']),
                ),
                Text(
                  "Share your response",
                  style: boldFont,
                ),
                Consumer<ParseForm>(
                    builder: (context, dForm, child) => Column(children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                dForm.generateForm(widget.sInfo['fields']),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      // side: BorderSide(color: Colors.red),
                                    ),
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    color: Colors.red[500],
                                    child: Text("Cancel",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  minWidth,
                                  FlatButton(
                                    onPressed: dForm.clearFields,
                                    child: Text("Clear"),
                                  ),
                                ],
                              ),
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  // side: BorderSide(color: Colors.red),
                                ),
                                color: primary,
                                onPressed: () async {
                                  var isSubmitted = await dForm.submitSurvey();
                                  if (isSubmitted == "success") {
                                    SnackBarWidget(
                                        isSubmitted, "success", _scaffoldKey);
                                  } else
                                    SnackBarWidget(
                                        isSubmitted, "fail", _scaffoldKey);
                                },
                                child: Text("Submit",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ],
                          )
                        ])),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
