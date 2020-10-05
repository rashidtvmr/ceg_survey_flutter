import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ParseForm extends ChangeNotifier {
  bool isLoading = true;
  String surveyId = "";
  TextEditingController dConttoller = TextEditingController();
  var textEditingControllerList = {};
  var formData = [];
  var fieldTemplate;

  String get getSureveyId => surveyId;
  void setSurveyId(String sid) {
    this.surveyId = sid;
    notifyListeners();
  }

  Widget _generateTextFormField(
      String fieldLabel, TextInputType type, TextEditingController controller) {
    print(fieldLabel);
    print(type);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(5),
        child: TextFormField(
          controller: controller,
          maxLines: type == TextInputType.multiline ? 3 : 1,
          decoration: new InputDecoration(
            labelText: fieldLabel,
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(5.0),
            ),
          ),
          keyboardType: type,
        ),
      ),
    );
  }

  Widget _generateFields(var field, TextEditingController controller) {
    if (field['fieldType'] == "Text") {
      return _generateTextFormField(
          field['fieldName'], TextInputType.text, controller);
    } else if (field['fieldType'] == "Paragraph") {
      return _generateTextFormField(
          field['fieldName'], TextInputType.multiline, controller);
    } else if (field['fieldType'] == "Date") {
      print('cb:$field');
      return _generateTextFormField(
          field['fieldName'], TextInputType.numberWithOptions(), controller);
    } else if (field['fieldType'] == "Number") {
      print('cb:$field');
      return _generateTextFormField(
          field['fieldName'], TextInputType.number, controller);
    } else if (field['fieldType'] == "Ratings") {
      print('cb:$field');
      return _generateTextFormField(
          field['fieldName'], TextInputType.datetime, controller);
    } else if (field['fieldType'] == "Checkbox") {
      print('cb:$field');
      return _generateTextFormField(
          field['fieldName'], TextInputType.numberWithOptions(), controller);
    }
  }

  generateForm(var fInfo) {
    // print(fInfo);
    fieldTemplate = fInfo;
    List<Widget> widgetList = [];
    int count = 0;
    fInfo.forEach((field) {
      textEditingControllerList[count] = new TextEditingController();
      widgetList.add(_generateFields(field, textEditingControllerList[count]));
      count++;
    });
    print('list of widget:$widgetList');
    return widgetList;
  }

  Future clearFields() {
    for (int i = 0; i < textEditingControllerList.length; i++) {
      print(textEditingControllerList[i].text = "");
    }
  }

  Future<String> submitSurvey() async {
    String isValid = validateFields();
    for (int i = 0; i < textEditingControllerList.length; i++) {
      formData.add(
          {"fieldCount": i, "response": textEditingControllerList[i].text});
      // print(textEditingControllerList[i].text);
      print(fieldTemplate);
      print("fTemp:${formData[i]}");
    }
    if (isValid == "success") {
      for (int i = 0; i < textEditingControllerList.length; i++) {
        print(textEditingControllerList[i].text);
      }
      return "success";
    } else
      return isValid;
  }

  String validateFields() {
    String ss = "success";
    for (int i = 0; i < textEditingControllerList.length; i++) {
      if (textEditingControllerList[i].text.isEmpty) {
        ss = "All fields are required";
        break;
      }
    }
    return ss;
  }
}
