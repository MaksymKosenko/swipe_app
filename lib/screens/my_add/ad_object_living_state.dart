import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/add_model.dart';

class OurDaysState extends StatefulWidget {
  final Add _add;
  OurDaysState(this._add);
  @override
  _OurDaysStateState createState() => _OurDaysStateState();
}

class _OurDaysStateState extends State<OurDaysState> {
  bool _isExpand = false;

  void changeView() {
    setState(() {
      _isExpand = !_isExpand;
    });
  }

  String selectedVar = "Требует ремонта";
  bool active1 = false;
  bool active2 = false;
  bool active3 = false;
  bool active4 = false;
  bool active5 = true;

  setNewChoise(String newSelected) {
    setState(() {
      selectedVar = newSelected;
      widget._add.houseState = selectedVar;
      switch (newSelected) {
        case "Косметичный ремонт":
          active1 = true;
          active2 = false;
          active3 = false;
          active4 = false;
          active5 = false;
          break;
        case "Евро - ремонт":
          active1 = false;
          active2 = true;
          active3 = false;
          active4 = false;
          active5 = false;
          break;
        case "Ремонт от застройщика":
          active1 = false;
          active2 = false;
          active3 = true;
          active4 = false;
          active5 = false;
          break;
        case "Без ремонта":
          active1 = false;
          active2 = false;
          active3 = false;
          active4 = true;
          active5 = false;
          break;
        case "Требует ремонта":
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
    if(widget._add.houseState == null)
      widget._add.houseState = selectedVar;
    else setNewChoise(widget._add.houseState);
    //widget._add.houseState = selectedVar;
    return _isExpand
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Жилое состояние",
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
                          onTap: () => setNewChoise("Косметичный ремонт"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Косметичный ремонт",
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
                          onTap: () => setNewChoise("Евро - ремонт"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Евро - ремонт",
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
                          onTap: () => setNewChoise("Ремонт от застройщика"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ремонт от застройщика",
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
                          onTap: () => setNewChoise("Без ремонта"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Без ремонта",
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
                          onTap: () => setNewChoise("Требует ремонта"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Требует ремонта",
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
                Text("Жилое состояние ",
                    style: SemiBoldText(14, Color(0xff2E2E2E))),
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
