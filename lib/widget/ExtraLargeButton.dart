import 'package:flutter/material.dart';
import 'package:Survey_App/models/typography.dart';

class ExtraLargeButton extends StatelessWidget {
  final Function onTap;
  final String name;
  final Color color, textColor;
  final IconData icon;
  ExtraLargeButton(
      {Key key, this.name, this.color, this.textColor, this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 15),
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              icon,
              color: textColor,
              size: 40,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  name,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: textColor,
              size: 30,
            ),
          ],
        ),
        decoration: BoxDecoration(
            color: color,
            border: Border.all(color: primary),
            boxShadow: [
              BoxShadow(
                  offset: Offset(2, 2),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(.38),
                  spreadRadius: 1)
            ],
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
