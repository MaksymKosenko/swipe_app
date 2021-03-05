import 'package:flutter/material.dart';
import 'package:swipe_app/screens/myAD/confirmation/DecorationVariants.dart';

class VariantsBlock extends StatefulWidget {
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
        break;
    }
    print(
        "$phrase1, $phrase2, $phrase3, $phrase4, $phrase5, $phrase6, $phrase7, $phrase8");
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
        //TODO попробовать это
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
