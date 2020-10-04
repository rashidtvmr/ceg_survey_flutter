import 'dart:async';

import 'package:Survey_App/Pages/LoginPage.dart';
import 'package:Survey_App/models/app.dart';
import 'package:Survey_App/widget/ExtraLargeButton.dart';
import 'package:flutter/material.dart';

import 'package:Survey_App/models/typography.dart';
import 'package:Survey_App/Pages/CreateSurveyPage.dart';
import 'package:Survey_App/Pages/AnswerSurveyPage.dart';
import 'package:Survey_App/Pages/MySurveyPage.dart';
import 'package:Survey_App/Pages/MyResponsePage.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void goToAnotherPage(String pageName) {
    if (pageName == 'create') {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => CreateSurveyPage()));
    } else if (pageName == 'answer') {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => AnswerSurveyPage()));
    } else if (pageName == 'survey') {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => MySurveyPage()));
    } else if (pageName == 'response') {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => MyResponsePage()));
    }
  }

  void showLoginDialog(String txt) {
    String showText = "Login to perform this task.";
    if (txt == "create")
      showText = "Login to create survey";
    else if (txt == "survey")
      showText = "Login to view survey response";
    else
      showText = "Login to view your response";
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(showText),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        actions: [
          FlatButton(
            child: Text("Cancel"),
            onPressed: () => {Navigator.of(context).pop()},
          ),
          RaisedButton(
            color: primary,
            child: Text("Login"),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              Navigator.of(context).pop();
              Timer(
                Duration(milliseconds: 100),
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => LoginPage(),
                  ),
                ),
              );
              ;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Consumer<AppModel>(
          builder: (context, app, child) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              defaultHeight,
              Container(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "The Survey App",
                    style: headerStyle,
                  ),
                ),
              ),
              defaultHeight,
              defaultHeight,
              ExtraLargeButton(
                name: "Create Survey",
                color: primary,
                textColor: Colors.white,
                icon: Icons.create,
                onTap: () => {
                  app.getAuth
                      ? goToAnotherPage("create")
                      : showLoginDialog("create")
                },
              ),
              ExtraLargeButton(
                name: "Answer Survey",
                color: primary,
                textColor: Colors.white,
                icon: Icons.sentiment_satisfied,
                onTap: () => {goToAnotherPage("answer")},
              ),
              ExtraLargeButton(
                name: "View My Survey",
                color: primary,
                textColor: Colors.white,
                icon: Icons.history,
                onTap: () => {
                  app.getAuth
                      ? goToAnotherPage("survey")
                      : showLoginDialog("survey")
                },
              ),
              ExtraLargeButton(
                name: "View My Response",
                color: primary,
                textColor: Colors.white,
                icon: Icons.create,
                onTap: () => {
                  app.getAuth
                      ? goToAnotherPage("response")
                      : showLoginDialog("response")
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
