import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/add_model.dart';
import 'package:swipe_app/models/repository/api_zhk.dart';
import 'package:swipe_app/screens/my_add/build_add/ad_address.dart';
import 'package:swipe_app/screens/my_add/search_field.dart';
import 'package:swipe_app/screens/my_add/whole_ad_container.dart';

class ZhK extends StatefulWidget {
  final dynamic _addState;
  final Add _add;
  ZhK(this._addState, this._add);

  @override
  _ZhKState createState() => _ZhKState();
}

class _ZhKState extends State<ZhK> {
  bool _isExpand = false;

  void changeView() {
    setState(() {
      _isExpand = !_isExpand;
    });
  }

  int quantity = 0;
  List _zhks= [];
  @override
  Widget build(BuildContext context) {
    CollectionReference _userSaves = FirebaseFirestore.instance.collection('zhk');

    Future<void> getQuantity() {
      print("getQuantity starts");
      return _userSaves
          .get()
          .then((value) { if(quantity != value.size){setState(() {
        value.docs.forEach((element) {
          _zhks.add(ApiZhk.fromApi(element.data()));});
        quantity = value.size;
      });} print("length is - $quantity"); print("zhk[0] - ${_zhks[0]}");} )
          .catchError((error) => print("Failed to get Favourite: $error"));
    }

    getQuantity();

    String currentZhK;
    if(widget._add.chosenZhK != null)
    currentZhK = widget._add.chosenZhK;
    else currentZhK = " ";


    setNewCurrentZhK(String newCurrent, String address, GeoPoint location){
      setState(() {
        currentZhK = newCurrent;
        widget._add.chosenZhK = currentZhK;
        widget._add.address = address;
        widget._add.location = location;
      });
    }


    TextEditingController _zhkNameController = TextEditingController();
    widget._add.chosenZhK = currentZhK;
    return _isExpand
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Выбрать ЖК",
                          style: SemiBoldText(14, Color(0xff2E2E2E))),
                      Container(
                        child: Row(
                          children: [
                            Text("Добавиться в шахматку",
                                style: SemiBoldText(14, Color(0xff4BC19D))),
                            SizedBox(width: 10),
                            Icon(CupertinoIcons.rectangle_grid_2x2,
                                color: Color(0xff4BC19D)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(color: Color(0x20DADADA),
                     borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SearchField(_zhkNameController, currentZhK),
                            //Text("Введите название жк:", style: RegularText(14, Color(0xff737373)),),
                            IconButton(icon: Icon(CupertinoIcons.chevron_up, size: 24,), onPressed: ()=> changeView())
                          ],
                        ),
                        GestureDetector(
                            child: Text(_zhks[0].name,style: RegularText(14, Color(0xff27AEA4))),
                        onTap: ()=> setNewCurrentZhK(_zhks[0].name, _zhks[0].address, _zhks[0].location),),
                        SizedBox(height:8),
                        GestureDetector(
                          child: Text(_zhks[1].name,style: RegularText(14, Color(0xff27AEA4))),
                          onTap: ()=> setNewCurrentZhK(_zhks[1].name, _zhks[1].address, _zhks[1].location),),
                        SizedBox(height:8),
                        GestureDetector(
                          child: Text(_zhks[2].name,style: RegularText(14, Color(0xff27AEA4))),
                          onTap: ()=> setNewCurrentZhK(_zhks[2].name, _zhks[2].address, _zhks[2].location),),
                        SizedBox(height:13),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Выбрать ЖК",
                        style: SemiBoldText(14, Color(0xff2E2E2E))),
                    Container(
                      child: Row(
                        children: [
                          Text("Добавиться в шахматку",
                              style: SemiBoldText(14, Color(0xff4BC19D))),
                          SizedBox(width: 10),
                          Icon(CupertinoIcons.rectangle_grid_2x2,
                              color: Color(0xff4BC19D)),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                GestureDetector(
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                    decoration: BoxDecoration(
                        color: Color(0x20DADADA),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          currentZhK,
                          style: RegularText(14, Color(0xff737373)),
                        ),
                        Icon(CupertinoIcons.chevron_down, size: 24,)
                      ],
                    ),
                  ),
                  onTap: () => changeView(),
                ),
              ],
            ),
          );
  }
}
