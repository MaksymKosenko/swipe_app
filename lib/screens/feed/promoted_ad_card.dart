import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/add_model.dart';
import 'package:swipe_app/models/repository/api_add.dart';


class UpAdCard extends StatefulWidget{
  final ApiAdd _add;
  UpAdCard(this._add);

  @override
  _UpAdCardState createState() => _UpAdCardState();
}

class _UpAdCardState extends State<UpAdCard> {
  Widget build(BuildContext context){
    bool textColor = false;
    Color textClr;

    if(widget._add.textColorRose == true  || widget._add.textColorGreen == true){
      setState(() {
        textColor = true;
        if(widget._add.textColorRose == true)
          textClr = Color(0xffFDD7D7); //Color(0xffCEF2D2),
        if(widget._add.textColorGreen == true)
          textClr = Color(0xffCEF2D2);
      });
    }

    bool isPhrase = false;
    if(widget._add.chosenPhrase == null){
      setState(() {
        isPhrase = false;
      });
    }
    if(widget._add.chosenPhrase != null){
      setState(() {
        isPhrase = true;
      });
    }

    var hours = widget._add.dateTime.toDate().hour.toString();
    var minutes = widget._add.dateTime.toDate().minute.toString();
    var day = widget._add.dateTime.toDate().day.toString();
    var month =widget._add.dateTime.toDate().month.toString();
    if(widget._add.dateTime.toDate().hour < 10)
      hours = "0$hours";

    if(widget._add.dateTime.toDate().minute < 10)
      minutes = "0$minutes";

    if(widget._add.dateTime.toDate().day < 10)
      day = "0$day";

    if(widget._add.dateTime.toDate().month < 10)
      month = "0$month";
    //String url = "https://images.unsplash.com/photo-1527030280862-64139fba04ca?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=906&q=80";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      //height: 215,
      //width: 355,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    height: 140,
                    width: 355,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(fit: BoxFit.cover,
                            image: NetworkImage(widget._add.photos[0]))),
                  ),
                  // Image.network("https://images.unsplash.com/photo-1580587771525-78b9dba3b914?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=967&q=80"),
                  Positioned(
                    top: 9,right: 8,
                    child: Icon(Icons.brightness_1_outlined, color: Colors.white,),
                  ),
                  Positioned(
                    top: 9,left: 8,
                    child: isPhrase ?
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.67),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xffEB5757),Color(0xffEB8C57)],
                          )
                      ),
                      child: Text("${widget._add.chosenPhrase}", style: MediumText(9, Colors.white),),
                    ): Container(width: 0.0, height: 0.0),
                    //child: Container(child: Text("example"), color: Colors.amberAccent,),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: textColor ? textClr : Colors.transparent),// Color(0xffFDD7D7), //Color(0xffCEF2D2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget._add.cost} ₴", style: SemiBoldText(24, Colors.black),),
                      SizedBox(height: 5),
                      //Text("р-н Центральный", style: MediumText(12, Color(0xff414141))),
                      Container( width: 200,
                          child: Text(widget._add.address, style: MediumText(12, Color(0xff414141)), overflow:TextOverflow.clip,)),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      //SizedBox(height: 6),
                      Text("${widget._add.roomsQuantity}, ${widget._add.overallArea}М\u{00B2}",
                        style:  SemiBoldText(14, Colors.black),),

                      SizedBox(height: 22),
                      Text("$day.$month в $hours : $minutes",style: MediumText(11, Color(0xff27AEA4))),
                    ],
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}