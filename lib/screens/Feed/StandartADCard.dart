import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swipe_app/screens/myAD/confirmation/AdDataKeeper.dart';
import 'package:swipe_app/basicThings/basic.dart';


class SAdCard extends StatefulWidget{
  final ConcreteAd _concreteAd;
  SAdCard(this._concreteAd);
 //SAdCard.fromDB(this._concreteAd);
  @override
  _SAdCardState createState() => _SAdCardState();
}

class _SAdCardState extends State<SAdCard> {

  Widget build(BuildContext context){
    int minutes = TimeOfDay.now().minute;
    String minValue = minutes.toString();
    if(TimeOfDay.now().minute < 10){
      minValue = "0$minValue";
    }
    bool textColor = false;
    Color textClr;// = Colors.transparent;

    if(widget._concreteAd.textColor1 == true || widget._concreteAd.textColor2 == true){
      setState(() {
        textColor = true;
        if(widget._concreteAd.textColor1 == true)
          textClr = Color(0xffFDD7D7); //Color(0xffCEF2D2),
        if(widget._concreteAd.textColor2 == true)
          textClr = Color(0xffCEF2D2);
      });
    }

    bool isPhrase = false;
    //String phrase = ;// = widget._concreteAd.chosenPhrase;
    if(widget._concreteAd.chosenPhrase == "null"){
      setState(() {
        isPhrase = false;
      });
    }
    if(widget._concreteAd.chosenPhrase != "null"){
      setState(() {
        isPhrase = true;
      });
    }
   return GestureDetector(
      onTap: ()=> print("testim - ${DateTime.now().day}"),
      child: Container(
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
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(fit: BoxFit.cover,
                        image: NetworkImage(widget._concreteAd.mainPhotoPath))),
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
                      child: Text("${widget._concreteAd.chosenPhrase}", style: MediumText(9, Colors.white),),
                    ): Container(width: 0.0, height: 0.0),
                  )
          ],
          ),
        ),
          SizedBox(height: 10),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget._concreteAd.cost} ₴", style: SemiBoldText(18, Colors.black),),
                SizedBox(height: 5),
                Container(
                  padding: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 10),
                 // height: 100,
                  width: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                   color: textColor ? textClr : Colors.transparent// Color(0xffFDD7D7), //Color(0xffCEF2D2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${widget._concreteAd.roomsQuantity}, ${widget._concreteAd.overallArea}m2, 1/8 эт.", style:  MediumText(12, Colors.black),),
                      Text("р-н Центральный", style: MediumText(12, Color(0xff414141))),
                      Text(widget._concreteAd.location, style: MediumText(12, Color(0xff414141))),
                    ],
                  ),
                ),
                SizedBox(height: 7),

                Text("Сегодня в ${TimeOfDay.now().hour +2} : $minValue",//TODO сделать потом ормальную таймзону
                    style: MediumText(11, Color(0xff27AEA4))),],
            ),
          ),
      ]),
      ),
    );
  }
}

class AdCard extends StatefulWidget{
  final ConcreteAd _concreteAd;
  AdCard(this._concreteAd);
  @override
  _AdCardState createState() => _AdCardState();
}

class _AdCardState extends State<AdCard> {

  Widget build(BuildContext context){
    int minutes = widget._concreteAd.minutes;
    String minValue = minutes.toString();
    if(minutes < 10){
      minValue = "0$minValue";
    }
    int hours = widget._concreteAd.hours;
    String day = widget._concreteAd.day;
    String month = widget._concreteAd.month;
    bool textColor = false;
    Color textClr;

    if(widget._concreteAd.textColor1 == true || widget._concreteAd.textColor2 == true){
      setState(() {
        textColor = true;
        if(widget._concreteAd.textColor1 == true)
          textClr = Color(0xffFDD7D7); //Color(0xffCEF2D2),
        if(widget._concreteAd.textColor2 == true)
          textClr = Color(0xffCEF2D2);
      });
    }

    bool isPhrase = false;
    if(widget._concreteAd.chosenPhrase == "null"){
      setState(() {
        isPhrase = false;
      });
    }
    if(widget._concreteAd.chosenPhrase != "null"){
      setState(() {
        isPhrase = true;
      });
    }



    return GestureDetector(
      onTap: (){
      //  listExample();
      },
      child: Container(
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
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(fit: BoxFit.cover,
                              image: NetworkImage(widget._concreteAd.mainPhotoPath))),
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
                        child: Text("${widget._concreteAd.chosenPhrase}", style: MediumText(9, Colors.white),),
                      ): Container(width: 0.0, height: 0.0),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget._concreteAd.cost} ₴", style: SemiBoldText(18, Colors.black),),
                    SizedBox(height: 5),
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 10, top: 5, bottom: 10),
                      // height: 100,
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: textColor ? textClr : Colors.transparent// Color(0xffFDD7D7), //Color(0xffCEF2D2),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${widget._concreteAd.roomsQuantity}, ${widget._concreteAd.overallArea}, 1/8 эт.", style:  MediumText(12, Colors.black),),
                          Text("р-н Центральный", style: MediumText(12, Color(0xff414141))),
                          Text(widget._concreteAd.location, style: MediumText(12, Color(0xff414141))),
                        ],
                      ),
                    ),
                    SizedBox(height: 7),

                    Text("$day $month в $hours : $minValue",//TODO сделать потом ормальную таймзону
                        style: MediumText(11, Color(0xff27AEA4))),],
                ),
              ),
            ]),
      ),
    );
  }
}