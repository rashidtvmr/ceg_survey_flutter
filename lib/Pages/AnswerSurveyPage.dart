import 'package:Survey_App/Pages/SurveyPage.dart';
import 'package:Survey_App/models/app.dart';
import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class AnswerSurveyPage extends StatefulWidget {
  AnswerSurveyPage({Key key}) : super(key: key);

  @override
  _AnswerSurveyPageState createState() => _AnswerSurveyPageState();
}

class _AnswerSurveyPageState extends State<AnswerSurveyPage> {
  Future<List<dynamic>> getSurveys() async {
    try {
      String url = Provider.of<AppModel>(context).getServerURL;
      Dio dio = new Dio();
      var apiRespon = await dio.get('$url/api/v1/survey/all');
      var apiResponJson = apiRespon.data;
      return (apiResponJson['data']).toList();
    } on DioError catch (e) {
      if (e.response.statusCode == 404) {
        print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.request);
      }
      return null;
    }
  }

  void goToSurveyPage(var sInfo) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => SurveyPage(
              sInfo: sInfo,
            )));
  }

  Widget _generateGrid() {
    return FutureBuilder<List<dynamic>>(
      future: getSurveys(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: GridView.builder(
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () => goToSurveyPage(snapshot.data[index]),
                  child: Container(
                    margin: EdgeInsets.all(2),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: getRandomColor(),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 3,
                            color: Colors.grey.withOpacity(.2),
                            spreadRadius: 2,
                            offset: Offset(4, 4))
                      ],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: primary, width: 3),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data[index]['surveyTitle'],
                          style: defaultTextStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          snapshot.data[index]['surveyDesc'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
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
