import 'package:Survey_App/models/typography.dart';
import 'package:Survey_App/widget/MiniProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class CreateSurveyPage extends StatefulWidget {
  CreateSurveyPage({Key key}) : super(key: key);

  @override
  _CreateSurveyPageState createState() => _CreateSurveyPageState();
}

class _CreateSurveyPageState extends State<CreateSurveyPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  TextEditingController _controller1 = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();

  Widget _generateTextFormField(
      String fieldLabel, TextInputType type, TextEditingController controller) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: controller,
        maxLines: type == TextInputType.multiline ? 10 : 1,
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

  void _postSurvey() async {
    FocusScope.of(context).requestFocus(FocusNode());
    showHideLoading();
    String title = _controller1.text;
    String desc = _controller2.text;
    if (title.isEmpty || desc.isEmpty)
      showSnackBar("Enter title and desc", "fail");
    else {
      Dio dio = new Dio();
      try {
        Response response = await dio.post(
            "https://thesurvey.herokuapp.com/api/v1/survey",
            data: json.encode({"title": title, "desc": desc}));
        showHideLoading();
        showSnackBar("Successfully posted", "success");
      } on DioError catch (e) {
        showHideLoading();
        String errorMsg = e.response.data.toString();
        showSnackBar(errorMsg, "fail");
      }
    }
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

  showHideLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Create Survey",
          style: defaultTextStyle,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: primary),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            defaultHeight,
            _generateTextFormField(
                "Enter survey title", TextInputType.text, _controller1),
            Container(
              height: 10,
            ),
            _generateTextFormField(
                "Describe your survey", TextInputType.multiline, _controller2),
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
                  onPressed: _postSurvey,
                  child: _isLoading
                      ? MiniProgressBar()
                      : Text(
                          "Post",
                          style: TextStyle(color: Colors.white),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
