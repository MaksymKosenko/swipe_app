
import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/CustomAppBars.dart';
import 'package:swipe_app/basicThings/CustomDropDown.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'package:swipe_app/screens/LandingScreen.dart';

class ProfileScreen extends StatelessWidget {
 final dynamic _userData;

 ProfileScreen(this._userData);

  Widget build(BuildContext context) {
    bool _isImageExist = false;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyCustomAppBar(title: "Личный кабинет", height: 64, fromTextToIconWidth: 110, backScreen: MaterialPageRoute(
          builder: (context) => LandingPage()),),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 10),
              Container(height: 80, width: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(40), border: Border.all(color: Color(0xff969696))),
                  child: _isImageExist ? Text("yep") : Text("no")),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 24, child: Text("${_userData['name']} ${_userData['surName']}", style: RegularText(20, Color(0xff2E2E2E)),)),
                  SizedBox(height: 5),
                  Container(height: 17, child: Text("${_userData['email']}", style: RegularText(14, Color(0xff2E2E2E)),)),
                ],
              ),
            ]
          ),
          SizedBox(height: 40),
          CustomDropDown("Мои контакты", null),
          SizedBox(height: 20),
          CustomDropDown("Контакты агента", null),
          SizedBox(height: 20),
          CustomDropDown("Управление подпиской", null),
          SizedBox(height: 20),
          CustomDropDown("Уведомления", null),
          SizedBox(height: 35),
          Container(
            height: 34,
            child: Row(
              children: [
                SizedBox(width: 10),
                Container(height: 34, width: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Переключить звонки", style: RegularText(14, Color(0xff2E2E2E))),
                        Text("и сообщения на агента", style: RegularText(14, Color(0xff2E2E2E))),
                      ],
                    )),
                SizedBox(width: 120),
                Container(width: 45, height: 25, color: Colors.blueGrey),
              ],
            ),
          ),
          SizedBox(height: 30),
          Text("Политика конфиденциальности", style: RegularText(14, Color(0xff1CA198)))
        ],
      ),
    );
  }
}


