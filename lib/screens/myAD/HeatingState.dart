import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/basic.dart';

class HeatingState extends StatefulWidget {
  @override
  _HeatingStateState createState() => _HeatingStateState();
}

class _HeatingStateState extends State<HeatingState> {
  bool _isExpand = false;

  void changeView() {
    setState(() {
      _isExpand = !_isExpand;
    });
  }

  String selectedVar = "Водяное";
  bool active1 = true;
  bool active2 = false;
  bool active3 = false;

  setNewChoise(String newSelected) {
    setState(() {
      selectedVar = newSelected;
      switch (newSelected) {
        case "Водяное":
          active1 = true;
          active2 = false;
          active3 = false;
          break;
        case "Воздушное":
          active1 = false;
          active2 = true;
          active3 = false;
          break;
        case "Электрическое":
          active1 = false;
          active2 = false;
          active3 = true;
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
                  Text("Тип отопления",
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
                          onTap: () => setNewChoise("Водяное"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Водяное",
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
                        SizedBox(height: 13),
                        GestureDetector(
                          onTap: () => setNewChoise("Воздушное"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Воздушное",
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
                        SizedBox(height: 13),
                        GestureDetector(
                          onTap: () => setNewChoise("Электрическое"),
                          child: Container(
                            padding:
                                EdgeInsets.only(right: 15, top: 5, bottom: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Электрическое",
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
                Text("Тип отопления",
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
