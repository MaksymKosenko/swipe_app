import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/default_app_bar.dart';
import 'package:swipe_app/global/custom_widgets/custom_button.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/global/user.dart';
import 'package:swipe_app/screens/Feed/landing_page.dart';
import 'package:swipe_app/screens/Feed/standart_ad_card.dart';
import 'package:swipe_app/screens/my_add/confirmation/ad_model.dart';
import 'package:swipe_app/screens/my_add/confirmation/decoration_text_variant.dart';
import 'package:swipe_app/screens/my_add/confirmation/iconsBlock.dart';
import 'package:swipe_app/screens/my_add/whole_ad_container.dart';

class ConfirmAD extends StatefulWidget {
  final ConcreteAd _concreteAd;

  ConfirmAD(this._concreteAd);

  @override
  _ConfirmADState createState() => _ConfirmADState();
}

class _ConfirmADState extends State<ConfirmAD> {
  //bool activeOption1 = false;
  bool activeOption2 = false;
  bool option2sub1 = false;
  bool option2sub2 = false;

  bool icon1 = false;
  bool icon2 = false;
  bool icon3 = false;

  void setIcon(){
    widget._concreteAd.icon1 = icon1;
    widget._concreteAd.icon2 = icon2;
    widget._concreteAd.icon3 = icon3;
  }
  int cashToPay = 0;
  changeView(String option) {
    setState(() {
      switch (option) {
        case "activeOption1": SAdCard(widget._concreteAd).createState(); break;
        case "activeOption2":
          activeOption2 = !activeOption2;
          option2sub1 = false;
          option2sub2 = false;
          widget._concreteAd.setTextColor("null");
          if(activeOption2 == true)
            changeView("option2sub1");
          SAdCard(widget._concreteAd).createState();
          break;
        case "option2sub1":
          option2sub1 = true;
          option2sub2 = false;
          widget._concreteAd.setTextColor("option2sub1");
          SAdCard(widget._concreteAd).createState();
          break;
        case "option2sub2":
          option2sub2 = true;
          option2sub1 = false;
          widget._concreteAd.setTextColor("option2sub2");
          SAdCard(widget._concreteAd).createState();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    cashToPay = 0;
    if(widget._concreteAd.chosenPhrase != "null")
      cashToPay = cashToPay + 199;
    if(widget._concreteAd.textColor1 == true || widget._concreteAd.textColor2 == true || activeOption2 == true){
      cashToPay = cashToPay + 199;
    }

    if(icon1 == true)
      cashToPay = cashToPay + 399;
    if(icon2 == true)
      cashToPay = cashToPay + 399;
    if(icon3 == true)
      cashToPay = cashToPay + 599;

    setIcon();

    var hours = TimeOfDay.now().hour +2;
    var min = TimeOfDay.now().minute;
    String day = "";
    String month = "";
    if(DateTime.now().day < 10){
      day = day + "0${DateTime.now().day}";
    }else
      day = day + "${DateTime.now().day}";

    if(DateTime.now().month < 10){
      month = month + " 0${DateTime.now().month}";
    }else
      month = month + " ${DateTime.now().month}";
    //day = day + " ${DateTime.now().year}";

    return Scaffold(
      appBar: MyCustomAppBar("Продвижение", 82, MaterialPageRoute(builder: (context) => MyNewAD())),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //SizedBox(height: 30),
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
                        onTap: () => changeView("activeOption1"),
                          child: AddPhrase(widget._concreteAd, this)),
                      GestureDetector(
                          onTap: () => {changeView("activeOption2"),}, //changeView("option2sub1"), setState((){})},
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
                                  Text(
                                    "Выделить цветом",
                                    style: MediumText(14, Color(0xff374252)),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "199₴/мес",
                                    style: MediumText(14, Color(0xff8F969F)),
                                  ),
                                ],
                              ),
                            ],
                          )),
                      SizedBox(height: 20),
                      Container(
                        child: activeOption2
                            ? Row(
                                children: [
                                  IconButton(
                                      icon: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8), color: Color(0xffFDD7D7),
                                          border: Border.all(color: option2sub1 ? Color(0xff27AEA4) : Color(0xffCFCFCF)),
                                        ),
                                      ),
                                      onPressed: () {changeView("option2sub1");}),
                                  IconButton(
                                      icon: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8), color: Color(0xffCEF2D2),
                                          border: Border.all(color: option2sub2 ? Color(0xff27AEA4) : Color(0xffCFCFCF)),
                                        ),
                                      ),
                                      onPressed: () => changeView("option2sub2")),
                                ],) : null,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            //SizedBox(height: 40),
            IconsVariant(this),
            //SizedBox(height: 40),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: GestureDetector(
                      onTap: ()=> {
                        widget._concreteAd.setHoursMinsDay(hours, min, day, month, Timestamp.now()),
                        widget._concreteAd.addMyAD(user.phone),
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LandingPage())),
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=> LandingPage())),
                      },
                      child: CustomButton(280, 60, 35,
                          Color(0xff56C385), Color(0xff41BFB5),
                          Alignment.topCenter, Alignment.bottomCenter,
                          "Оплатить $cashToPay₴", SemiBoldText(16, Colors.white), Colors.transparent),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    onPressed: (){
                      widget._concreteAd.addMyAD(user.phone);
                      widget._concreteAd.setHoursMinsDay(hours, min, day, month,Timestamp.now());
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LandingPage()));},
                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> LandingPage()));},
                    child: Text("Разместить без оплаты",
                        style: MediumText(14, Color(0xff636363)),
                        textAlign: TextAlign.center),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
