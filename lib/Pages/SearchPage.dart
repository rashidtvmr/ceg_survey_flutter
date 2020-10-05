import 'package:flutter/material.dart';
import '../models/typography.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Widget searchBar() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: TextFormField(
            decoration: new InputDecoration(
                labelText: "Search",
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                ),
                suffixIcon:
                    IconButton(icon: Icon(Icons.search), onPressed: () => {})),
            keyboardType: TextInputType.text,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
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
          searchBar()
        ],
      ),
    );
  }
}
