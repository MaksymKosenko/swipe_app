import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/CustomAppBars.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'package:swipe_app/screens/Feed/LandingScreen.dart';
import 'package:swipe_app/screens/myAD/Adress.dart';
import 'package:swipe_app/screens/myAD/ChooseZHK.dart';

class MyNewAD extends StatefulWidget {
  @override
  _MyNewADState createState() => _MyNewADState();
}

class _MyNewADState extends State<MyNewAD> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(title: "Новое объявление", height: 104, backScreen: MaterialPageRoute(builder: (context) => LandingPage()),),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(height: 32),
            Adress(),
            SizedBox(height: 13),
            ZhK(),
          ],
        ),
      ),
    );
  }
}
