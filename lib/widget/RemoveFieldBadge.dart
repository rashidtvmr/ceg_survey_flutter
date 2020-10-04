import 'package:flutter/material.dart';

class RemoveFieldBadge extends StatelessWidget {
  Function removeFieldAtIndex;
  int count;
  RemoveFieldBadge({Key key, this.count, this.removeFieldAtIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -1,
      right: 2,
      child: InkWell(
        onTap: () => {removeFieldAtIndex(count)},
        child: Container(
          width: 20,
          height: 20,
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(50)),
          // alignment: Alignment(-1.1, -1),
          child: Center(
            child: Text(
              "X",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
