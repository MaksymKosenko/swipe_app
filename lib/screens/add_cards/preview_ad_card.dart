import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/repository/api_add.dart';

class PreviewAdCard extends StatefulWidget {
  final ApiAdd _add;

  PreviewAdCard(this._add);

  @override
  _PreviewAdCardState createState() => _PreviewAdCardState();
}

class _PreviewAdCardState extends State<PreviewAdCard> {
  @override
  Widget build(BuildContext context) {
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

    String selectedImage = widget._add.photos[0];
    return Container(
      height: 275, //205
      width: 355,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Container(
            height: 205, width: 355,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(selectedImage), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Column(
                 // mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${widget._add.roomsQuantity}, ${widget._add.overallArea}М\u{00B2}",
                      style:  MediumText(12, Colors.black),),
                   // SizedBox(height: 9),
                    //Text("р-н Центральный", style: MediumText(12, Color(0xff414141))),
                    Container( width: 140,//160
                        child: Text(widget._add.address, style: MediumText(12, Color(0xff414141)), overflow:TextOverflow.clip,)),
                  ],
                ),

                Column(
                  //crossAxisAlignment: CrossAxisAlignment.end,
                 // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${widget._add.cost} ₴", style: SemiBoldText(18, Colors.black),),
                    //SizedBox(height: 6),


                    //SizedBox(height: 4),
                    Text("Смотреть объявление",style: SemiBoldText(12, Color(0xff27AEA4)))
                    //Text("$day.$month в $hours : $minutes",style: MediumText(11, Color(0xff27AEA4))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ), //Image.network(widget._add.photos[0]),
    );
  }
}
