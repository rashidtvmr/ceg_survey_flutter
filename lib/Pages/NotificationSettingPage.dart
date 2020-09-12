import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';

class NotificationSettingPage extends StatefulWidget {
  NotificationSettingPage({Key key}) : super(key: key);

  @override
  _NotificationSettingPageState createState() =>
      _NotificationSettingPageState();
}

class _NotificationSettingPageState extends State<NotificationSettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification",
          style: defaultTextStyle,
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: primary),
      ),
      body: Container(
        child: Column(
          children: [
            // Form(child: )
          ],
        ),
      ),
    );
  }
}
