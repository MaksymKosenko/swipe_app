import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/default_app_bar.dart';
import 'package:swipe_app/global/custom_widgets/custom_button.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/add_model.dart';
import 'package:swipe_app/models/repository/api_add.dart';
import 'package:swipe_app/screens/add_cards/owner_full_ad_card.dart';
import 'package:swipe_app/screens/add_cards/standart_ad_card.dart';
import 'package:swipe_app/screens/feed/landing_page.dart';
import 'package:swipe_app/screens/my_add/confirmation/decoration_text_variant.dart';
import 'package:swipe_app/screens/my_add/confirmation/icons_block.dart';



class PromoteAd extends StatefulWidget {

  final ApiAdd _add;
  final String _id;
  PromoteAd(this._add, this._id);
  @override
  _PromoteAdState createState() => _PromoteAdState();
}

class _PromoteAdState extends State<PromoteAd> {
  Add _add = Add();

  bool activeOption2 = false;
  bool option2sub1 = false;
  bool option2sub2 = false;

  bool icon1 = false;
  bool icon2 = false;
  bool icon3 = false;


  int cashToPay = 0;
  changeView(String option) {
    setState(() {
      switch (option) {
        case "activeOption1": SAdCard.fromApi(widget._add).createState(); break;
        case "activeOption2":
          activeOption2 = !activeOption2;
          option2sub1 = false;
          option2sub2 = false;
          _add.textColorGreen = false;
          _add.textColorRose = false;
          if(activeOption2 == true)
            changeView("option2sub1");
          SAdCard.fromApi(widget._add).createState();
          break;
        case "option2sub1":
          option2sub1 = true;
          option2sub2 = false;
          _add.textColorGreen = false;
          _add.textColorRose = true;
          SAdCard.fromApi(widget._add).createState();
          break;
        case "option2sub2":
          option2sub2 = true;
          option2sub1 = false;
          _add.textColorRose = false;
          _add.textColorGreen = true;
          SAdCard.fromApi(widget._add).createState();
          break;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    DocumentReference _ad = FirebaseFirestore.instance.collection('ads').doc(widget._id);
    Future<void> updateAD(){
      return _ad
          .update({
        'chosenPhrase': widget._add.chosenPhrase,

        'textColorRose': option2sub1,
        'textColorGreen': option2sub2,

        'icon1': icon1,
        'icon2': icon2,
        'icon3': icon3,

        'dateTime': widget._add.dateTime,
      })
          .then((value) {print("ads updated");})
          .catchError((error) => print("Failed to add asd: $error"));
    }

    if (_add == null){
      _add.dateTime = Timestamp.now();
      _add.address = widget._add.address;
      _add.chosenZhK = widget._add.chosenZhK;
      _add.apartmentsType = widget._add.apartmentsType;
      _add.roomsQuantity = widget._add.roomsQuantity;
      _add.housePlan = widget._add.housePlan;
      _add.houseState = widget._add.houseState;
      _add.overallArea = widget._add.overallArea;
      _add.kitchenArea = widget._add.kitchenArea;
      _add.balconyState = widget._add.balconyState;
      _add.heatingType = widget._add.heatingType;
      _add.paymentType = widget._add.paymentType;
      _add.connectionType = widget._add.connectionType;
      _add.description = widget._add.description;
      _add.cost = widget._add.cost;
      _add.agentPayment = widget._add.agentPayment;
      _add.photos = widget._add.photos;

      _add.chosenPhrase = widget._add.chosenPhrase;

      _add.textColorRose = widget._add.textColorRose;
      _add.textColorGreen = widget._add.textColorGreen;

      _add.bigAd = widget._add.bigAd;
      _add.promotedAd = widget._add.promotedAd;
      _add.promotedBig = widget._add.promotedBig;

      _add.dateTime = widget._add.dateTime;
      setState(() {

      });
    }

  _add.textColorRose = option2sub1;
  _add.textColorGreen = option2sub2;


    cashToPay = 0;
    if(_add.chosenPhrase != null)
      cashToPay = cashToPay + 199;
    if(_add.textColorGreen  == true || _add.textColorRose == true || activeOption2 == true){
      cashToPay = cashToPay + 199;
    }

    if(icon1 == true)
      cashToPay = cashToPay + 399;
    if(icon2 == true)
      cashToPay = cashToPay + 399;
    if(icon3 == true)
      cashToPay = cashToPay + 599;

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
      appBar: MyCustomAppBar("Продвижение", 82, MaterialPageRoute(builder: (context) => OwnerFullAdCard(widget._add, widget._id))),
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
                SAdCard.fromApi(widget._add),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () => changeView("activeOption1"),
                          child: AddPhrase(_add, this)),
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
                        _add.dateTime = Timestamp.now(),
                        //widget._add.cost = cashToPay.toString(),
                        if(_add.promotedAd == true && _add.bigAd == true){
                          _add.promotedAd =false,
                          _add.bigAd = false,
                          _add.promotedBig = true,
                        },
                        if( _add.promotedBig == true){
                          _add.promotedAd = false,
                          _add.bigAd = false,
                        },
                        updateAD(),
                        Navigator.pushReplacement(context, MaterialPageRoute(builder:
                            (context)=> LandingPage())),
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
                      _add.dateTime = Timestamp.now();
                      _add.textColorGreen = false;
                      _add.textColorRose = false;
                      _add.chosenPhrase = null;
                      _add.bigAd = false;
                      _add.promotedAd = false;
                      _add.promotedBig = false;
                      //widget._add.cost = cashToPay.toString();
                      updateAD();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder:
                          (context)=> LandingPage()));},

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
