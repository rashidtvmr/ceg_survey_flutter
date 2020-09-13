import 'package:Survey_App/widget/ExtraLargeButton.dart';
import 'package:flutter/material.dart';

import 'package:Survey_App/models/typography.dart';
import 'package:Survey_App/widget/LargeButton.dart';
import 'package:Survey_App/Pages/CreateSurveyPage.dart';
import 'package:Survey_App/Pages/AnswerSurveyPage.dart';
import 'package:Survey_App/Pages/MySurveyPage.dart';
import 'package:Survey_App/Pages/MyResponsePage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget mainPageButton(String name, Color color, Color textColor,
      IconData icon, Function onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: textColor,
              size: 40,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  name,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: textColor,
              size: 30,
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: color,
            border: Border.all(color: primary),
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(.38),
                  spreadRadius: 1)
            ],
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
              onTap: () => {goToAnotherPage("create")},
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
              onTap: () => {goToAnotherPage("survey")},
            ),
            ExtraLargeButton(
              name: "View My Response",
              color: primary,
              textColor: Colors.white,
              icon: Icons.create,
              onTap: () => {goToAnotherPage("response")},
            )
          ],
        ),
      ),
    );
  }
}
