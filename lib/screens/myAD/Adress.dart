import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/basic.dart';

class Adress extends StatefulWidget {
  @override
  _AdressState createState() => _AdressState();
}

class _AdressState extends State<Adress> {
  @override
  Widget build(BuildContext context) {
    return   Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Адрес", style: SemiBoldText(14, Color(0xff2E2E2E))),
              Container(
                child: Row(
                  children: [
                    Text("Указать на карте", style: SemiBoldText(14, Color(0xff4BC19D))),
                    SizedBox(width: 10),
                    Icon(Icons.map_outlined,color: Color(0xff4BC19D)),
                  ],
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
            child: Text("current adress",style: RegularText(14, Color(0xff737373)),),
          ),
        ],
      ),
    );
  }
}
