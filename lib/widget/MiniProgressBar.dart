import 'package:flutter/material.dart';

class MiniProgressBar extends StatelessWidget {
  const MiniProgressBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 15,
      width: 15,
      child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation(Colors.white),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
