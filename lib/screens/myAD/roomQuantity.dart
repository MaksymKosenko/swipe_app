import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/basic.dart';

class RoomQuantity extends StatefulWidget {
  @override
  _RoomQuantityState createState() => _RoomQuantityState();
}

class _RoomQuantityState extends State<RoomQuantity> {
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
            Text("Количество комнат",
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
                        "1 комнатная",
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
                  Container(
                    padding: EdgeInsets.only(right: 15, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "2 комнатная",
                          style: RegularText(14, Color(0xff737373)),
                        ),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.circular(7.5),
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.only(right: 15, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "3 комнатная",
                          style: RegularText(14, Color(0xff737373)),
                        ),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.circular(7.5),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.only(right: 15, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "4 комнатная",
                          style: RegularText(14, Color(0xff737373)),
                        ),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.circular(7.5),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.only(right: 15, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "5+ комнатная",
                          style: RegularText(14, Color(0xff737373)),
                        ),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                            color: Color(0xffE8E8E8),
                            borderRadius: BorderRadius.circular(7.5),
                          ),
                        )
                      ],
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
          Text("Количество комнат ",
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
                    "1 комнатная",
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
