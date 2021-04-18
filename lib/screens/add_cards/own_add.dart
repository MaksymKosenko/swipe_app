import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/ad_appbar.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/add_model.dart';
import 'package:swipe_app/models/repository/api_add.dart';
import 'package:swipe_app/screens/feed/landing_page.dart';

class PreviewScreen extends StatefulWidget {
  final String _id;

  PreviewScreen(this._id);

  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

int photoIndex = 0;

class _PreviewScreenState extends State<PreviewScreen> {
  dynamic data;
  ApiAdd _add;

  Future<dynamic> getData() async {

    final DocumentReference document = FirebaseFirestore.instance.collection('ads').doc(widget._id);

    await document.get().then<dynamic>(( DocumentSnapshot snapshot) async{
      setState(() {
        data =snapshot.data;
        _add = ApiAdd.fromApiToDoc(data);
      });
    });
  }

  @override
  void initState() {

    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
   // DocumentReference _ad = FirebaseFirestore.instance.collection('ads').doc(widget._id);
    //ApiAdd _add = widget._add;

    List<dynamic> adsPhotoList = [];
    adsPhotoList = _add.photos;
    bool isFewImages = false;
    bool connection = false;
    //print("data['photos'].length - ${data['photos'].length}");
    //print("data['photos'].length - ${data['photos'][0]}");
    String selectedImage =
    adsPhotoList[photoIndex]; //data['photos'][photoIndex];
    if (_add.photos.length > 1) isFewImages = true;
    if (_add.connectionType == "Звонок + сообщение" ||
        _add.connectionType == "Звонок + сообщение агенту")
      connection = true;

    void changeView(String way, int currentIndex) {
      switch (way) {
        case "left":
          print("left");
          if (currentIndex > 0)
            setState(() {
              currentIndex--;
              photoIndex = currentIndex;
              print(currentIndex);
            });
          break;
        case "right":
          print("right");
          if (currentIndex < _add.photos.length - 1)
            setState(() {
              currentIndex++;
              photoIndex = currentIndex;
            });
          break;
      }
    }

    return
      Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AdAppBar(widget._id,
            MaterialPageRoute(builder: (context) => LandingPage()), false),
      ),
      body: Container(
        color: Colors.white,
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
                          dotsBuilder(_add.photos.length, photoIndex),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12, vertical: 82),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () =>
                                changeView("left", photoIndex),
                            child: Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius:
                                  BorderRadius.circular(20)),
                              child: Icon(
                                CupertinoIcons.chevron_left,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () =>
                                changeView("right", photoIndex),
                            child: Container(
                              width: 40,
                              height: 40,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius:
                                  BorderRadius.circular(20)),
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
                        //image: NetworkImage("https://bipbap.ru/wp-content/uploads/2017/05/VOLKI-krasivye-i-ochen-umnye-zhivotnye.jpg"),// NetworkImage(selectedImage),
                          image: NetworkImage(selectedImage),
                          fit: BoxFit.cover),
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
                        "${_add.cost} ₴",
                        style: SemiBoldText(20, Colors.black),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "${_add.roomsQuantity}, ${_add.overallArea}М\u{00B2}",
                        style: MediumText(14, Colors.black),
                      ),
                      SizedBox(height: 15),
                      Container(
                          width: 140, //160
                          child: Text(
                            _add.address,
                            style: MediumText(14, Color(0xff414141)),
                            overflow: TextOverflow.clip,
                          )),
                    ],
                  ),
                  GestureDetector(
                    onTap: () => null,
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => MapScreen(this, widget._add))),
                    child: Container(
                      child: Row(
                        children: [
                          Icon(Icons.map_outlined,
                              color: Color(0xff27AEA4)),
                          SizedBox(width: 10),
                          Text("На карте",
                              style: MediumText(14, Color(0xff27AEA4))),
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
                      Text("Вид недвижимости",
                          style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Количество комнат",
                          style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Назначение",
                          style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Жилое состояние",
                          style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Планировка",
                          style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Общая площадь",
                          style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Площадь кухни",
                          style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Балкон/лоджия",
                          style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Отопление",
                          style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Варианты расчета",
                          style: RegularText(14, Color(0xff8C8C8C))),
                      SizedBox(height: 15),
                      Text("Коммисия агенту",
                          style: RegularText(14, Color(0xff8C8C8C))),
                    ],
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Вторичный рынок",
                            style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(_add.roomsQuantity,
                            style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(_add.apartmentsType,
                            style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(_add.houseState,
                            style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(_add.housePlan,
                            style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(_add.overallArea,
                            style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(_add.kitchenArea,
                            style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(_add.balconyState,
                            style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(_add.heatingType,
                            style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                        Text(_add.paymentType,
                            style: RegularText(14, Colors.black),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1),
                        SizedBox(height: 15),
                        Text(_add.agentPayment,
                            style: RegularText(14, Colors.black)),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                _add.description,
                style: RegularText(12, Color(0xff414141)),
              ),
            ),
            SizedBox(height: 40),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                height: 66,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffEDEDED)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 46,
                        width: 46,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(23),
                            color: Colors.black),
                      ),
                      SizedBox(width: 18),
                      Column(
                        //TODO - юзер с бд + zvonki/4at
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name",
                              style: RegularText(14, Colors.black)),
                          SizedBox(height: 3),
                          Text("type",
                              style: RegularText(10, Color(0xff949494))),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0x26EB5757)),
                child: Text(
                  "Пожаловаться на объявление",
                  style: MediumText(14, Colors.red),
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
                    colors: [
                      Color(0xff56C385),
                      Color(0xff41BFB5)
                    ], //[Color(0xff56C385), Color(0xff41BFB5)],
                  ),
                ),
                child: connection
                    ? Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: Color(0xE6FFFFFF)),
                        child: Icon(
                          Icons.phone_in_talk_outlined,
                          color: Color(0xff4CC19A),
                          size: 24,
                        ), // CupertinoIcons.phone_arrow_up_right
                      ),
                      Container(
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: Color(0x1AFFFFFF)),
                        child: Icon(
                          CupertinoIcons.chat_bubble,
                          color: Colors.white,
                          size: 24,
                        ),
                      )
                    ],
                  ),
                )
                    : Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                    //color: Color(0xE6FFFFFF)
                  ),
                  child: Icon(
                    Icons.phone_in_talk_outlined,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }


  Widget dotsBuilder(int length, int index) {
    switch (length) {
      case 2:
        return Row(
          children: [
            index == 0
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 1
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
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
            index == 0
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 1
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 2
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
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
            index == 0
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 1
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 2
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 3
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
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
            index == 0
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 1
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 2
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 3
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 4
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
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
            index == 0
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 1
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 2
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 3
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 4
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.white60)),
            SizedBox(width: 10),
            index == 5
                ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white))
                : Container(
                height: 6,
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



