import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/default_app_bar.dart';
import 'package:swipe_app/global/custom_widgets/custom_button.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/global/user.dart';
import 'package:swipe_app/models/add_model.dart';
import 'package:swipe_app/screens/Feed/landing_page.dart';
import 'package:swipe_app/screens/my_add/ad_address.dart';
import 'package:swipe_app/screens/my_add/ad_agent_payment.dart';
import 'package:swipe_app/screens/my_add/ad_apartments_type.dart';
import 'package:swipe_app/screens/my_add/ad_balcony.dart';
import 'package:swipe_app/screens/my_add/ad_connection_type.dart';
import 'package:swipe_app/screens/my_add/ad_description.dart';
import 'package:swipe_app/screens/my_add/ad_heating.dart';
import 'package:swipe_app/screens/my_add/ad_kitchen_area.dart';
import 'package:swipe_app/screens/my_add/ad_object_living_state.dart';
import 'package:swipe_app/screens/my_add/ad_object_overall_area.dart';
import 'package:swipe_app/screens/my_add/ad_object_plan.dart';
import 'package:swipe_app/screens/my_add/ad_payment_type.dart';
import 'package:swipe_app/screens/my_add/ad_photos.dart';
import 'package:swipe_app/screens/my_add/ad_price.dart';
import 'package:swipe_app/screens/my_add/ad_rooms_quantity.dart';
import 'package:swipe_app/screens/my_add/ad_zhk.dart';
import 'package:swipe_app/screens/my_add/confirmation/confirm_ad.dart';
class MyNewAD extends StatefulWidget {
  final Add _add;
  MyNewAD([this._add]);
  @override
  MyNewADState createState() => MyNewADState();
}

class MyNewADState extends State<MyNewAD> {
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
    if(widget._add == null)
      _add = Add();
    else
      _add = widget._add;

    void checkFields(){
      String error = "";
      if(_add.address == null)
        error = error + "Адресс не указан. ";
      if(_add.photoFiles == null)
        error = error + "Добавьте минимум одно фото. ";
      //print("noPhoto");
      if(_add.overallArea == null)
        error =  error + "Поле общей площади не может быть пустое. ";
      if(_add.kitchenArea == null)
        error =  error + "Поле площади кухни не может быть пустое. ";
      if(_add.description == null)
        error =  error + "Поле описания должно быть заполненным. ";
      if(_add.cost == null)
        error =  error + "Стоимость должна быть указанна. ";

      if(error == "")
        Navigator.push(context, MaterialPageRoute(builder: (context)=> ConfirmAD(_add)));
      else showError(error, context);
    }

    final ConcreteUser user = Provider.of<ConcreteUser>(context);
    return Scaffold(
      appBar: MyCustomAppBar("Новое объявление", 82,/*104,*/ MaterialPageRoute(builder: (context) => LandingPage()),),
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
                  Alignment.centerLeft, Alignment.centerRight, "Продолжить", SemiBoldText(14, Colors.white), Colors.transparent),
                )),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
