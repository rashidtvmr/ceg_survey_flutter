import 'package:flutter/material.dart';
import '../models/typography.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Widget SearchBar() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            decoration: new InputDecoration(
              labelText: "Search",
              fillColor: Colors.white,
              focusColor: Colors.red,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: new BorderSide(),
              ),
              //fillColor: Colors.green
            ),
            validator: (val) {
              if (val.length == 0) {
                return "Email cannot be empty";
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          alignment: Alignment(0.9, 0),
          child: Icon(
            Icons.search,
            size: 30,
            color: primary,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          defaultHeight,
          defaultHeight,
          Center(
            child: Text("Search Surveys", style: defaultTextStyle),
          ),
          defaultHeight,
          SearchBar()
        ],
      ),
    );
  }
}
