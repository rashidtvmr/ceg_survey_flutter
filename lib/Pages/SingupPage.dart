import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  SignupPage({Key key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          body: Container(
            child: Center(
              child: Text(
                "SignupPage",
                style: secondaryTextStyle,
              ),
            ),
          ),
        ),
        onWillPop: () async {
          print("on reg page");
          return true;
        });
  }
}
