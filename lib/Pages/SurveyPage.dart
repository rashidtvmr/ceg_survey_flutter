import 'package:Survey_App/models/app.dart';
import 'package:Survey_App/models/typography.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SurveyPage extends StatefulWidget {
  String sid = "";
  SurveyPage({Key key, this.sid}) : super(key: key);

  @override
  _SurveyPageState createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String appBarTitle = "Loading...";
  bool _isLoading = true;

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

  toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<String> getSurvey(BuildContext context, String sid) async {
    String url = Provider.of<AppModel>(context).getServerURL;
    Dio dio = new Dio();
    try {
      var response = await dio.get("$url/api/v1/survey/$sid");
      var apiResponJson = response.data;
      print(apiResponJson['data']);
      return (apiResponJson['data']);
    } on DioError catch (e) {
      // toggleLoading();
      print(e);
      String errorMsg = e.response.data.toString();
      showSnackBar(errorMsg, "fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primary),
        title: Text(appBarTitle, style: defaultTextStyle),
      ),
      body: Container(
        child: FutureBuilder<String>(
          future: getSurvey(context, widget.sid),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print("bp 1:${snapshot.hasData}");
            if (snapshot.hasData) {
              print("lkabdafsikd${snapshot.data}");
              return Container(
                child: Container(child: Text(snapshot.data)),
              );
            } else if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return Center(
              child: Text("No data 😥", style: defaultTextStyle),
            );
          },
        ),
      ),
    );
  }
}
