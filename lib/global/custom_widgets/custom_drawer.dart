import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/custom_button.dart';
import 'package:swipe_app/global/custom_widgets/logo.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/screens/chat_screens/user_to_support.dart';
import 'package:swipe_app/screens/favourites/favourites_screen.dart';
import 'package:swipe_app/screens/feed/landing_page.dart';
import 'package:swipe_app/screens/maps/mfc_screen.dart';
import 'package:swipe_app/screens/my_add/whole_ad_container.dart';
import 'package:swipe_app/screens/notary/notary_page.dart';
import 'package:swipe_app/screens/profile/profile_screen.dart';

Widget CustomDrawer(context, _userData){


  bool _isImageExist;
  if(_userData['profilePic'] == "null")
    _isImageExist = false;
  else  _isImageExist = true;
  return Container(
    width: 280,
    height: 1000,//812,
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
                    builder: (context) => ProfileScreen(_userData))))
          ],
        ),
        SizedBox(height: 20),
        Container(height: 80, width: 80,
          alignment: Alignment.center,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),
            image: _isImageExist
                ?DecorationImage(image:NetworkImage(_userData['profilePic']), fit: BoxFit.fill)
                :null,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff56C385), Color(0xff41BFB5)],
            ),),
          child: _isImageExist
              ? null//Image.network(_userData['profilePic'], fit: BoxFit.cover,)
              : Text("${_userData['name'][0]}${_userData['surName'][0]}", style: SemiBoldText(30, Colors.white),),
        ),
        SizedBox(height: 16),
        Container(height: 24, child: Text("${_userData['name']} ${_userData['surName']}", style: SemiBoldText(20, Colors.white),)),
        SizedBox(height: 5),
        Container(height: 17, child: Text("${_userData['email']}", style: RegularText(14, Colors.white60),)),
        SizedBox(height: 40),
        Container(height: 62, width: 190, child: CustomButton(190, 62, 35, Colors.transparent, Colors.transparent, Alignment.center, Alignment.center, "Получить доступ", MediumText(16, Colors.white), Colors.white54)),
        SizedBox(height: 40),
        Container(height: 300, width: 218,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>LandingPage())),
                  child: Container(height: 20, child: Text("Лента объявлений",style: MediumText(16, Colors.white),),)),
              SizedBox(height: 20),
              GestureDetector(
                  child: Container(height: 20, child: Text("Личный кабинет",style: MediumText(16, Colors.white),),),
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(
                      builder: (context) => ProfileScreen(_userData)))),
              SizedBox(height: 20),
              GestureDetector(child: Container(height: 20, child: Text("Мое объявление",style: MediumText(16, Colors.white),),),
                onTap:()=>Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MyNewAD()))),
              SizedBox(height: 20),
              GestureDetector(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>FavouriteScreen(_userData['phone']))),
                  child: Container(height: 20, child: Text("Избранные",style: MediumText(16, Colors.white),),)),
              SizedBox(height: 20),
              Container(height: 20, child: Text("Сохраненные фильтры",style: MediumText(16, Colors.white),),),
              SizedBox(height: 20),
              GestureDetector(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>NotaryScreen())),
                  child: Container(height: 20, child: Text("Нотариусы",style: MediumText(16, Colors.white),),)),
              SizedBox(height: 20),
              GestureDetector(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>MfcMapScreen())),
                  child: Container(height: 20, child: Text("МФЦ",style: MediumText(16, Colors.white),),)),
              SizedBox(height: 20),
              GestureDetector(
                  onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>UserToSupportChat())),
                  child: Container(height: 20, child: Text("Обратная связь",style: MediumText(16, Colors.white),),)),
            ],
          ),
        ),
      ],
    ),
  );
}
