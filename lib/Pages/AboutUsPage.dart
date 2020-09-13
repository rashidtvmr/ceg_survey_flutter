import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUSPage extends StatefulWidget {
  AboutUSPage({Key key}) : super(key: key);

  @override
  _AboutUSPageState createState() => _AboutUSPageState();
}

class _AboutUSPageState extends State<AboutUSPage> {
  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewWithJavaScript(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchInWebViewWithDomStorage(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableDomStorage: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _listItem(String name, String email) {
    String toLaunch = "mailto:" + email + "?subject=From Survey App";
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 1,
                offset: Offset(2, 2),
                color: Colors.white.withOpacity(.3),
                spreadRadius: 1)
          ],
          border: Border.all(color: primary, width: 2),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.person,
            color: primary,
            size: 30,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                name,
                style: defaultTextStyle,
              ),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.open_in_new,
                color: primary,
              ),
              onPressed: () => {launch(toLaunch)})
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: defaultTextStyle,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: primary),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10, left: 12),
              child: Text(
                "About App :",
                textAlign: TextAlign.left,
                style: defaultTextStyle,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: primary, width: 2)),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "The survey app helps students to conduct survey online, getopinionsfrom other students across the college and get a better of what they are looking for.This survey app builds aforumwherestudents can share their views and opinions.",
                      textAlign: TextAlign.justify,
                      style: defaultTextStyle,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Students can conduct a survey. The respondentscan be a guest or a valid user. The survey itself can be public or private as per thechoice of the survey creator.",
                      textAlign: TextAlign.justify,
                      style: defaultTextStyle,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Once the survey is completed the responsecan be downloaded as an excelfile. The response can also be viewedin the form of graphs and chartswithin the app for better understanding.",
                      textAlign: TextAlign.justify,
                      style: defaultTextStyle,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, left: 12),
              child: Text(
                "Our Team :",
                textAlign: TextAlign.left,
                style: defaultTextStyle,
              ),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Column(
                  children: [
                    _listItem("Abishek", ""),
                    _listItem("Meera", ""),
                    _listItem("Madumitha", ""),
                    _listItem("Rashid", "rashidtvmr@gmail.com"),
                    _listItem("Sandiya", ""),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
