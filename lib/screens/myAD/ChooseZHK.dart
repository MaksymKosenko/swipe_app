import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'package:swipe_app/screens/myAD/SearchField.dart';

class ZhK extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    TextEditingController _zhkNameController = TextEditingController();
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
                            SearchField(_zhkNameController, "Введите название жк:"),
                            //Text("Введите название жк:", style: RegularText(14, Color(0xff737373)),),
                            IconButton(icon: Icon(CupertinoIcons.chevron_up, size: 24,), onPressed: ()=> changeView())
                          ],
                        ),
                        Text("Жк семейный",style: RegularText(14, Color(0xff27AEA4)),),
                        SizedBox(height:8),
                        Text("Жк семейный",style: RegularText(14, Color(0xff27AEA4)),),
                        SizedBox(height:8),
                        Text("Жк семейный",style: RegularText(14, Color(0xff27AEA4)),),
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
                          "current ZhK",
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
