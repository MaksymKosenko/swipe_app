import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/screens/myAD/confirmation/AdDataKeeper.dart';
import 'package:swipe_app/basicThings/CustomAppBars.dart';
import 'package:swipe_app/basicThings/User.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'package:swipe_app/screens/Feed/LandingScreen.dart';
import 'package:swipe_app/screens/myAD/ADPhotos.dart';
import 'package:swipe_app/screens/myAD/Adress.dart';
import 'package:swipe_app/screens/myAD/AgentPayment.dart';
import 'package:swipe_app/screens/myAD/ApartamentsType.dart';
import 'package:swipe_app/screens/myAD/BalconyState.dart';
import 'package:swipe_app/screens/myAD/ChooseZHK.dart';
import 'package:swipe_app/screens/myAD/confirmation/ConfirmingAD.dart';
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
  ConcreteAd _concreteAd = ConcreteAd();
  @override
  Widget build(BuildContext context) {
    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    return Scaffold(
      appBar: MyCustomAppBar(title: "Новое объявление", height:82,/*104,*/ backScreen: MaterialPageRoute(builder: (context) => LandingPage()),),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
           SizedBox(height: 32),
            Adress(_concreteAd),
            SizedBox(height: 13),
            ZhK(_concreteAd),
            SizedBox(height: 13),
            ApartmentType(_concreteAd),
            SizedBox(height: 13),
            RoomQuantity(_concreteAd),
            SizedBox(height: 13),
            HousePlan(_concreteAd),
            SizedBox(height: 13),
            OurDaysState(_concreteAd),
            SizedBox(height: 13),
            OverallArea(_concreteAd),
            SizedBox(height: 13),
            KitchenArea(_concreteAd),
            SizedBox(height: 13),
            BalconyState(_concreteAd),
            SizedBox(height: 13),
            HeatingState(_concreteAd),
            SizedBox(height: 13),
            PaymentType(_concreteAd),
            SizedBox(height: 13),
            ConnectionType(_concreteAd),
            SizedBox(height: 13),
            Description(_concreteAd),
            SizedBox(height: 13),
            Cost(_concreteAd),
            SizedBox(height: 13),
            AgentPayment(_concreteAd),
            SizedBox(height: 13),
            ADPhotos(user, _concreteAd),
            SizedBox(height: 40),
            Container(padding: EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmAD(_concreteAd))),
                  child: CustomButton(double.maxFinite, 45, 10, Color(0xff56C486), Color(0xff42C0B5),
                  Alignment.centerLeft, Alignment.centerRight, "Продолжить", SemiBoldText(14, Colors.white), Colors.transparent),
                )),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
