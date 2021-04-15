import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/add_model.dart';
import 'package:swipe_app/models/repository/api_add.dart';



class PromotingEditCard extends StatefulWidget{
  final Add _add;
  final ApiAdd _apiAdd;

  PromotingEditCard(this._add, this._apiAdd);
  @override
  _PromotingEditCardState createState() => _PromotingEditCardState();
}

class _PromotingEditCardState extends State<PromotingEditCard> {
  Widget build(BuildContext context) {



    int minutes = widget._apiAdd.dateTime.toDate().minute;
    String minValue;
    String hours = widget._apiAdd.dateTime.toDate().hour.toString();
    String day = widget._apiAdd.dateTime.toDate().day.toString();
    String month = widget._apiAdd.dateTime.toDate().month.toString();


      minValue = widget._apiAdd.dateTime.toDate().minute.toString();
      if(widget._apiAdd.dateTime.toDate().minute < 10)
        minValue = "0$minValue";
      if(widget._apiAdd.dateTime.toDate().hour < 10)
        hours = "0$hours";
      if(widget._apiAdd.dateTime.toDate().day < 10)
        day = "0$day";
      if(widget._apiAdd.dateTime.toDate().month < 10)
        month = "0$month";


    bool textColor = false;
    Color textClr; // = Colors.transparent;


    if (widget._add.textColorGreen == true || widget._add.textColorRose == true) {
      setState(() {
        textColor = true;
        if (widget._add.textColorRose == true)
          textClr = Color(0xffFDD7D7); //Color(0xffCEF2D2),
        if (widget._add.textColorGreen == true)
          textClr = Color(0xffCEF2D2);
      });
    }

    bool isPhrase = false;
    if (widget._add.chosenPhrase == null) {
      setState(() {
        isPhrase = false;
      });
    } else {
      setState(() {
        isPhrase = true;
      });
    }

    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 170,
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(fit: BoxFit.cover,
                            image: NetworkImage(widget._apiAdd.photos == null ? "https://kartinkinaden.ru/uploads/posts/2021-01/1610904678_14-p-absolyutno-belii-fon-35.png":
                            widget._apiAdd.photos[0]))),
                  ),
                  Positioned(
                    top: 9, right: 8,
                    child: Icon(
                      Icons.brightness_1_outlined, color: Colors.white,),
                  ),


                  Positioned(
                    top: 9, left: 8,
                    child: isPhrase ?
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.67),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [Color(0xffEB5757), Color(0xffEB8C57)],
                          )
                      ),
                      child: Text("${widget._add.chosenPhrase}",
                        style: MediumText(9, Colors.white),),
                    ) : Container(width: 0.0, height: 0.0),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget._apiAdd.cost} ₴ ", style: SemiBoldText(18, Colors.black),),
                  SizedBox(height: 5),
                  Container(
                    padding: EdgeInsets.only(
                        left: 5, right: 10, top: 5, bottom: 10),
                    // height: 100,
                    width: 170,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: textColor ? textClr : Colors
                            .transparent // Color(0xffFDD7D7), //Color(0xffCEF2D2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget._apiAdd.roomsQuantity}, ${widget._apiAdd
                            .overallArea} М\u{00B2}",
                          style: MediumText(12, Colors.black),),
                        //Text("р-н Центральный", style: MediumText(12, Color(0xff414141))),
                        Text(widget._apiAdd.address, style: MediumText(12, Color(
                            0xff414141))),
                      ],
                    ),
                  ),
                  SizedBox(height: 7),
                   Text("$day.$month в $hours : $minValue", style: MediumText(11, Color(0xff27AEA4)))
                ],
              ),
            ),
          ]),
    );
  }
}
