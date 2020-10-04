import 'dart:async';

import 'package:Survey_App/models/app.dart';
import 'package:Survey_App/models/typography.dart';
import 'package:Survey_App/widget/MiniProgressBar.dart';
import 'package:Survey_App/widget/SnackBarWidget.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:provider/provider.dart';
// import 'htt';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  bool _isLoading = false;

  Widget _generateTextFormField(
      String fieldLabel, TextEditingController controller) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: controller,
        obscureText: fieldLabel == "Password" ? true : false,
        decoration: new InputDecoration(
          labelText: fieldLabel,
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(10.0),
            // borderSide: new BorderSide(),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
      ),
    );
  }

  _displaySnackBar(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          "Enter email to send reset password link.",
          style: TextStyle(fontSize: 15),
        ),
        content: _generateTextFormField("Email", _controller3),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "Cancel",
              style: TextStyle(color: primary),
            ),
          ),
          RaisedButton(
            color: primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text(
              "Reset",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => {},
          )
        ],
      ),
    );
  }

  _logMeIn() async {
    FocusScope.of(context).requestFocus(FocusNode());
    String email = _controller1.text;
    String password = _controller2.text;
    if (email.isEmpty || password.isEmpty) {
      showSnackBar("Ënter valid Email or Password", "");
    } else {
      toggleLoading();
      var dio = Dio();
      try {
        Response response = await dio.post(
            'https://thesurvey.herokuapp.com/api/v1/user/login',
            data: json.encode({"email": email, "password": password}));
        toggleLoading();
        Provider.of<AppModel>(context, listen: false).authenticate(true);
        Provider.of<AppModel>(context, listen: false)
            .setAuthCode(response.data['token']);
        Provider.of<AppModel>(context, listen: false)
            .setName(response.data['name']);
        showSnackBar('${response.data['msg']}😊😊😊', "success");
        print(response.data);
        Timer(Duration(milliseconds: 600), () => Navigator.of(context).pop());
      } on DioError catch (e) {
        toggleLoading();
        String errorMsg = e.response.data['msg'];
        showSnackBar(errorMsg, "fail");
        print(errorMsg);
      }
    }
  }

  toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  showSnackBar(String txt, String type) {
    final snackBar = SnackBar(
      content: Text(
        txt,
        style: TextStyle(
            color: type == "success" ? Colors.white : Colors.white,
            fontSize: 20),
      ),
      backgroundColor: type == "success" ? Colors.green : primary,
    );
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Login",
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
            _generateTextFormField("Email", _controller1),
            Container(
              height: 10,
            ),
            _generateTextFormField("Password", _controller2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => _displaySnackBar(context),
                  child: Text(
                    "Forget Password?",
                    style: defaultTextStyle,
                  ),
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // side: BorderSide(color: Colors.red),
                    ),
                    elevation: 5,
                    color: primary,
                    onPressed: _logMeIn,
                    child: _isLoading
                        ? MiniProgressBar()
                        : Text(
                            "Login",
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
