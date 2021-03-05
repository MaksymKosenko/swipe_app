import 'package:flutter/material.dart';
import 'package:swipe_app/screens/myAD/confirmation/FloatingButton.dart';

class IconsVariant extends StatefulWidget {
  @override
  _IconsVariantState createState() => _IconsVariantState();
}

class _IconsVariantState extends State<IconsVariant> {
  changeChosen(String activeIcon){
    setState(() {
      switch(activeIcon){
        case "active1": active1 = !active1; active3 =false; break;//true; active3 = false; break;
        case "active2": active2 = !active2; active3 =false; break;//true; active3 = false; break;
        case "active3": active3 = !active3; if(active3 == true){active2 = false; active1 = false;}break;//false; active2 = false; active3 = true; break;
      }
    });
  }
  bool active1 = false;
  bool active2 = false;
  bool active3 = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: ()=> changeChosen("active1"),
          child: active1
              ? FloatingButton(title: "Большое объявление", cost: "399₴", icon: "lib/assets/images/icon_arrows.png", gradient: LinearGradient(
              begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xff65DED5), Color(0xff75FADB)]), borderColor: Color(0xff27AEA4))
              :FloatingButton(title: "Большое объявление", cost: "399₴", icon: "lib/assets/images/icon_arrows.png", gradient: LinearGradient(
              begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xff65DED5), Color(0xff75FADB)]), borderColor: Colors.transparent)
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: ()=> changeChosen("active2"),
          child: active2
              ? FloatingButton(title: "Проднять объявление", cost: "399₴", icon: "lib/assets/images/icon_arrow.png", gradient: LinearGradient(
                begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xff65DED5), Color(0xff75FADB)]), borderColor: Color(0xff27AEA4))
              : FloatingButton(title: "Проднять объявление", cost: "399₴", icon: "lib/assets/images/icon_arrow.png", gradient: LinearGradient(
              begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xff65DED5), Color(0xff75FADB)]), borderColor: Colors.transparent),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: ()=> changeChosen("active3"),
          child: active3
              ? FloatingButton(title: "Турбо", cost: "599₴", icon: "lib/assets/images/icon_fire.png", gradient: LinearGradient(
                begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xffFF9137), Color(0xffFF231F)]), borderColor: Color(0xff27AEA4))
              :FloatingButton(title: "Турбо", cost: "599₴", icon: "lib/assets/images/icon_fire.png", gradient: LinearGradient(
              begin: Alignment.centerLeft, end: Alignment.centerRight, colors: [Color(0xffFF9137), Color(0xffFF231F)]), borderColor: Colors.transparent),
        ),],
    );
  }
}
