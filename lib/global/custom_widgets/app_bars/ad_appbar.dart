import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/text_styles.dart';
AppBar AdAppBar(){
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Color(0xff27AEA4)),
    actions: [
       IconButton(icon: Icon(CupertinoIcons.check_mark_circled), color: Color(0xff27AE60), onPressed: null,),
    ],
  );
}