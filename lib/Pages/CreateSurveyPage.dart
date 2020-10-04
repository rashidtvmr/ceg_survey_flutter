import 'package:Survey_App/models/Form.dart';
import 'package:Survey_App/models/app.dart';
import 'package:Survey_App/models/typography.dart';
import 'package:Survey_App/widget/MiniProgressBar.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

// import 'LoginPage.dart';

class CreateSurveyPage extends StatefulWidget {
  CreateSurveyPage({Key key}) : super(key: key);

  @override
  _CreateSurveyPageState createState() => _CreateSurveyPageState();
}

enum FieldType { Text, Number, Ratings, Checkbox, RadioButton }
enum Visibility { public, private }

class _CreateSurveyPageState extends State<CreateSurveyPage> {
  Visibility _currentVisibility = Visibility.public;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  FieldType _selectedFieldType = FieldType.Text;

  TextEditingController _surveyTitleController = new TextEditingController();
  TextEditingController _surveyDescController = new TextEditingController();

  Widget _generateTextFormField(
      String fieldLabel, TextInputType type, TextEditingController controller) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: controller,
        maxLines: type == TextInputType.multiline ? 3 : 1,
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
    showHideLoading();
    String title = _surveyTitleController.text;
    String desc = _surveyDescController.text;
    // if (!Provider.of<AppModel>(context, listen: false).getAuth) {
    //   return Navigator.push(
    //       context, MaterialPageRoute(builder: (_) => LoginPage()));
    // }
    String authCode = Provider.of<AppModel>(context, listen: false).getAuthCode;

    if (title.isEmpty || desc.isEmpty)
      showSnackBar("Enter title and desc", "fail");
    else {
      Dio dio = new Dio();
      try {
        Response response = await dio.post(
          "https://thesurvey.herokuapp.com/api/v1/survey",
          data: json.encode({"title": title, "desc": desc}),
          options: Options(
            headers: {
              "Authorization": "Bearer ${authCode}", // set content-length
            },
          ),
        );
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

  Widget _radioButton() {
    return Row(
      children: [
        Radio(
          value: Visibility.public,
          groupValue: _currentVisibility,
          onChanged: (Visibility value) {
            setState(() {
              _currentVisibility = value;
            });
          },
        ),
        InkWell(
          child: Text(
            "Public",
            style: defaultTextStyle,
          ),
          onTap: () {
            setState(() {
              _currentVisibility = Visibility.public;
            });
          },
        ),
        Radio(
          value: Visibility.private,
          groupValue: _currentVisibility,
          onChanged: (Visibility value) {
            setState(() {
              _currentVisibility = value;
            });
          },
        ),
        InkWell(
          child: Text(
            "Private",
            style: defaultTextStyle,
          ),
          onTap: () {
            setState(() {
              _currentVisibility = Visibility.private;
            });
          },
        ),
      ],
    );
  }

  Widget _generatePopupMenuButton() {
    return PopupMenuButton<FieldType>(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2.5, color: primary),
        ),
        child: Text(_selectedFieldType.toString().split('.')[1]),
      ),
      onSelected: (FieldType result) {
        setState(() {
          _selectedFieldType = result;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<FieldType>>[
        const PopupMenuItem<FieldType>(
          value: FieldType.Text,
          child: Text('Text'),
        ),
        const PopupMenuItem<FieldType>(
          value: FieldType.Number,
          child: Text('Number'),
        ),
        const PopupMenuItem<FieldType>(
          value: FieldType.Ratings,
          child: Text('Ratings'),
        ),
        const PopupMenuItem<FieldType>(
          value: FieldType.Checkbox,
          child: Text('Checkbox'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FormModel(),
      child: Scaffold(
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
        body: SingleChildScrollView(
          // controller: _scrollController,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Survey Detail",
                    style: boldFont,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2.5, color: primary),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _generateTextFormField("Survey Title", TextInputType.text,
                          _surveyTitleController),
                      SizedBox(
                        height: 10,
                      ),
                      _generateTextFormField("Survey Description",
                          TextInputType.multiline, _surveyDescController),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.sp,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Visibilty :",
                            style: defaultTextStyle,
                          ),
                          _radioButton(),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 5, top: 10),
                  child: Text(
                    "Field Info",
                    style: boldFont,
                  ),
                ),
                Container(
                  // width: 499,
                  height: 440,
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2.5, color: primary),
                  ),
                  child: SingleChildScrollView(
                    child: Consumer<FormModel>(
                      builder: (context, dForm, child) => Column(
                        children: dForm.formList.length == 0
                            ? [
                                Center(
                                    child: Text(
                                        "Click \"Add Fields\" button to add fields. "))
                              ]
                            : dForm.generateFormFields(),
                      ),
                    ),
                  ),
                ),
                Consumer<FormModel>(
                  builder: (context, dForm, child) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              // side: BorderSide(color: Colors.red),
                            ),
                            elevation: 3,
                            color: primary,
                            onPressed: dForm.addField,
                            child: Text(
                              "Add Fields",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          minWidth,
                          dForm.formList.length != 0
                              ? RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    // side: BorderSide(color: Colors.red),
                                  ),
                                  elevation: 3,
                                  color: Colors.red[500],
                                  onPressed: dForm.removeFields,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                )
                              : emptyContainer,
                        ],
                      ),
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          // side: BorderSide(color: Colors.red),
                        ),
                        elevation: 3,
                        color: primary,
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          dForm.setSurveyTitle(_surveyTitleController.text);
                          dForm.setSurveyDesc(_surveyDescController.text);
                          dForm.setVisibilty(Visibility == Visibility.private);
                          var isSurveyPublished =
                              await dForm.publishSurvey(context);
                          if (isSurveyPublished == "success") {
                            showSnackBar(
                                "Survey published successfully", "success");
                          } else {
                            showSnackBar(isSurveyPublished.toString(), "fail");
                          }
                        },
                        child: _isLoading
                            ? MiniProgressBar()
                            : Text(
                                "Post",
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
