import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/add_model.dart';

import 'package:swipe_app/screens/my_add/map_screen.dart';
import 'package:swipe_app/screens/my_add/whole_ad_container.dart';

class Address extends StatefulWidget {
  final dynamic _addState;
  final Add _add;
  Address(this._addState, this._add);

 /* final ConcreteAd _concreteAd;
  Address(this._concreteAd);
*/
  @override
  AddressState createState() => AddressState();
}

class AddressState extends State<Address> {


  setAddress(String newLoc){
    setState(() {
      widget._addState.setState(() {
        print(newLoc);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String _currentAdress;
    if(widget._add.address == null)
      _currentAdress = " ";
    else _currentAdress = "${widget._add.address}";
    //widget._concreteAd.setLocation(_currentAdress);
    return   Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Адрес", style: SemiBoldText(14, Color(0xff2E2E2E))),
              GestureDetector(
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen(this, widget._add))),
                child: Container(
                  child: Row(
                    children: [
                      Text("Указать на карте", style: SemiBoldText(14, Color(0xff4BC19D))),
                      SizedBox(width: 10),
                      Icon(Icons.map_outlined,color: Color(0xff4BC19D)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
            decoration: BoxDecoration(
                color: Color(0x20DADADA),
                borderRadius: BorderRadius.circular(10)
            ),
            child: Text(_currentAdress,style: RegularText(14, Color(0xff737373)),),
          ),
        ],
      ),
    );
  }
}
