import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
            _generateTextFormField("Email"),
            // defaultHeight,
            Container(
              height: 10,
            ),
            _generateTextFormField("Password"),
            Container(
              height: 10,
            ),
            _generateTextFormField("Confirm Password"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Already a user?",
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
