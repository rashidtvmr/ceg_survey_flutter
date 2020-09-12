import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';

class AboutUSPage extends StatefulWidget {
  AboutUSPage({Key key}) : super(key: key);

  @override
  _AboutUSPageState createState() => _AboutUSPageState();
}

class _AboutUSPageState extends State<AboutUSPage> {
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
          children: [],
        ),
      ),
    );
  }
}
