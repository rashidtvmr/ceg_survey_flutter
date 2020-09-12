import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  HelpPage({Key key}) : super(key: key);

  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  Widget _generateTextFormField(String fieldLabel, TextInputType type) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        maxLines: type == TextInputType.multiline ? 15 : 1,
        decoration: new InputDecoration(
          labelText: fieldLabel,
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderRadius: new BorderRadius.circular(10.0),
          ),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Help",
            style: defaultTextStyle,
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          iconTheme: IconThemeData(color: primary),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Text(
                    "If you feel any difficulty using this app reach to us through support@surveyapp.com or if you find any issue or bug or have an idea of feature please create your ticket by submitting below form",
                    style: defaultTextStyle,
                  ),
                ),
                Column(
                  children: [
                    defaultHeight,
                    _generateTextFormField(
                        "Issue/Feature Title", TextInputType.text),
                    Container(
                      height: 10,
                    ),
                    _generateTextFormField(
                        "Describe your issue", TextInputType.multiline),
                    // defaultHeight,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            // side: BorderSide(color: Colors.red),
                          ),
                          elevation: 3,
                          color: primary,
                          onPressed: () => {},
                          child: Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
