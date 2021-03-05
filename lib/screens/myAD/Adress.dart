import 'package:flutter/material.dart';
import 'package:swipe_app/screens/myAD/confirmation/AdDataKeeper.dart';
import 'package:swipe_app/basicThings/basic.dart';

class Adress extends StatefulWidget {
  final ConcreteAd _concreteAd;
  Adress(this._concreteAd);

  @override
  _AdressState createState() => _AdressState();
}

class _AdressState extends State<Adress> {
  String _currentAdress = "Улица х дом у";
  setAdress(){
    setState(() {
      print("map screen...");
      widget._concreteAd.setLocation(_currentAdress);
    });
  }
  @override
  Widget build(BuildContext context) {
    widget._concreteAd.setLocation(_currentAdress);
    return   Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Адрес", style: SemiBoldText(14, Color(0xff2E2E2E))),
              GestureDetector(
                onTap: ()=> setAdress(),
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
