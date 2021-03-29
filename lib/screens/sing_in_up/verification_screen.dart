import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/logo.dart';
import 'package:swipe_app/global/custom_widgets/otp.dart';
import 'package:swipe_app/global/style/gradients.dart';
import 'package:swipe_app/global/user.dart';
import 'package:swipe_app/screens/Feed/landing_page.dart';
import 'package:swipe_app/services/auth.dart';

class VerificationScreen extends StatefulWidget {

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  String _verificationCode;


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: GradientBack(),
        child: Column(
          children: [
            SizedBox(height: 166),
            Logo(41.62, 62, 42, 15),
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
             child: OTPField(
               length: 6,
               width: 264.0,
               fieldWidth: 35.0,
               style: TextStyle(
                 fontSize: 40.0,
                 color: Colors.white,
               ),
               textFieldAlignment: MainAxisAlignment.spaceAround,
               fieldStyle: FieldStyle.underline,
               keyboardType: TextInputType.number,
               onCompleted: (smsCode) {codeCompare(smsCode);_verificationCode = smsCode;},
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
                  codeCompare(_verificationCode);
                  },

            ),
          ],
        ),
      ),
    );
  }


  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future codeCompare(String smsCode) async{
    try {
      await _firebaseAuth.signInWithCredential(PhoneAuthProvider.credential(
          verificationId: currentCode,
          smsCode: smsCode))
          .then((value) async{
        if(value.user!=null){
         // print(value.user.uid);
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => LandingPage()));
          return ConcreteUser.fromFirebase(value.user);
        }
      });
    }catch (e){
      print("We got some troubles!");
      print(e);
        return showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Registration error'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      Text("Не верный код"),
                    ],
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text('Ок'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            }
        );
    }
  }
}