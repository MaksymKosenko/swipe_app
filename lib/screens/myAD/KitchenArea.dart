import 'package:flutter/material.dart';
import 'package:swipe_app/screens/myAD/confirmation/AdDataKeeper.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'package:swipe_app/screens/myAD/inputField.dart';

class KitchenArea extends StatefulWidget {
  final ConcreteAd _concreteAd;
  KitchenArea(this._concreteAd);
  @override
  _KitchenAreaState createState() => _KitchenAreaState();
}
class _KitchenAreaState extends State<KitchenArea> {
  TextEditingController _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Площадь кухни", style: SemiBoldText(14, Color(0xff2E2E2E))),
          SizedBox(height: 10),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
            decoration: BoxDecoration(
                color: Color(0x20DADADA),
                borderRadius: BorderRadius.circular(10)
            ),
            //child: Text("current adress",style: RegularText(14, Color(0xff737373)),),
            child: InputField(widget._concreteAd, "setKitchenArea", _inputController, "М\u{00B2}",1),
          ),
        ],
      ),
    );
  }
}
