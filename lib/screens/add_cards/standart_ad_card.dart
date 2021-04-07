import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/add_model.dart';
import 'package:swipe_app/models/repository/api_add.dart';



class SAdCard extends StatefulWidget{
  final Add _add;
  final ApiAdd _apiAdd;
  SAdCard(this._add, [this._apiAdd]);
  SAdCard.fromApi(this._apiAdd, [this._add]);
  @override
  _SAdCardState createState() => _SAdCardState();
}

class _SAdCardState extends State<SAdCard> {
  Widget build(BuildContext context) {
    dynamic _add;
    if (widget._apiAdd != null)
      _add = widget._apiAdd;
    if (widget._add != null)
      _add = widget._add;


    int minutes;
    String minValue;
    String hours;
    String day;
    String month;


      minutes = TimeOfDay.now().minute;
      minValue = minutes.toString();
      if (TimeOfDay.now().minute < 10) {
        minValue = "0$minValue";
      }

      if(widget._apiAdd != null){
        print("_aiAdd != null");
        minValue = _add.dateTime.toDate().minute.toString();
        if(_add.dateTime.toDate().minute < 10)
          minValue = "0$minValue";
        hours =_add.dateTime.toDate().hour.toString();
        if(_add.dateTime.toDate().hour < 10)
          hours = "0$hours";
        day = _add.dateTime.toDate().day.toString();
        if(_add.dateTime.toDate().day < 10)
          day = "0$day";
        month = _add.dateTime.toDate().month.toString();
        if(_add.dateTime.toDate().month < 10)
          month = "0$month";
      }


      bool textColor = false;
      Color textClr; // = Colors.transparent;

      if (_add.textColorGreen == true || _add.textColorRose == true) {
        setState(() {
          textColor = true;
          if (_add.textColorRose == true)
            textClr = Color(0xffFDD7D7); //Color(0xffCEF2D2),
          if (_add.textColorGreen == true)
            textClr = Color(0xffCEF2D2);
        });
      }

      bool isPhrase = false;
      if (_add.chosenPhrase == null) {
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
                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(fit: BoxFit.cover,
                              image: widget._apiAdd == null ? FileImage(
                                  _add.photoFiles[0])
                                  : NetworkImage(_add.photos == null ? "https://kartinkinaden.ru/uploads/posts/2021-01/1610904678_14-p-absolyutno-belii-fon-35.png":
                                  _add.photos[0]))),
                    ),
                    // Image.network("https://images.unsplash.com/photo-1580587771525-78b9dba3b914?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=967&q=80"),
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
                        child: Text("${_add.chosenPhrase}",
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
                      "${_add.cost} ₴", style: SemiBoldText(18, Colors.black),),
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
                          Text("${_add.roomsQuantity}, ${_add
                              .overallArea} М\u{00B2}",
                            style: MediumText(12, Colors.black),),
                          //Text("р-н Центральный", style: MediumText(12, Color(0xff414141))),
                          Text(_add.address, style: MediumText(12, Color(
                              0xff414141))),
                        ],
                      ),
                    ),
                    SizedBox(height: 7),
                    widget._apiAdd == null ?
                    Text("Сегодня в ${TimeOfDay.now().hour + 2} : $minValue", style: MediumText(11, Color(0xff27AEA4)))
                        : Text("$day.$month в $hours : $minValue",
                        style: MediumText(11, Color(0xff27AEA4)))
                  ],
                ),
              ),
            ]),
      );
    }
  }

