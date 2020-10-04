// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:Survey_App/models/typography.dart';
import 'package:Survey_App/widget/FieldCountLabel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'app.dart';

enum FieldType { Text, Number, Ratings, Checkbox, RadioButton }

class FormModel extends ChangeNotifier {
  int count = 0;
  String surveyTitle = "";
  String surveyDesc = "";
  bool isPublic = true;
  List<Widget> formList = <Widget>[];
  var textEditingControllerList = {};
  var popupMenuButtonList = {};
  var formData = {};

  String get getSurveyTitle => surveyTitle;
  String get getSurveyDesc => surveyDesc;
  bool get getVisibility => isPublic;

  String getFieldType(int index) => popupMenuButtonList[index];

  void setSurveyTitle(String pld) {
    this.surveyTitle = pld;
    // notifyListeners();
  }

  void setSurveyDesc(String pld) {
    this.surveyDesc = pld;
    // notifyListeners();
  }

  void setVisibilty(bool pld) {
    this.isPublic = !this.isPublic;
    notifyListeners();
  }

  Widget _generatePopupMenuButton(int lCount) {
    int localCount = lCount;
    popupMenuButtonList[localCount] = "Text";

    return PopupMenuButton<String>(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2.5, color: primary),
        ),
        child: Text(getFieldType(localCount)),
      ),
      onSelected: (String result) {
        print("lc$localCount");
        popupMenuButtonList[localCount] = result;
        // notifyListeners();
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: "Text",
          child: Text('Text'),
        ),
        const PopupMenuItem<String>(
          value: "Number",
          child: Text('Number'),
        ),
        const PopupMenuItem<String>(
          value: "Ratings",
          child: Text('Ratings'),
        ),
        const PopupMenuItem<String>(
          value: "Checkbox",
          child: Text('Checkbox'),
        ),
      ],
    );
  }

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

  Widget _generateField(TextEditingController controller1, int lCount) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          margin: EdgeInsets.only(top: 10, bottom: 2, right: 10, left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 2.5, color: primary),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _generateTextFormField(
                  "Field Title", TextInputType.text, controller1),
              minHeight,
              Row(
                children: [
                  Text(
                    "Field type",
                    style: defaultTextStyle,
                  ),
                  defaultWidth,
                  _generatePopupMenuButton(count)
                ],
              )
            ],
          ),
        ),
        FieldCountBadge(
          count: lCount,
        )
      ],
    );
  }

  void addField() {
    textEditingControllerList['controller$count'] = new TextEditingController();
    formList.add(
        _generateField(textEditingControllerList["controller$count"], count));
    count++;
    notifyListeners();
  }

  List<Widget> generateFormFields() {
    return formList;
  }

  removeFields() {
    if (formList.length == 0) return;
    formList.removeLast();
    textEditingControllerList.remove("controller${count - 1}");
    popupMenuButtonList.remove(count - 1);
    count--;
    notifyListeners();
  }

  Future<dynamic> publishSurvey(BuildContext context) async {
    formData["surveyTitle"] = this.getSurveyTitle;
    formData["surveyDesc"] = this.getSurveyDesc;
    formData["visibility"] = this.isPublic;
    formData["fields"] = [];
    int dCount = 0;
    textEditingControllerList.forEach((key, value) {
      formData["fields"].add({
        "fieldCount": dCount,
        "fieldName": value.text,
        "fieldType": popupMenuButtonList[dCount]
      });
      dCount++;
    });
    String isValidFields = await validateFields();
    if (isValidFields == "success") return await postData(context);
    // await postData(context);
    return isValidFields;
  }

  Future<String> validateFields() async {
    if (this.getSurveyTitle.isEmpty || this.getSurveyDesc.isEmpty)
      return "Survey title and description is must";
    else {
      if (formData['fields'].length == 0) return "Add atleast one field";
      String ss = "success";
      for (int i = 0; i < formData['fields'].length; i++) {
        var value = formData['fields'][i];
        if (value['fieldName'].isEmpty) {
          ss = "Enter valid field name!";
          break;
        }
      }
      return ss;
    }
  }

  Future<void> clearFields() async {
    this.formData = {};
    this.formList.clear();
    this.setSurveyTitle("");
    this.setSurveyDesc("");
    notifyListeners();
  }

  Future<dynamic> postData(BuildContext context) async {
    // String serverURL = "https://thesurvey.herokuapp.com";
    String url = Provider.of<AppModel>(context, listen: false).getServerURL;
    String authCode = Provider.of<AppModel>(context, listen: false).getAuthCode;
    Dio dio = new Dio();
    try {
      Response response = await dio.post(
        "$url/api/v1/survey",
        data: json.encode(formData),
        options: Options(
          headers: {
            "Authorization": "Bearer ${authCode}", // set content-length
          },
        ),
      );
      await clearFields();
      print(response);
      return "success";
    } on DioError catch (e) {
      print("Errrrrrrr:${e}");
      String errorMsg = e.response.toString();
      return errorMsg;
    }
  }
}
