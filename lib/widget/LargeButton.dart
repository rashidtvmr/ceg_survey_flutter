import 'package:flutter/material.dart';
import '../models/typography.dart';

class LargeButton extends StatelessWidget {
  const LargeButton(this.buttonName, this.iconName, this.onPress);
  // : super(key: key);
  final String buttonName;
  final Function onPress;
  final IconData iconName;

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    return Container(
      child: InkWell(
        enableFeedback: true,
        radius: 10,
        onTap: onPress,
        child: Container(
          width: sw - 40,
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                    blurRadius: 5, color: Colors.black12, offset: Offset(1, 1))
              ],
              border: Border.all(color: Colors.black12, width: 1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Row(
                  children: [
                    Icon(
                      iconName,
                      color: primary,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        buttonName,
                        style: defaultTextStyle,
                      ),
                    )
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: primary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
