import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/custom_button.dart';
import 'package:swipe_app/global/style/text_styles.dart';

class ReportAdd extends StatefulWidget {
  final String _name;
  final String _authorID;
  final String _reporterID;
  final String _addID;
  ReportAdd(this._name, this._addID, this._authorID, this._reporterID);
  @override
  _ReportAddState createState() => _ReportAddState();
}

class _ReportAddState extends State<ReportAdd> {
  bool isActive1 = false;
  bool isActive2 = false;
  bool isActive3 = false;
  bool isActive4 = true;

  String _reason = "Неактуальное объявление";
  void changeView(String option){
   setState(() {
     switch(option){
       case "1" : isActive1 = true;isActive2 = false;isActive3 = false;isActive4 = false;_reason = "Некорректная цена";break;
       case "2" : isActive1 = false;isActive2 = true;isActive3 = false;isActive4 = false;_reason = "Некорректное фото";break;
       case "3" : isActive1 = false;isActive2 = false;isActive3 = true;isActive4 = false;_reason = "Некорректное описание";break;
       case "4" : isActive1 = false;isActive2 = false;isActive3 = false;isActive4 = true;_reason = "Неактуальное объявление";break;
     }
   });
  }

  Future<void> sendReport(){
    CollectionReference _reports = FirebaseFirestore.instance.collection('reports');
    return _reports
        .doc()
        .set({
      'add': widget._addID,
      'author': widget._authorID,
      'reporter': widget._reporterID,
      'reason': _reason,
    })
        .then((value) => print("report added"))
        .catchError((error) => print("Failed to add report: $error"));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 405,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),color: Colors.white,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
              child: IconButton(icon: Icon(CupertinoIcons.clear,color: Color(0xffBCBCBC),), onPressed: () => Navigator.pop(context))),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 13),
                child: Align(
                    child: Text(widget._name,style: MediumText(16, Color(0xff2E2E2E)),)),
              ),
              SizedBox(height: 40),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: ()=> changeView("1"),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 44,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xffF8F8F8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text("Некорректная цена",style: RegularText(14, Color(0xff737373))),
                        Container(
                          height: 15, width: 15,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.5),
                              color: isActive1 ? Color(0xff41BFB5) :Color(0xffE8E8E8)),
                        )
                      ],),
                    ),
                  )),
              SizedBox(height: 10),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: ()=> changeView("2"),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 44,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xffF8F8F8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Некорректное фото",style: RegularText(14, Color(0xff737373))),
                          Container(
                            height: 15, width: 15,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.5),
                                color: isActive2 ? Color(0xff41BFB5) :Color(0xffE8E8E8)),
                          )
                        ],),
                    ),
                  )),
              SizedBox(height: 10),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: ()=> changeView("3"),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 44,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xffF8F8F8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Некорректное описание",style: RegularText(14, Color(0xff737373))),
                          Container(
                            height: 15, width: 15,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.5),
                                color: isActive3 ? Color(0xff41BFB5) :Color(0xffE8E8E8)),
                          )
                        ],),
                    ),
                  )),
              SizedBox(height: 10),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                    onTap: ()=> changeView("4"),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      height: 44,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Color(0xffF8F8F8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Неактуальное объявление",style: RegularText(14, Color(0xff737373))),
                          Container(
                            height: 15, width: 15,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(7.5),
                                color: isActive4 ? Color(0xff41BFB5) :Color(0xffE8E8E8)),
                          )
                        ],),
                    ),
                  )),
              SizedBox(height: 60),
              GestureDetector(
                onTap: (){Navigator.pop(context); sendReport();},
                child: CustomButton(330, 45, 10, Color(0xff56C486), Color(0xff42C0B5),
                    Alignment.centerLeft, Alignment.centerRight, "Подтвердить", SemiBoldText(14, Colors.white), Colors.transparent),
              )
            ],
          ),
        ]
      ),
    );
  }
}
