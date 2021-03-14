import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:swipe_app/basicThings/basic.dart';
AppBar CustomFeedAppBar(){
  String tooltip = "Избранное";
  return AppBar(
    //leading: Icon(CupertinoIcons.line_horizontal_3),//IconButton(icon: )
    elevation: 0.0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Color(0xff27AEA4)),
    actions: [
      TextButton.icon(onPressed: null, icon: Icon(CupertinoIcons.slider_horizontal_3), label: Text("Уточнить поиск", style: RegularText(12, Color(0xff828282)))),
      TextButton.icon(onPressed: null, icon: Icon(CupertinoIcons.check_mark_circled, color: Color(0xff27AE60)), label: Text("Избранное", style: RegularText(12, Color(0xff828282)))),
    ],
  );
}