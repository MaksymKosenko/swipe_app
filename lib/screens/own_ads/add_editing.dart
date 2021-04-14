import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
import 'package:swipe_app/screens/my_add/build_add/ad_photos.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_price.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_rooms_quantity.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_zhk.dart';

class EditAdContainer extends StatefulWidget {
  final ApiAdd _add;
  final String _addID;
  final dynamic _state;
  EditAdContainer([this._add, this._addID, this._state]);
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
        //'photos': widget._add.photos,

        'dateTime': _add.dateTime,

        'location' : _add.location})
          .then((value) {print("ads updated"); widget._state.setState((){});})
          .catchError((error) => print("Failed to add asd: $error id = ${widget._addID}"));
    }
      //'location' = _add.location;
      //'address' = _add.address;
     // 'chosenZhK' = _add.chosenZhK;
   /*   String apartmentsType;
      String roomsQuantity;
      String housePlan;
      String houseState;
      String overallArea;
      String kitchenArea;
      String balconyState;
      String heatingType;
      String paymentType;
      String connectionType;
      String description;
      String cost;
      String agentPayment;
      List<dynamic> photos = List<dynamic>.empty(growable: true);
      List<File> photoFiles = [null, null, null, null, null, null];


      String chosenPhrase;

      bool textColorRose = false;
      bool textColorGreen = false;

      bool bigAd;
      bool promotedAd;
      bool promotedBig;

      Timestamp dateTime;*/


     if (_add == null){
        _add = Add();
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=> OwnerFullAdCard(widget._add, widget._add.id)));
      }
      else showError(error, context);
    }

    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    return Scaffold(
      appBar: MyCustomAppBar("Редактирование", 82,/*104,*/ MaterialPageRoute(builder: (context) => OwnerFullAdCard(widget._add, widget._add.id)),),
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
            ADPhotos(user, _add),
            SizedBox(height: 40),
            Container(padding: EdgeInsets.symmetric(horizontal: 10),
                child: GestureDetector(
                  onTap: (){
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
