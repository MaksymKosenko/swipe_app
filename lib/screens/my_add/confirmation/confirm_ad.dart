import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/default_app_bar.dart';
import 'package:swipe_app/global/custom_widgets/custom_button.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/global/user.dart';
import 'package:swipe_app/models/add_model.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:swipe_app/models/repository/api_add.dart';
import 'package:swipe_app/screens/add_cards/own_add.dart';
import 'package:swipe_app/screens/add_cards/standart_ad_card.dart';
import 'package:swipe_app/screens/feed/landing_page.dart';
import 'package:swipe_app/screens/my_add/confirmation/decoration_text_variant.dart';
import 'package:swipe_app/screens/my_add/confirmation/icons_block.dart';
import 'package:swipe_app/screens/my_add/whole_ad_container.dart';

class ConfirmAD extends StatefulWidget {

  final Add _add;

  ConfirmAD(this._add);

  @override
  _ConfirmADState createState() => _ConfirmADState();
}

class _ConfirmADState extends State<ConfirmAD> {

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
        case "activeOption1": SAdCard(widget._add).createState(); break;
        case "activeOption2":
          activeOption2 = !activeOption2;
          option2sub1 = false;
          option2sub2 = false;
          widget._add.textColorGreen = false;
          widget._add.textColorRose = false;
          if(activeOption2 == true)
            changeView("option2sub1");
          SAdCard(widget._add).createState();
          break;
        case "option2sub1":
          option2sub1 = true;
          option2sub2 = false;
          widget._add.textColorGreen = false;
          widget._add.textColorRose = true;
          SAdCard(widget._add).createState();
          break;
        case "option2sub2":
          option2sub2 = true;
          option2sub1 = false;
          widget._add.textColorRose = false;
          widget._add.textColorGreen = true;
          SAdCard(widget._add).createState();
          break;
      }
    });
  }

  String _addId;
  String _userId;
  @override
  Widget build(BuildContext context) {
   widget._add.textColorRose = option2sub1;
   widget._add.textColorGreen = option2sub2;

    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    if(user != null)
      _userId = user.phone;
    cashToPay = 0;
    if(widget._add.chosenPhrase != null)
      cashToPay = cashToPay + 199;
    if(widget._add.textColorGreen  == true || widget._add.textColorRose == true || activeOption2 == true){
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
      appBar: MyCustomAppBar("Продвижение", 82, MaterialPageRoute(builder: (context) => MyNewAD(widget._add))),
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
                SAdCard(widget._add),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => changeView("activeOption1"),
                          child: AddPhrase(widget._add, this)),
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
                        widget._add.dateTime = Timestamp.now(),
                        //widget._add.cost = cashToPay.toString(),
                        if(widget._add.promotedAd == true && widget._add.bigAd == true){
                          widget._add.promotedAd =false,
                          widget._add.bigAd = false,
                          widget._add.promotedBig = true,
                        },
                        if( widget._add.promotedBig == true){
                          widget._add.promotedAd = false,
                          widget._add.bigAd = false,
                        },
                        addMyAD(user.phone),
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
                      widget._add.dateTime = Timestamp.now();
                      widget._add.textColorGreen = false;
                      widget._add.textColorRose = false;
                      widget._add.chosenPhrase = null;
                      widget._add.bigAd = false;
                      widget._add.promotedAd = false;
                      widget._add.promotedBig = false;
                      //widget._add.cost = cashToPay.toString();
                      addMyAD(user.phone);
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

  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  CollectionReference _ads = FirebaseFirestore.instance.collection('ads');
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  List<String> photos = List<String>.empty(growable: true);

  Future<void> addAdPhoto(String phone, String id) async{
       try{
         movePhotos(phone, id,0);
         movePhotos(phone, id,1);
         movePhotos(phone, id,2);
         movePhotos(phone, id,3);
         movePhotos(phone, id,4);
         movePhotos(phone, id,5);
      }catch (e) {
        print("error code - $e");
      }
      print("photos - $photos");
      //updPhoto(id);
  }

  Future<void> movePhotos(String phone, String id, int index) async{
    try{
      var data = await firebase_storage
          .FirebaseStorage.instance
          .ref('$phone/ads/houseImage/tmp/photo$index')//ads/houseImage/$id.jpg')
          .getData();

      await firebase_storage
          .FirebaseStorage.instance
          .ref('$phone/ads/houseImage/$id/photo$index')//ads/houseImage/$id.jpg')
          .putData(data);

      await firebase_storage
          .FirebaseStorage.instance
          .ref('$phone/ads/houseImage/tmp/photo$index')
          .delete();

      String downloadUrl = await firebase_storage
          .FirebaseStorage.instance
          .ref('$phone/ads/houseImage/$id/photo$index')//ads/houseImage/$id.jpg')
          .getDownloadURL();

      if(downloadUrl != null){
        photos.add(downloadUrl);
        print("index - $index, link - $downloadUrl");
        updPhoto(id);
      }
    }catch(e){
      print(e);
      if(photos[index] != null)
      movePhotos(phone, id, index);
    }
  }


  Future<void> updPhoto(String id){
    return _ads.doc(id).update({
      'photos': photos
    }).then((value) {print("photo updated");})
        .catchError((error) =>  updPhoto(id));
  }



  Future<void> addMyAD(String phone){
    return _ads
        .add({
      'address': widget._add.address,
      'chosenZhK': widget._add.chosenZhK,
      'apartmentsType': widget._add.apartmentsType,
      'roomsQuantity': widget._add.roomsQuantity,
      'housePlan': widget._add.housePlan,
      'houseState': widget._add.houseState,
      'overallArea': widget._add.overallArea,
      'kitchenArea': widget._add.kitchenArea,
      'balconyState': widget._add.balconyState,
      'heatingType': widget._add.heatingType,
      'paymentType': widget._add.paymentType,
      'connectionType': widget._add.connectionType,
      'description': widget._add.description,
      'cost': widget._add.cost,
      'agentPayment': widget._add.agentPayment,
      'photos': widget._add.photos,

      'chosenPhrase': widget._add.chosenPhrase,

      'textColorRose': widget._add.textColorRose,
      'textColorGreen': widget._add.textColorGreen,
      'icon1': icon1,
      'icon2': icon2,
      'icon3': icon3,

      'dateTime': widget._add.dateTime,
      'ownerID' : _userId,
      'watches' : 0,
      'saves' : 0,
      'location' : widget._add.location
    })
        .then((value) {print("ads added"); addToMyCollection(value.id, phone);addAdPhoto(phone, value.id); _addId = value.id;})
        .catchError((error) => print("Failed to add asd: $error"));
  }

  Future<void>addToMyCollection(String addID, String phone){
    return _users
        .doc(phone)
        .collection("user_collections")
        .doc("myAd")
        .collection("myAds")
        .doc(addID)
        .set({
      'addID': addID,
    })
        .then((value) => print("toUser add added"))
        .catchError((error) => print("Failed to add Agent: $error"));
  }
}
