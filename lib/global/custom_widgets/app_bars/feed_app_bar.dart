import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/screens/favourites/favourites_screen.dart';
import 'file:///C:/flutter_projects/flutterlearning/flutter_Dart_courses/swipe_app/lib/screens/filters_screen/filter_screen.dart';
AppBar CustomFeedAppBar(String phone, BuildContext context){
  return AppBar(
    elevation: 0.0,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Color(0xff27AEA4)),
    actions: [
      TextButton.icon(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> FilteredAdsScreen())),
          icon: Icon(CupertinoIcons.slider_horizontal_3), label:
      Text("Уточнить поиск", style: RegularText(12, Color(0xff828282)))),
      TextButton.icon(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=> FavouriteScreen(phone))),
          icon: Icon(CupertinoIcons.check_mark_circled, color: Color(0xff27AE60)),
          label: Text("Избранное", style: RegularText(12, Color(0xff828282)))),
    ],
  );
}