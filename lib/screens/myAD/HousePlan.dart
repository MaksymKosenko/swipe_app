import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/AdDataKeeper.dart';
import 'package:swipe_app/basicThings/basic.dart';

class HousePlan extends StatefulWidget {
  final ConcreteAd _concreteAd;
  HousePlan(this._concreteAd);
  @override
  _HousePlanState createState() => _HousePlanState();
}

class _HousePlanState extends State<HousePlan> {
  bool _isExpand = false;

  void changeView() {
    setState(() {
      _isExpand = !_isExpand;
    });
  }

  String selectedVar = "Студия, санузел";
  bool active1 = true;
  bool active2 = false;
  bool active3 = false;
  bool active4 = false;
  bool active5 = false;

  setNewChoise(String newSelected) {
    setState(() {
      selectedVar = newSelected;
      widget._concreteAd.setHousePlan(selectedVar);
      switch (newSelected) {
        case "Студия, санузел":
          active1 = true;
          active2 = false;
          active3 = false;
          active4 = false;
          active5 = false;
          break;
        case "Смежные комнаты":
          active1 = false;
          active2 = true;
          active3 = false;
          active4 = false;
          active5 = false;
          break;
        case "Изолированные комнаты":
          active1 = false;
          active2 = false;
          active3 = true;
          active4 = false;
          active5 = false;
          break;
        case "Евро планировка":
          active1 = false;
          active2 = false;
          active3 = false;
          active4 = true;
          active5 = false;
          break;
        case "Свободная планировка":
          active1 = false;
          active2 = false;
          active3 = false;
          active4 = false;
          active5 = true;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    widget._concreteAd.setHousePlan(selectedVar);
    return _isExpand
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Планировка",
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
                          onTap: ()=> setNewChoise("Студия, санузел"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Студия, санузел",
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
                          onTap: ()=> setNewChoise("Смежные комнаты"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Смежные комнаты",
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
                          onTap: ()=> setNewChoise("Изолированные комнаты"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Изолированные комнаты",
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
                          onTap: ()=> setNewChoise("Евро планировка"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Евро планировка",
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
                        SizedBox(height: 8),
                        GestureDetector(
                          onTap: ()=> setNewChoise("Свободная планировка"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Свободная планировка",
                                  style: RegularText(14, Color(0xff737373)),
                                ),
                                Container(
                                  height: 15,
                                  width: 15,
                                  decoration: BoxDecoration(
                                    color: active5
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
                Text("Планировка ", style: SemiBoldText(14, Color(0xff2E2E2E))),
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
