import 'package:flutter/material.dart';

import 'package:swipe_app/global/style/text_styles.dart';

Widget CustomDropDown(String text, void func()) {
  return Container(
    width: 390,
    height: 64,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10)        ,
        color: Colors.transparent, border: Border.all(color: Color(0xffE1E1E1))),
    child: Row(
      children: [
        SizedBox(width: 24),
        Container(width: 310, child: Text(text,style: RegularText(16, Color(0xff2E2E2E)),)),
        IconButton(icon: Icon(Icons.keyboard_arrow_down), onPressed: func)
      ],
    ),
  );
}