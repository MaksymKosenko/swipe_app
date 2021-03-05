import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/screens/myAD/confirmation/AdDataKeeper.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'package:swipe_app/screens/myAD/inputField.dart';

class Description extends StatefulWidget {
  final ConcreteAd _concreteAd;
  Description(this._concreteAd);
  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  TextEditingController _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Описание", style: SemiBoldText(14, Color(0xff2E2E2E))),
          SizedBox(height: 10),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
            decoration: BoxDecoration(
                color: Color(0x20DADADA),
                borderRadius: BorderRadius.circular(10)
            ),
            //child: Text("current adress",style: RegularText(14, Color(0xff737373)),),
            child: InputField(widget._concreteAd, "setDescription", _inputController, "Описание вашей недвижимости",10),
          ),
        ],
      ),
    );
  }
}
