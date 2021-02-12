import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/User.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'package:swipe_app/main.dart';
import 'package:swipe_app/screens/mapScreen.dart';
import 'package:swipe_app/screens/registrationScreen.dart';
import 'package:swipe_app/services/auth.dart';

class VerificationScreen extends StatefulWidget {
  final String _phone;
  final AuthService _authService;
  VerificationScreen(this._phone, this._authService);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController _letter1Controller = TextEditingController();
  TextEditingController _letter2Controller = TextEditingController();
  TextEditingController _letter3Controller = TextEditingController();
  TextEditingController _letter4Controller = TextEditingController();
  TextEditingController _letter5Controller = TextEditingController();
  TextEditingController _letter6Controller = TextEditingController();
  String _verificationCode;
  AuthService _authService = AuthService();


  @override
  Widget build(BuildContext context) {
    _authService.checkPhone(widget._phone);
    return Material(
      child: Container(
        decoration: GradientBack(),
        child: Column(
          children: [
            SizedBox(height: 166),
            Logo(41.62, 62, 42, 15),
            //Image.asset('lib/assets/images/Group1.png', width: 220, height: 53),
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 55),
              child: Column(
                children: [
                  Text("Введите код который мы", textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Colors.white)),
                  Text("отправили на указаный", textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Colors.white)),
                  Text("вами номер телефона", textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Colors.white)),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 51,
              width: 264,
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 39,
                        height: 49,
                        //color: Colors.red,
                        child: _input("", _letter1Controller, false),
                      ),
                      SizedBox(width: 6),
                      Container(
                        width: 39,
                        height: 49,
                        //color: Colors.red,
                        child: _input("", _letter2Controller, false),
                      ),

                      SizedBox(width: 6),

                      Container(
                        width: 39,
                        height: 49,
                        //color: Colors.red,
                        child: _input("", _letter3Controller, false),
                      ),
                      SizedBox(width: 6),
                      Container(
                        width: 39,
                        height: 49,
                        //color: Colors.red,
                        child: _input("", _letter4Controller, false),
                      ),
                      SizedBox(width: 6),
                      Container(
                        width: 39,
                        height: 49,
                        //color: Colors.red,
                        child: _input("", _letter5Controller, false),
                      ),
                      SizedBox(width: 6),
                      Container(
                        width: 39,
                        height: 49,
                        //color: Colors.red,
                        child: _input("", _letter6Controller, false),
                      ),
                    ],
                  ),
                  Row(
                    //mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(width: 39, height: 2, color: Colors.white,),
                      SizedBox(width: 6),
                      Container(width: 39, height: 2, color: Colors.white,),
                      SizedBox(width: 6),
                      Container(width: 39, height: 2, color: Colors.white,),
                      SizedBox(width: 6),
                      Container(width: 39, height: 2, color: Colors.white,),
                      SizedBox(width: 6),
                      Container(width: 39, height: 2, color: Colors.white,),
                      SizedBox(width: 6),
                      Container(width: 39, height: 2, color: Colors.white,),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            GestureDetector(
                child: Container(
                  height: 50,
                  width: 253,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xff56C385), Color(0xff41BFB5)],
                    ),
                  ),
                  child: Text("Войти",
                      style: TextStyle(fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16)),
                ),
                onTap: () {
                  _verificationCode = _letter1Controller.text + _letter2Controller.text + _letter3Controller.text +
                      _letter4Controller.text + _letter5Controller.text + _letter6Controller.text;

                  _authService.codeCompare(_verificationCode);

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => MapPage()));
                  },

            ),
          ],
        ),
      ),
    );
  }


  Widget _input(String hint, TextEditingController controller, bool obscure) {
    return Container(
      height: 49,
      width: 29,
      alignment: Alignment.center,
      child: TextField(
        controller: controller,
        obscureText: obscure,
        keyboardType: TextInputType.number,
        style: TextStyle(
            fontFamily: 'Montserrat', color: Colors.white, fontSize: 40.6),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 5),
          isCollapsed: true,
          hintStyle: TextStyle(
              fontFamily: 'Montserrat', color: Colors.white, fontSize: 40.6),
        ),
      ),
    );
  }
}