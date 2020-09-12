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
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                style: defaultTextStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
