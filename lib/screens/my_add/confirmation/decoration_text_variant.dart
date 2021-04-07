import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/custom_button.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/add_model.dart';
import 'package:swipe_app/screens/Feed/standart_ad_card.dart';


import 'package:swipe_app/screens/my_add/confirmation/ad_decoration.dart';

class VariantsBlock extends StatefulWidget {
  final Add _add;

  VariantsBlock(this._add);
  @override
  _VariantsBlockState createState() => _VariantsBlockState();
}

class _VariantsBlockState extends State<VariantsBlock> {
  bool phrase1 = false;
  bool phrase2 = false;
  bool phrase3 = false;
  bool phrase4 = false;
  bool phrase5 = false;
  bool phrase6 = false;
  bool phrase7 = false;
  bool phrase8 = false;


  void setActivePhrase(String phrase) {
    switch (phrase) {
      case "phrase1":
        phrase1 = true;
        phrase2 = false;
        phrase3 = false;
        phrase4 = false;
        phrase5 = false;
        phrase6 = false;
        phrase7 = false;
        phrase8 = false;
        widget._add.chosenPhrase = "Подарок при покупке";
       // SAdCard(widget._concreteAd).createState();
        break;
      case "phrase2":
        phrase1 = false;
        phrase2 = true;
        phrase3 = false;
        phrase4 = false;
        phrase5 = false;
        phrase6 = false;
        phrase7 = false;
        phrase8 = false;
        widget._add.chosenPhrase = "Возможен торг";
      //  SAdCard(widget._concreteAd).createState();
        break;
      case "phrase3":
        phrase1 = false;
        phrase2 = false;
        phrase3 = true;
        phrase4 = false;
        phrase5 = false;
        phrase6 = false;
        phrase7 = false;
        phrase8 = false;
        widget._add.chosenPhrase = "Квартира у моря";
       // SAdCard(widget._concreteAd).createState();
        break;
      case "phrase4":
        phrase1 = false;
        phrase2 = false;
        phrase3 = false;
        phrase4 = true;
        phrase5 = false;
        phrase6 = false;
        phrase7 = false;
        phrase8 = false;
        widget._add.chosenPhrase = "В спальном районе";
      //  SAdCard(widget._concreteAd).createState();
        break;
      case "phrase5":
        phrase1 = false;
        phrase2 = false;
        phrase3 = false;
        phrase4 = false;
        phrase5 = true;
        phrase6 = false;
        phrase7 = false;
        phrase8 = false;
        widget._add.chosenPhrase = "Вам повезло с ценой!";
      //  SAdCard(widget._concreteAd).createState();
        break;
      case "phrase6":
        phrase1 = false;
        phrase2 = false;
        phrase3 = false;
        phrase4 = false;
        phrase5 = false;
        phrase6 = true;
        phrase7 = false;
        phrase8 = false;
        widget._add.chosenPhrase = "Для большой семьи";
      //  SAdCard(widget._concreteAd).createState();
        break;
      case "phrase7":
        phrase1 = false;
        phrase2 = false;
        phrase3 = false;
        phrase4 = false;
        phrase5 = false;
        phrase6 = false;
        phrase7 = true;
        phrase8 = false;
        widget._add.chosenPhrase = "Отдельная парковка";
      //  SAdCard(widget._concreteAd).createState();
        break;
      case "phrase8":
        phrase1 = false;
        phrase2 = false;
        phrase3 = false;
        phrase4 = false;
        phrase5 = false;
        phrase6 = false;
        phrase7 = false;
        phrase8 = true;
        widget._add.chosenPhrase = "Подарок при покупке";
      //  SAdCard(widget._concreteAd).createState();
        break;

      case "null":
        phrase1 = false;
        phrase2 = false;
        phrase3 = false;
        phrase4 = false;
        phrase5 = false;
        phrase6 = false;
        phrase7 = false;
        phrase8 = false;
        widget._add.chosenPhrase = null;
    }
   // print("$phrase1, $phrase2, $phrase3, $phrase4, $phrase5, $phrase6, $phrase7, $phrase8");
    //print("chosen phrase in Variants ${widget._concreteAd.chosenPhrase}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              setState(() {
                setActivePhrase("phrase1");
              });
            },
            child: phrase1
                ? DecorationVariant(
                    text: "Подарок при покупке", color: Color(0xff41BFB5))
                : DecorationVariant(
                    text: "Подарок при покупке", color: Color(0xffE8E8E8))),

        SizedBox(height: 10),
        GestureDetector(
            onTap: () {
              setState(() {
                setActivePhrase("phrase2");
              });
            },
            child: phrase2
                ? DecorationVariant(
                    text: "Возможен торг", color: Color(0xff41BFB5))
                : DecorationVariant(
                    text: "Возможен торг", color: Color(0xffE8E8E8))),
        SizedBox(height: 10),
        GestureDetector(
            onTap: () {
              setState(() {
                setActivePhrase("phrase3");
              });
            },
            child: phrase3
                ? DecorationVariant(
                    text: "Квартира у моря", color: Color(0xff41BFB5))
                : DecorationVariant(
                    text: "Квартира у моря", color: Color(0xffE8E8E8))),
        SizedBox(height: 10),
        GestureDetector(
            onTap: () {
              setState(() {
                setActivePhrase("phrase4");
              });
            },
            child: phrase4
                ? DecorationVariant(
                    text: "В спальном районе", color: Color(0xff41BFB5))
                : DecorationVariant(
                    text: "В спальном районе", color: Color(0xffE8E8E8))),

        SizedBox(height: 10),
        GestureDetector(
            onTap: () {
              setState(() {
                setActivePhrase("phrase5");
              });
            },
            child: phrase5
                ? DecorationVariant(
                    text: "Вам повезло с ценой!", color: Color(0xff41BFB5))
                : DecorationVariant(
                    text: "Вам повезло с ценой!", color: Color(0xffE8E8E8))),

        SizedBox(height: 10),
        GestureDetector(
            onTap: () {
              setState(() {
                setActivePhrase("phrase6");
              });
            },
            child: phrase6
                ? DecorationVariant(
                    text: "Для большой семьи", color: Color(0xff41BFB5))
                : DecorationVariant(
                    text: "Для большой семьи", color: Color(0xffE8E8E8))),

        SizedBox(height: 10),
        GestureDetector(
            onTap: () {
              setState(() {
                setActivePhrase("phrase7");
              });
            },
            child: phrase7
                ? DecorationVariant(
                    text: "Семейное гнездышко", color: Color(0xff41BFB5))
                : DecorationVariant(
                    text: "Семейное гнездышко", color: Color(0xffE8E8E8))),

        SizedBox(height: 10),
        GestureDetector(
            onTap: () {
              setState(() {
                setActivePhrase("phrase8");
              });
            },
            child: phrase8
                ? DecorationVariant(
                    text: "Отдельная парковка", color: Color(0xff41BFB5))
                : DecorationVariant(
                    text: "Отдельная парковка", color: Color(0xffE8E8E8))),
      ],
    );
  }

}

class AddPhrase extends StatefulWidget {
  final Add _add;
  dynamic _confirmADState;
  AddPhrase(this._add, this._confirmADState);
  @override
  _AddPhraseState createState() => _AddPhraseState();
}

class _AddPhraseState extends State<AddPhrase> {
  bool activeOption1 = false;
  changeView(){
    setState(() {
      if (widget._add.chosenPhrase == null){
        activeOption1 = false;
        widget._confirmADState.setState((){
          print("state updated to false");
        });
      }
      else{
        activeOption1 = true;
        widget._confirmADState.setState((){
          print("state updated to true");
        });
        //widget.createState();
      }
      //print("activeOption1 $activeOption1");
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if(activeOption1 == false){
            widget._add.chosenPhrase = null;
            showPhrases();
          }
          if(activeOption1 == true)
            setState(() {
              activeOption1 = false;
              widget._add.chosenPhrase = null;
              widget._confirmADState.setState((){});
            });

         // widget._concreteAd.setNullPhrases();
          //showPhrases();

        },
        child: Row(
          children: [
            Container(
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                color: activeOption1
                    ? Color(0xff41BFB5)
                    : Color(0xffE8E8E8),
                borderRadius: BorderRadius.circular(7.5),
              ),
            ),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Добавить фразу",
                  style: MediumText(14, Color(0xff374252)),
                ),
                SizedBox(height: 5),
                Text(
                  "199₴/мес",
                  style: MediumText(14, Color(0xff8F969F)),
                ),
              ],
            ),
          ],
        ));
  }
  Future<void> showPhrases() {
    return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return Dialog(
            insetPadding:
            EdgeInsets.only(left: 10, right: 10, top: 56, bottom: 36),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            //elevation: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 28,
                      height: 20,
                    ),
                    Text(
                      "Выбор фразы",
                      style: MediumText(16, Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      icon: Icon(CupertinoIcons.clear_thick),
                      iconSize: 20,
                      onPressed: (){widget._add.chosenPhrase = null;//SAdCard(widget._concreteAd).createState();
                      SAdCard(widget._add).createState();
                     // SAdCard(widget._concreteAd).createState();
                        changeView(); Navigator.of(context).pop();} ,
                    ),
                  ],
                ),
                // SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: GestureDetector(
                      child: VariantsBlock(widget._add)),
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: CustomButton(330, 45, 10, Color(0xff56C486), Color(0xff42C0B5),
                        Alignment.centerLeft, Alignment.centerRight, "Подтвердить", SemiBoldText(14, Colors.white), Colors.transparent),
                  ),
                  onTap: () {
                    changeView();
                    SAdCard(widget._add).createState();
                    Navigator.of(context).pop();
                    //SAdCard(widget._concreteAd).createState();
                  },
                )
              ],
            ),
          );
        });
  }
}
