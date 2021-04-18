import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/default_app_bar.dart';
import 'package:swipe_app/global/custom_widgets/custom_button.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/global/user.dart';
import 'package:swipe_app/models/add_model.dart';
import 'package:swipe_app/models/repository/api_add.dart';
import 'package:swipe_app/screens/add_cards/owner_full_ad_card.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_address.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_agent_payment.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_apartments_type.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_balcony.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_connection_type.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_description.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_heating.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_kitchen_area.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_object_living_state.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_object_overall_area.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_object_plan.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_payment_type.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_price.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_rooms_quantity.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_zhk.dart';
import 'package:swipe_app/screens/own_ads/edit_add_photos.dart';
import 'package:swipe_app/screens/own_ads/own_ads_list.dart';

class EditAdContainer extends StatefulWidget {
  final ApiAdd _add;
  final String _addID;
  final List _addIds;
  EditAdContainer(this._add, this._addID, this._addIds);
  @override
  EditAdContainerState createState() => EditAdContainerState();
}

class EditAdContainerState extends State<EditAdContainer> {
  Add _add = Add();

  Future <void> showError(String errorText, context) async{
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Ошибка подтвержения'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(errorText),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Ок'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
    );
  }

/*
downloadPhotos(List<dynamic> photoFiles, int index) async{
  if(index >= 1)
  try {
    var image0 = await ImageDownloader.downloadImage(widget._add.photos[0]);
    if (image0 != null) {
      var path = await ImageDownloader.findPath(image0);
      if(path!= null){
         photoFiles[0] = File(path);
        print(File(path));
        print("add.photoFiles - ${_add.photoFiles}");
      }
    }
    // Below is a method of obtaining saved image information.
    // var fileName = await ImageDownloader.findName(imageId);
    // var path = await ImageDownloader.findPath(imageId);
    //var size = await ImageDownloader.findByteSize(imageId);
    //var mimeType = await ImageDownloader.findMimeType(imageId);
  } on PlatformException catch (error) {
    print(error);
  }

  if(index >= 2)
    try {
      var image1 = await ImageDownloader.downloadImage(widget._add.photos[1]);
      if (image1 == null) {
        return;
      }else{
        var path = await ImageDownloader.findPath(image1);
        if(path!= null){
           photoFiles[1] = File(path);
          print(File(path));
        }
      }
    } on PlatformException catch (error) {
      print(error);
    }

  if(index >= 3)
    try {
      var image2 = await ImageDownloader.downloadImage(widget._add.photos[2]);
      if (image2 == null) {
        return;
      }else{
        var path = await ImageDownloader.findPath(image2);
        if(path!= null){
           photoFiles[0] = File(path);
          print(File(path));
        }
      }
    } on PlatformException catch (error) {
      print(error);
    }
  if(index >= 4)
    try {
      var image3 = await ImageDownloader.downloadImage(widget._add.photos[3]);
      if (image3 == null) {
        return;
      }else{
        var path = await ImageDownloader.findPath(image3);
        if(path!= null){
           photoFiles[3] = File(path);
          print(File(path));
        }
      }
    } on PlatformException catch (error) {
      print(error);
    }
  if(index >= 5)
    try {
      var image4 = await ImageDownloader.downloadImage(widget._add.photos[4]);
      if (image4 == null) {
        return;
      }else{
        var path = await ImageDownloader.findPath(image4);
        if(path!= null){
           photoFiles[4] = File(path);
          print(File(path));
        }
      }
    } on PlatformException catch (error) {
      print(error);
    }
  if(index >= 6)
    try {
      var image5 = await ImageDownloader.downloadImage(widget._add.photos[5]);
      if (image5 == null) {
        return;
      }else{
        var path = await ImageDownloader.findPath(image5);
        if(path!= null){
           photoFiles[5] = File(path);
          print(File(path));
        }
      }
    } on PlatformException catch (error) {
      print(error);
    }
}*/
  @override
  Widget build(BuildContext context) {
    Add _add;// = Add();

    DocumentReference _ad = FirebaseFirestore.instance.collection('ads').doc(widget._addID);
    Future<void> updateAD() async{
      return _ad
          .update({
        'address': _add.address,
        'chosenZhK': _add.chosenZhK,
        'apartmentsType': _add.apartmentsType,
        'roomsQuantity': _add.roomsQuantity,
        'housePlan': _add.housePlan,
        'houseState': _add.houseState,
        'overallArea': _add.overallArea,
        'kitchenArea': _add.kitchenArea,
        'balconyState': _add.balconyState,
        'heatingType': _add.heatingType,
        'paymentType': _add.paymentType,
        'connectionType': _add.connectionType,
        'description': _add.description,
        'cost': _add.cost,
        'agentPayment': _add.agentPayment,
        'photos': widget._add.photos,

        'dateTime': _add.dateTime,

        'location' : _add.location})
          .then((value) {print("ads updated"); /*widget._state.setState((){}); */})
          .catchError((error) => print("Failed to add asd: $error id = ${widget._addID}"));
    }

    Future<void> downloadPhoto(String phone, String addId, int index) async{
      Directory appDocDir = await getApplicationDocumentsDirectory(); //getApplicationDocumentsDirectory();
      //File('${appDocDir.path}/${widget._addID}/download-photo$index.png').delete();
      File tmp = File('${appDocDir.path}/${widget._addID}/download-photo$index.png');
      //tmp.delete();
      //print("error- $phone/ads/houseImage/$addId/photo$index");
      try{
        await firebase_storage.FirebaseStorage.instance
        //.refFromURL(widget._apiAdd.photos[index])
            .ref('$phone/ads/houseImage/$addId/')
            .child('photo$index')
            .writeToFile(tmp).whenComplete(() {_add.photoFiles[index]=tmp; print("tmp - $tmp");});
      }catch (e) {
        print("error c0de - $e $phone/ads/houseImage/$addId/photo$index");
        // e.g, e.code == 'canceled'
      }}

     if (_add == null){
        _add = Add();
        _add.photoFiles = [null, null,null, null,null, null];
       // downloadPhotos(_add.photoFiles, widget._add.photos.length);

        for(int i = 0; i < widget._add.photos.length; i++){
          print("length - ${widget._add.photos.length}");
          print("index - $i");
          downloadPhoto(widget._add.ownerID, widget._addID, i);
        }
      //_add.dateTime = Timestamp.now();
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


    void checkFields(){
      String error = "";
      if(_add.address == null)
        error = error + "Адресс не указан. ";
     // if(_add.photoFiles == null)
      //  error = error + "Добавьте минимум одно фото. ";
      //print("noPhoto");
      if(_add.overallArea == null)
        error =  error + "Поле общей площади не может быть пустое. ";
      if(_add.kitchenArea == null)
        error =  error + "Поле площади кухни не может быть пустое. ";
      if(_add.description == null)
        error =  error + "Поле описания должно быть заполненным. ";
      if(_add.cost == null)
        error =  error + "Стоимость должна быть указанна. ";

      if(error == ""){
        updateAD();
        Navigator.push(context, MaterialPageRoute(builder: (context)=> OwnAdsScreen(widget._add.ownerID)));
      }
      else showError(error, context);
    }

    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    return Scaffold(
      appBar: MyCustomAppBar("Редактирование", 82,/*104,*/ MaterialPageRoute(builder: (context) => OwnerFullAdCard(widget._add, widget._addID, widget._addIds)),),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(height: 32),
            Address(this, _add),
            SizedBox(height: 13),
            ZhK(this, _add),
            SizedBox(height: 13),
            ApartmentType(_add),
            SizedBox(height: 13),
            RoomQuantity(_add),
            SizedBox(height: 13),
            HousePlan(_add),
            SizedBox(height: 13),
            OurDaysState(_add),
            SizedBox(height: 13),
            OverallArea(_add),
            SizedBox(height: 13),
            KitchenArea(_add),
            SizedBox(height: 13),
            BalconyState(_add),
            SizedBox(height: 13),
            HeatingState(_add),
            SizedBox(height: 13),
            PaymentType(_add),
            SizedBox(height: 13),
            ConnectionType(_add),
            SizedBox(height: 13),
            Description(_add),
            SizedBox(height: 13),
            Cost(_add),
            SizedBox(height: 13),
            AgentPayment(_add),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 54),
              child: Text("Главное фото", style: RegularText(12, Color(0xff737373))),
            ),
            SizedBox(height: 7),
           // EditAdPhotos(user, _add, widget._add, widget._addID),//TODO - закончить редактирование фото
            SizedBox(height: 40),
            Container(padding: EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: (){
                    print(_add.photoFiles);
                    checkFields();
                  },//=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ConfirmAD(_concreteAd, _add))),//Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmAD(_concreteAd))),
                  child: CustomButton(double.maxFinite, 45, 10, Color(0xff56C486), Color(0xff42C0B5),
                      Alignment.centerLeft, Alignment.centerRight, "Сохранить", SemiBoldText(14, Colors.white), Colors.transparent),
                )),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
