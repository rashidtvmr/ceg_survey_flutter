import 'dart:async';

import 'package:Survey_App/Pages/LoginPage.dart';
import 'package:Survey_App/models/typography.dart';
import 'package:Survey_App/widget/MiniProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Variables
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _controller0 = TextEditingController();
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  bool _isLoading = false;

  _signUp() async {
    String name = _controller0.text;
    String email = _controller1.text;
    String password = _controller2.text;
    if (email.isEmpty || password.isEmpty) {
      showSnackBar("Enter valid Email or Password", "fail", _scaffoldKey);
    } else if (name.isEmpty) {
      showSnackBar("Name is required", "fail", _scaffoldKey);
    } else {
      if (_controller2.text != _controller3.text) {
        showSnackBar("Both password should be matched", "", _scaffoldKey);
      } else {
        toggleLoading();
        var dio = Dio();
        try {
          Response response = await dio.post(
              'https://thesurvey.herokuapp.com/api/v1/user',
              data: json.encode(
                  {"username": name, "email": email, "password": password}));
          showSnackBar("Account Created!!!😊😊😊", "success", _scaffoldKey);
          toggleLoading();
          Timer(
              Duration(seconds: 1),
              () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage())));
        } on DioError catch (e) {
          toggleLoading();
          String errorMsg = e.response.data.toString();
          showSnackBar(errorMsg, "fail", _scaffoldKey);
          print(errorMsg);
        }
      }
    }
  }

  toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  showSnackBar(String txt, String type, GlobalKey<ScaffoldState> contextKey) {
    final snackBar = SnackBar(
      content: Text(
        txt,
        style: TextStyle(
            color: type == "success" ? Colors.white : Colors.white,
            fontSize: 20),
      ),
      backgroundColor: type == "success" ? Colors.green : primary,
    );
    contextKey.currentState.showSnackBar(snackBar);
  }

  Widget _generateTextFormField(
      String fieldLabel, TextEditingController controller) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(5),
      child: TextFormField(
        controller: controller,
        decoration: new InputDecoration(
          labelText: fieldLabel,
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(5.0),
            // borderSide: new BorderSide(),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        obscureText:
            (fieldLabel == "Password" || fieldLabel == "Confirm Password")
                ? true
                : false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Signup",
          style: defaultTextStyle,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: primary),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _generateTextFormField("Name", _controller0),
            Container(
              height: 10,
            ),
            _generateTextFormField("Email", _controller1),
            // defaultHeight,
            Container(
              height: 10,
            ),
            _generateTextFormField("Password", _controller2),
            Container(
              height: 10,
            ),
            _generateTextFormField("Confirm Password", _controller3),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => LoginPage()));
                  },
                  child: Text(
                    "Already a user?",
                    style: defaultTextStyle,
                  ),
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      // side: BorderSide(color: Colors.red),
                    ),
                    elevation: 5,
                    color: primary,
                    onPressed: _signUp,
                    child: _isLoading
                        ? MiniProgressBar()
                        : Text(
                            "Register",
                            style: TextStyle(color: Colors.white),
                          ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
