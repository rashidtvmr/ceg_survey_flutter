import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';

class MyResponsePage extends StatefulWidget {
  MyResponsePage({Key key}) : super(key: key);

  @override
  _MyResponsePageState createState() => _MyResponsePageState();
}

class _MyResponsePageState extends State<MyResponsePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "My Response",
          style: defaultTextStyle,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: primary),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Text("No reponse yet😥"),
            )
          ],
        ),
      ),
    );
  }
}
