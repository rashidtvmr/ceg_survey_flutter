import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class AnswerSurveyPage extends StatefulWidget {
  AnswerSurveyPage({Key key}) : super(key: key);

  @override
  _AnswerSurveyPageState createState() => _AnswerSurveyPageState();
}

class _AnswerSurveyPageState extends State<AnswerSurveyPage> {
  Future<List<dynamic>> getSurveys() async {
    try {
      Dio dio = new Dio();
      var apiRespon =
          await dio.get('https://thesurvey.herokuapp.com/api/v1/survey');
      var apiResponJson = apiRespon.data;
      print("MYyyyyyyyyyyyyyyyyyyyyyyyyy");
      print(apiResponJson['data'].toList());
      return (apiResponJson['data']).toList();
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
    }
  }

  Widget _generateGrid() {
    return FutureBuilder<List<dynamic>>(
      future: getSurveys(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(2),
                  color: getRandomColor(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        snapshot.data[index]['title'],
                        style: defaultTextStyle,
                      ),
                      Text(snapshot.data[index]['desc'])
                    ],
                  ),
                );
                // ListTile(
                //   title: Text(snapshot.data[index]['title']),
                //   subtitle: Text(snapshot.data[index]['desc']),
                // );
              },
            ),
          );
        } else if (snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return CircularProgressIndicator();
      },
    );
    // return CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Surveys",
          style: defaultTextStyle,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: primary),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: _generateGrid(),
      ),
    );
  }
}
