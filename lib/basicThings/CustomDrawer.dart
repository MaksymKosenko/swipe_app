import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'package:swipe_app/screens/ProfileScreen.dart';

// ignore: non_constant_identifier_names
Widget CustomDrawer(context, _userData, ){
  bool _isImageExist;
  if(_userData['profilePic'] == "null")
    _isImageExist = false;
  else  _isImageExist = true;
  return Container(
    width: 280,
    height: 812,
    padding: EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xff0A3137), Color(0xff094A46)],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 60),
        Row(
          children: [
            //SizedBox(width: 20),
            Logo(23, 34, 23, 8),
            SizedBox(width: 70),
            IconButton(icon: Icon(Icons.settings_outlined, color: Colors.white, size: 30),
                onPressed: ()=> Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ProfileScreen())))
          ],
        ),
        SizedBox(height: 20),
        Container(height: 80, width: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff56C385), Color(0xff41BFB5)],
            ),),
          child: _isImageExist
              ? Text("pic")//TODO Когда сделаю возможным добавить фотку(загрузить в обл хранилище), поменять текст на имедж.фромнетворк
              : Text("${_userData['name'][0]}${_userData['surName'][0]}", style: SemiBoldText(30),),
        ),
        SizedBox(height: 16),
        Container(height: 24, child: Text("${_userData['name']} ${_userData['surName']}", style: SemiBoldText(20),)),
        SizedBox(height: 5),
        Container(height: 17, child: Text("${_userData['email']}", style: RegularText(14, Colors.white60),)),
        SizedBox(height: 40),
        Container(height: 62, width: 190, child: CustomButton(190, 62, 35, Colors.transparent, Colors.transparent, Alignment.center, Alignment.center, "Получить доступ", MediumText(16, Colors.white), Colors.white54)),
        SizedBox(height: 40),
        Container(height: 300, width: 218,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(height: 20, child: Text("Лента объявлений",style: MediumText(16, Colors.white),),),
              SizedBox(height: 20),
              GestureDetector(
                  child: Container(height: 20, child: Text("Личный кабинет",style: MediumText(16, Colors.white),),),
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfileScreen()))),
              SizedBox(height: 20),
              Container(height: 20, child: Text("Мое объявление",style: MediumText(16, Colors.white),),),
              SizedBox(height: 20),
              Container(height: 20, child: Text("Избранные",style: MediumText(16, Colors.white),),),
              SizedBox(height: 20),
              Container(height: 20, child: Text("Сохраненные фильтры",style: MediumText(16, Colors.white),),),
              SizedBox(height: 20),
              Container(height: 20, child: Text("Нотариусы",style: MediumText(16, Colors.white),),),
              SizedBox(height: 20),
              Container(height: 20, child: Text("МФЦ",style: MediumText(16, Colors.white),),),
              SizedBox(height: 20),
              Container(height: 20, child: Text("Обратная связь",style: MediumText(16, Colors.white),),),
            ],
          ),
        ),
      ],
    ),
  );
}
