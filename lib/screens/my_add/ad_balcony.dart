import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/add_model.dart';


class BalconyState extends StatefulWidget {
 final Add _add;
  BalconyState(this._add);
  @override
  _BalconyStateState createState() => _BalconyStateState();
}

class _BalconyStateState extends State<BalconyState> {
  bool _isExpand = false;

  void changeView() {
    setState(() {
      _isExpand = !_isExpand;
    });
  }
  
  String selectedVar = "Да";
  bool active1 = true;
  bool active2 = false;
  
  setNewChoise(String newSelected) {
    setState(() {
      selectedVar = newSelected;
      widget._add.balconyState = selectedVar;
      switch (newSelected) {
        case "Да":
          active1 = true;
          active2 = false;
          break;
        case "Нет":
          active1 = false;
          active2 = true;
          break;
      }});}
      
  @override
  Widget build(BuildContext context) {
    if(widget._add.balconyState == null)
      widget._add.balconyState = selectedVar;
    else setNewChoise(widget._add.balconyState);
    //widget._add.balconyState = selectedVar;
    return _isExpand
        ? Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Балкон/Лоджия",
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
                    onTap:()=> setNewChoise("Да"),
                    child: Container(
                      padding: EdgeInsets.only(right: 15, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Да",
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
                    onTap: ()=> setNewChoise("Нет"),
                    child: Container(
                      padding: EdgeInsets.only(right: 15, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Нет",
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
          Text("Балкон/Лоджия ",
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
