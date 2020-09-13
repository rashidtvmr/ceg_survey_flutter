import 'package:flutter/material.dart';
import '../models/typography.dart';

class NotificationPage extends StatefulWidget {
  NotificationPage({Key key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          defaultHeight,
          defaultHeight,
          Center(
            child: Text("Recent Notifications", style: defaultTextStyle),
          ),
          defaultHeight,
          defaultHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("No new notification"),
              Icon(Icons.sentiment_dissatisfied)
            ],
          )
        ],
      ),
    );
  }
}
