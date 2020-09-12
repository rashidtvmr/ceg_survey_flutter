import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _generateTextFormField(String fieldLabel) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        decoration: new InputDecoration(
          labelText: fieldLabel,
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(10.0),
            // borderSide: new BorderSide(),
          ),
        ),
        validator: (val) {
          if (val.length == 0) {
            return "Email cannot be empty";
          } else {
            return null;
          }
        },
        keyboardType: TextInputType.text,
        style: new TextStyle(
          fontFamily: "Poppins",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            _generateTextFormField("Email"),
            // defaultHeight,
            Container(
              height: 10,
            ),
            _generateTextFormField("Password"),
            // defaultHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Foget Password?",
                  style: defaultTextStyle,
                ),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // side: BorderSide(color: Colors.red),
                    ),
                    elevation: 5,
                    color: primary,
                    onPressed: () => {},
                    child: Text(
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
