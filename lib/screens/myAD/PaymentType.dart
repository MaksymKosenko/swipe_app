import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/AdDataKeeper.dart';
import 'package:swipe_app/basicThings/basic.dart';

class PaymentType extends StatefulWidget {
  final ConcreteAd _concreteAd;
  PaymentType(this._concreteAd);
  @override
  _PaymentTypeState createState() => _PaymentTypeState();
}

class _PaymentTypeState extends State<PaymentType> {
  bool _isExpand = false;

  void changeView() {
    setState(() {
      _isExpand = !_isExpand;
    });
  }

  String selectedVar = "Наличными из рук в руки";
  bool active1 = true;
  bool active2 = false;
  bool active3 = false;
  bool active4 = false;

  setNewChoise(String newSelected) {
    setState(() {
      selectedVar = newSelected;
      widget._concreteAd.setPaymentType(selectedVar);
      switch (newSelected) {
        case "Наличными из рук в руки":
          active1 = true;
          active2 = false;
          active3 = false;
          active4 = false;
          break;
        case "Наличными, черезбанковскою ячейку":
          active1 = false;
          active2 = true;
          active3 = false;
          active4 = false;
          break;
        case "Безналичным путем, через аккредитив":
          active1 = false;
          active2 = false;
          active3 = true;
          active4 = false;
          break;
        case "Перевод на банковскую карту":
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
    widget._concreteAd.setPaymentType(selectedVar);
    return _isExpand
        ? Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Варианты расчета",
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
                    onTap: ()=> setNewChoise("Наличными из рук в руки"),
                    child: Container(
                      padding: EdgeInsets.only(right: 15, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Наличными из рук в руки",
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
                onTap: ()=> setNewChoise("Наличными, черезбанковскою ячейку"),
                child:
                  Container(
                    padding: EdgeInsets.only(right: 15, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Наличными, черезбанковскою ячейку",
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
                  ),),
                  SizedBox(height: 13),
              GestureDetector(
                onTap: ()=> setNewChoise("Безналичным путем, через аккредитив"),
                child:
                  Container(
                    padding: EdgeInsets.only(right: 15, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Безналичным путем, через аккредитив",
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
                  ),),
                  SizedBox(height: 13),
              GestureDetector(
                onTap: ()=> setNewChoise("Перевод на банковскую карту"),
                child:
                  Container(
                    padding: EdgeInsets.only(right: 15, top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Перевод на банковскую карту",
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
                  ),),
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
          Text("Варианты расчета",
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
