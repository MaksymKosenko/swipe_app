import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/AdDataKeeper.dart';
import 'package:swipe_app/basicThings/CustomAppBars.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'package:swipe_app/screens/Feed/StandartADCard.dart';
import 'package:swipe_app/screens/myAD/confirmation/FloatingButton.dart';
import 'package:swipe_app/screens/myAD/myAD.dart';

class ConfirmAD extends StatefulWidget {
  final ConcreteAd _concreteAd;
  ConfirmAD(this._concreteAd);
  @override
  _ConfirmADState createState() => _ConfirmADState();
}


class _ConfirmADState extends State<ConfirmAD> {
  bool activeOption1 = false;
  bool activeOption2 = false;
  bool option2sub1 = false;
  bool option2sub2 = false;
  changeView(String option){
    setState(() {
      switch(option){
        case "activeOption1" : activeOption1 = !activeOption1; break;
        case "activeOption2" : activeOption2 = !activeOption2; option2sub1 = false; option2sub2 = false; break;
        case "option2sub1" : option2sub1 = true; option2sub2 = false; break;
        case "option2sub2" : option2sub2 = true; option2sub1 = false; break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyCustomAppBar(title: "Продвижение", height: 82, backScreen: MaterialPageRoute(builder: (context) => MyNewAD())),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SAdCard(widget._concreteAd),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: ()=> changeView("activeOption1"),
                          child: Row(
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                  color: activeOption1
                                      ? Color(0xff41BFB5)
                                      : Color(0xffE8E8E8),
                                  borderRadius: BorderRadius.circular(7.5),
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Добавить фразу", style: MediumText(14, Color(0xff374252)),),
                                  SizedBox(height: 5),
                                  Text("199₴/мес", style: MediumText(14, Color(0xff8F969F)),),
                                ],
                              ),
                            ],
                          )),
                      GestureDetector(
                          onTap: ()=> changeView("activeOption2"),
                          child: Row(
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                decoration: BoxDecoration(
                                  color: activeOption2
                                      ? Color(0xff41BFB5)
                                      : Color(0xffE8E8E8),
                                  borderRadius: BorderRadius.circular(7.5),
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Выделить цветом", style: MediumText(14, Color(0xff374252)),),
                                  SizedBox(height: 5),
                                  Text("199₴/мес", style: MediumText(14, Color(0xff8F969F)),),
                                ],
                              ),
                            ],
                          )),
                      SizedBox(height: 20),
                      Container(
                        child:  activeOption2 ? Row(
                          children: [
                            IconButton(icon: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                  color: Color(0xffFDD7D7),
                                border: Border.all(color: option2sub1? Color(0xff27AEA4):Color(0xffCFCFCF)),
                              ),
                            ), 
                                onPressed:()=> changeView("option2sub1")),
                            IconButton(icon: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xffCEF2D2),
                                border: Border.all(color: option2sub2? Color(0xff27AEA4):Color(0xffCFCFCF)),
                              ),
                            ),
                                onPressed:()=> changeView("option2sub2")),
                          ],
                        ): null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 45),
            FloatingButton(title: "Большое объявление", cost: "339₴",
              icon: "lib/assets/images/icon_arrows.png",
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xff65DED5), Color(0xff75FADB)]
              ),),
          SizedBox(height: 10),
            FloatingButton(title: "Проднять объявление", cost: "339₴",
              icon: "lib/assets/images/icon_arrow.png",
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xff65DED5), Color(0xff75FADB)]
              ),),
            SizedBox(height: 10),
            FloatingButton(title: "Турбо", cost: "339₴",
              icon: "lib/assets/images/icon_fire.png",
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xffFF9137), Color(0xffFF231F)]
              ),),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: CustomButton(280, 60, 35, Color(0xff56C385), Color(0xff41BFB5), Alignment.topCenter, Alignment.bottomCenter, "Оплатить x₴",
                  SemiBoldText(16, Colors.white), Colors.transparent),
            ),
            SizedBox(height: 16),
            Text("Разместить без оплаты", style: MediumText(14, Color(0xff636363)), textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
