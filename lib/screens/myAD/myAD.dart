import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/CustomAppBars.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'package:swipe_app/screens/Feed/LandingScreen.dart';
import 'package:swipe_app/screens/myAD/ADPhotos.dart';
import 'package:swipe_app/screens/myAD/Adress.dart';
import 'package:swipe_app/screens/myAD/AgentPayment.dart';
import 'package:swipe_app/screens/myAD/ApartamentsType.dart';
import 'package:swipe_app/screens/myAD/BalconyState.dart';
import 'package:swipe_app/screens/myAD/ChooseZHK.dart';
import 'package:swipe_app/screens/myAD/ConnectionType.dart';
import 'package:swipe_app/screens/myAD/Cost.dart';
import 'package:swipe_app/screens/myAD/Description.dart';
import 'package:swipe_app/screens/myAD/HeatingState.dart';
import 'package:swipe_app/screens/myAD/HousePlan.dart';
import 'package:swipe_app/screens/myAD/KitchenArea.dart';
import 'package:swipe_app/screens/myAD/OurDaysState.dart';
import 'package:swipe_app/screens/myAD/OverallArea.dart';
import 'package:swipe_app/screens/myAD/PaymentType.dart';
import 'package:swipe_app/screens/myAD/roomQuantity.dart';

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
            SizedBox(height: 13),
            ApartmentType(),
            SizedBox(height: 13),
            RoomQuantity(),
            SizedBox(height: 13),
            HousePlan(),
            SizedBox(height: 13),
            OurDaysState(),
            SizedBox(height: 13),
            OverallArea(),
            SizedBox(height: 13),
            KitchenArea(),
            SizedBox(height: 13),
            BalconyState(),
            SizedBox(height: 13),
            HeatingState(),
            SizedBox(height: 13),
            PaymentType(),
            SizedBox(height: 13),
            ConnectionType(),
            SizedBox(height: 13),
            Description(),//TODO поменять бокс описания
            SizedBox(height: 13),
            Cost(),
            SizedBox(height: 13),
            AgentPayment(),
            SizedBox(height: 13),
            ADPhotos(),
            SizedBox(height: 40),
            Container(padding: EdgeInsets.symmetric(horizontal: 10),
                child: CustomButton(double.maxFinite, 45, 10, Color(0xff56C486), Color(0xff42C0B5),
                Alignment.centerLeft, Alignment.centerRight, "Продолжить", SemiBoldText(14, Colors.white), Colors.transparent)),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
