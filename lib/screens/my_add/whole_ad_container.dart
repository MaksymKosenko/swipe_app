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
import 'package:swipe_app/screens/my_add/confirmation/ad_model.dart';
import 'package:swipe_app/screens/my_add/confirmation/confirm_ad.dart';
class MyNewAD extends StatefulWidget {
  final Add _add;
  MyNewAD([this._add]);
  @override
  MyNewADState createState() => MyNewADState();
}

class MyNewADState extends State<MyNewAD> {
  Add _add = Add();
  ConcreteAd _concreteAd = ConcreteAd();
  @override
  Widget build(BuildContext context) {
    Add _add;// = Add();
    if(widget._add == null)
      _add = Add();
    else
      _add = widget._add;
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
                  onTap: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> ConfirmAD(_concreteAd))),//Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmAD(_concreteAd))),
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
