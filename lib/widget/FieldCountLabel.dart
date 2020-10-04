import 'package:Survey_App/models/typography.dart';
import 'package:flutter/material.dart';

class FieldCountBadge extends StatelessWidget {
  final int count;
  FieldCountBadge({Key key, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0.8,
      child: Container(
          width: 20,
          height: 20,
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
              color: primary,
              border: Border.all(color: primary, width: 1),
              borderRadius: BorderRadius.circular(50)),
          // alignment: Alignment(-1.1, -1),
          child: Center(
            child: Text(
              (count + 1).toString(),
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }
}
