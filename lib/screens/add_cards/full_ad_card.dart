import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/ad_appbar.dart';
import 'package:swipe_app/global/custom_widgets/report_add.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/global/user.dart';
import 'package:swipe_app/models/repository/api_add.dart';
import 'package:swipe_app/screens/chat_screens/user_to_user.dart';
import 'package:swipe_app/screens/feed/landing_page.dart';
import 'package:swipe_app/models/repository/api_user.dart';
import 'package:swipe_app/screens/maps/add_on_map.dart';
import 'package:url_launcher/url_launcher.dart';

class FullAdCard extends StatefulWidget {
  final ApiAdd _add;
  final String _id;
  final List _addIds;
  FullAdCard(this._add, this._id, this._addIds);

  @override
  _FullAdCardState createState() => _FullAdCardState();
}


class _FullAdCardState extends State<FullAdCard> {
  ApiUser _user;

  getData() async{
    await FirebaseFirestore.instance.collection('users').doc(widget._add.ownerID).get()
        .then((DocumentSnapshot documentSnapshot) {
          _user = ApiUser.fromApi(documentSnapshot.data());
      if(_user !=null){
        setState(() {
          print(_user.phone);
          print(_user.photoPath);
        });
      }
    }
    );
  }
  int photoIndex = 0;
  @override
  Widget build(BuildContext context) {
    final ConcreteUser user = Provider.of<ConcreteUser>(context);

    bool isFavourite;
    isFavourite = false;
    if(widget._addIds != null)
      widget._addIds.forEach((element)
      {if(element == widget._add.id)
        setState(() {
          isFavourite = true;
        });

      });

  if(_user == null)
    getData();


    print("fullAd id - ${widget._id}");
    bool isFewImages = false;
    bool connection = false;
    String selectedImage = widget._add.photos[photoIndex];
    if (widget._add.photos.length > 1) isFewImages = true;
    if(widget._add.connectionType == "Звонок + сообщение" || widget._add.connectionType =="Звонок + сообщение агенту")
      connection = true;
    void changeView(String way, int currentIndex){
      switch(way){
        case "left": print("left");if(currentIndex > 0) setState(() {
          currentIndex--;
          photoIndex = currentIndex;
          print(currentIndex);
        });break;
        case "right": print("right"); if(currentIndex < widget._add.photos.length-1) setState(() {
          currentIndex++;
          photoIndex = currentIndex;
        });break;
      }
    }

    Future <void> showReport(String name,context) async{
      return showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 15),
              shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(10.0)),
              child: ReportAdd(name, widget._id, widget._add.ownerID, user.phone),

            );
          });
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AdAppBar(widget._id, MaterialPageRoute(builder: (context)=> LandingPage()),isFavourite),
      ),
      body: Container(color: Colors.white,
        child: ListView(
          children: [
          Container(
         // height: 300, //205 //275
          //width: 355,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            children: [
              isFewImages
                  ? Stack(children: [
                Container(
                  height: 220, //width: 355,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(selectedImage),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 202),
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      dotsBuilder(widget._add.photos.length, photoIndex),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 82),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => changeView("left", photoIndex),
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            CupertinoIcons.chevron_left,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => changeView("right", photoIndex),
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.black54,
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            CupertinoIcons.chevron_right,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ])
                  : Container(
                height: 205, //width: 355,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(selectedImage), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),


            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget._add.cost} ₴",
                        style: SemiBoldText(20, Colors.black),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${widget._add.roomsQuantity}, ${widget._add
                            .overallArea}М\u{00B2}",
                        style: MediumText(14, Colors.black),
                      ),
                      SizedBox(height: 15),
                      Container(
                          width: 140, //160
                          child: Text(
                            widget._add.address,
                            style: MediumText(14, Color(0xff414141)),
                            overflow: TextOverflow.clip,
                          )),
                    ],
                  ),

                  GestureDetector(
                    onTap: (){
                      if(widget._add != null)
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            AddMapScreen(widget._add, widget._id, widget._add.location.latitude, widget._add.location.longitude, widget._addIds)));
                    } ,
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.map_outlined,color: Color(0xff27AEA4)),
                          SizedBox(width: 10),
                          Text("На карте", style: MediumText(14, Color(0xff27AEA4))),
                          SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Вид недвижимости", style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Количество комнат", style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Назначение", style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Жилое состояние", style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Планировка", style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Общая площадь", style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Площадь кухни", style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Балкон/лоджия", style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Отопление", style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Варианты расчета", style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Коммисия агенту", style: RegularText(14, Color(0xff8C8C8C))),
                    ],
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Вторичный рынок", style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(widget._add.roomsQuantity, style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(widget._add.apartmentsType, style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(widget._add.houseState, style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(widget._add.housePlan, style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(widget._add.overallArea, style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(widget._add.kitchenArea, style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(widget._add.balconyState, style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(widget._add.heatingType, style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(widget._add.paymentType, style: RegularText(14, Colors.black), overflow: TextOverflow.ellipsis, maxLines: 1),
                        SizedBox(height: 15),
                        Text(widget._add.agentPayment, style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(widget._add.description,
                style: RegularText(12, Color(0xff414141)),),
            ),
            SizedBox(height: 40),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 66,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xffEDEDED)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 46, width: 46,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          image: DecorationImage(image: _user == null
                              ? AssetImage('assets/images/plus.png')
                              : NetworkImage(_user.photoPath)),
                          color: Colors.black),
                    ),
                    SizedBox(width: 18),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_user == null ? "Name" : _user.userName, style: RegularText(14, Colors.black)),
                        SizedBox(height: 3),
                        Text("частное лицо", style: RegularText(10, Color(0xff949494))),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ),
            SizedBox(height: 30),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: ()=> showReport("Пожаловаться на объявление", context),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0x26EB5757)),
                  child: Text("Пожаловаться на объявление", style: MediumText(14, Colors.red),),
                ),
              ),
            ),
            SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 116),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xff56C385), Color(0xff41BFB5)],//[Color(0xff56C385), Color(0xff41BFB5)],
                    ),
                    boxShadow: [BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12.0, // soften the shadow
                      spreadRadius: 1.0, //extend the shadow
                      offset: Offset(
                        7.0, // Move to right 10  horizontally
                        7.0, // Move to bottom 5 Vertically
                      ),
                    )]
                  ),
                child: connection
                    ? Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: ()=> launch('tel:${_user.phone}'),
                        child: Container(
                          height: 52,
                          width: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: Color(0xE6FFFFFF)
                          ),
                          child: Icon(Icons.phone_in_talk_outlined, color: Color(0xff4CC19A), size: 24,),// CupertinoIcons.phone_arrow_up_right
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          if(_user != null){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                UserToUserChat(_user.userName, _user.userSurName, user.phone, widget._add, widget._id,  widget._addIds)));
                          }
                        },
                        child: Container(
                          height: 52,
                          width: 52,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(26),
                              color: Color(0x1AFFFFFF)
                          ),
                          child: Icon(CupertinoIcons.chat_bubble, color: Colors.white, size: 24,),
                        ),
                      )
                    ],
                  ),
                )
                    : GestureDetector(
                  onTap: ()=> launch('tel:${_user.phone}'),
                      child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        //color: Color(0xE6FFFFFF)
                  ),
                  child: Icon(Icons.phone_in_talk_outlined, color: Colors.white, size: 24,),
                ),
                    ),
                ),
              ),

            SizedBox(height: 30),
        ],
      ),),);
  }

  Widget dotsBuilder(int length, int index) {
    switch (length) {
      case 2:
        return Row(
          children: [
            index == 0 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 1 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
          ],
        );
        break;
      case 3:
        return Row(
          children: [
            index == 0 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 1 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 2 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
          ],
        );
        break;
      case 4:
        return Row(
          children: [
            index == 0 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 1 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 2 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 3 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
          ],
        );
        break;
      case 5:
        return Row(
          children: [
            index == 0 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 1 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 2 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 3 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 4 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
          ],
        );
        break;
      case 6:
        return Row(
          children: [
            index == 0 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 1 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 2 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 3 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 4 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 5 ? Container(height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
          ],
        );
        break;
    }
  }
}
