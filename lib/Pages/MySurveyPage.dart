import 'package:Survey_App/Pages/LoginPage.dart';
import 'package:Survey_App/models/app.dart';
import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

class MySurveyPage extends StatefulWidget {
  MySurveyPage({Key key}) : super(key: key);

  @override
  _MySurveyPageState createState() => _MySurveyPageState();
}

class _MySurveyPageState extends State<MySurveyPage> {
  Future<List<dynamic>> getSurveys() async {
    if (!Provider.of<AppModel>(context, listen: false).getAuth)
      return Navigator.push(
          context, MaterialPageRoute(builder: (_) => LoginPage()));
    String authCode = Provider.of<AppModel>(context, listen: false).getAuthCode;
    try {
      Dio dio = new Dio();
      var apiRespon = await dio.get(
        'https://thesurvey.herokuapp.com/api/v1/survey',
        options: Options(
          headers: {
            "Authorization": "Bearer ${authCode}", // set content-length
          },
        ),
      );
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
                return Container(
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: getRandomColor(),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 3,
                          color: Colors.grey.withOpacity(.2),
                          spreadRadius: 2,
                          offset: Offset(4, 4))
                    ],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: primary, width: 3),
                  ),
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

  void _test() async {
    String authCode = Provider.of<AppModel>(context, listen: false).getAuthCode;
    try {
      Dio dio = new Dio();
      var apiRespon = await dio.get(
        'http://192.168.43.229:3003/api/v1/survey',
        options: Options(
          headers: {
            "Authorization": "Bearer $authCode", // set content-length
          },
        ),
      );
      var apiResponJson = apiRespon.data;
      print(apiResponJson);
    } on DioError catch (e) {
      print(e);
    }
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: _generateGrid(),
          ),
        ],
      ),
    );
  }
}
