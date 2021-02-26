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
                              "Апартаменты",
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
                        Text(
                          "Жк Семейный",
                          style: RegularText(14, Color(0xff27AEA4)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Жк Дружба",
                          style: RegularText(14, Color(0xff27AEA4)),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Жк София",
                          style: RegularText(14, Color(0xff27AEA4)),
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
                Text("Назначение ",
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
                          "Апартаменты",
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
