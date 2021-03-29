import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:swipe_app/global/style/text_styles.dart';

class FloatingButton extends StatelessWidget {
  final String title;
  final String cost;
  final String icon;
  final Gradient gradient;
  final Color borderColor;
  const FloatingButton({
    Key key,
    @required this.title, this.cost, this.icon, this.gradient, this.borderColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: borderColor),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(icon, width: 55, height: 55,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: SemiBoldText(17, Color(0xff374252)),),
                SizedBox(height: 12),
                Row(
                  children: [
                  Text("Эффективность", style: MediumText(10, Color(0xff989BA0)),),
                  SizedBox(width: 7),
                  Container(
                    height: 10, width: 36,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      gradient: gradient
                    ),
                  ),
                  SizedBox(width: 17),
                  Text(cost, style: MediumText(10, Color(0xff374252)),),
                ],),
              ],
            ),
          ],
        ),
      ),
    );
  }
}