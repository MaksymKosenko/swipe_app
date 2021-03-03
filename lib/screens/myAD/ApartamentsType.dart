import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'package:swipe_app/screens/myAD/SearchField.dart';

class ApartmentType extends StatefulWidget {
  @override
  _ApartmentTypeState createState() => _ApartmentTypeState();
}

class _ApartmentTypeState extends State<ApartmentType> {
  bool _isExpand = false;

  void changeView() {
    setState(() {
      _isExpand = !_isExpand;
    });
  }

  String selectedVar = "Aпартаменты";
  bool active1 = false;
  bool active2 = false;
  bool active3 = false;
  bool active4 = true;

  setNewChoise(String newSelected) {
    setState(() {
      selectedVar = newSelected;
      switch (newSelected) {
        case "Апарт-отель":
          active1 = true;
          active2 = false;
          active3 = false;
          active4 = false;
          break;
        case "Доходной дом":
          active1 = false;
          active2 = true;
          active3 = false;
          active4 = false;
          break;
        case "Кондоминимум":
          active1 = false;
          active2 = false;
          active3 = true;
          active4 = false;
          break;
        case "Апартаменты":
          active1 = false;
          active2 = false;
          active3 = false;
          active4 = true;
          break;
      }
    });
  }

  @override

  Widget build(BuildContext context) {
    return _isExpand
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Назначение",
                      style: SemiBoldText(14, Color(0xff2E2E2E))),
                  SizedBox(height: 10),
                  Container(
                    width: double.maxFinite,
                    //padding: EdgeInsets.symmetric(vertical: 13, horizontal: 12),
                    padding: EdgeInsets.only(left: 12, top: 1),
                    decoration: BoxDecoration(
                        color: Color(0x20DADADA),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedVar,
                              style: RegularText(14, Color(0xff737373)),
                            ),
                            //Text("Введите название жк:", style: RegularText(14, Color(0xff737373)),),
                            IconButton(
                                icon: Icon(
                                  CupertinoIcons.chevron_up,
                                  size: 24,
                                ),
                                onPressed: () => changeView())
                          ],
                        ),
                        GestureDetector(
                          onTap: ()=> setNewChoise("Апарт-отель"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Апарт-отель",
                                  style: RegularText(14, Color(0xff737373)),
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: active1
                                        ? Color(0xff41BFB5)
                                        : Color(0xffE8E8E8),
                                    borderRadius: BorderRadius.circular(7.5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: ()=> setNewChoise("Доходной дом"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Доходной дом",
                                  style: RegularText(14, Color(0xff737373)),
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: active2
                                        ? Color(0xff41BFB5)
                                        : Color(0xffE8E8E8),
                                    borderRadius: BorderRadius.circular(7.5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: ()=> setNewChoise("Кондоминимум"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Кондоминимум",
                                  style: RegularText(14, Color(0xff737373)),
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: active3
                                        ? Color(0xff41BFB5)
                                        : Color(0xffE8E8E8),
                                    borderRadius: BorderRadius.circular(7.5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: ()=> setNewChoise("Апартаменты"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Апартаменты",
                                  style: RegularText(14, Color(0xff737373)),
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: active4
                                        ? Color(0xff41BFB5)
                                        : Color(0xffE8E8E8),
                                    borderRadius: BorderRadius.circular(7.5),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 13),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Назначение ", style: SemiBoldText(14, Color(0xff2E2E2E))),
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
                          selectedVar,
                          style: RegularText(14, Color(0xff737373)),
                        ),
                        Icon(
                          CupertinoIcons.chevron_down,
                          size: 24,
                        )
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
