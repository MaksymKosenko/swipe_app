import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/basicThings/basic.dart';
import 'file:///C:/flutter_projects/flutterlearning/flutter_Dart_courses/swipe_app/lib/screens/singInUp/verificationScreen.dart';
import 'package:swipe_app/services/auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _phoneController = TextEditingController();
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: GradientBack(),
        child: Column(
          children: [
            SizedBox(height: 166),
            Logo(41.62, 62, 42, 15),
            //Image.asset('lib/assets/images/Group1.png', width: 220, height: 53),
            SizedBox(height: 72),
            input(253, 44, _phoneController, false, TextInputType.phone,
            RegularText(16, Colors.white), RegularText(16, Colors.white), "Телефон", Color(0xff56C385)),
            //_input("Телефон", _phoneController, false),
            SizedBox(height: 25),
            GestureDetector(
              onTap: (){
                var _phoneToCheck = _phoneController.text;
                _authService.isExist(_phoneToCheck, context);
                //isExist(_phoneToCheck);
                //checkPhone(_phoneToCheck);
                  //_authService.checkPhone(_phoneToCheck);
                  //Navigator.push(context, MaterialPageRoute(
                    //   builder: (context) => VerificationScreen(_phoneController.text, null, _authService)));
                },
              child:CustomButton(253, 50, 10, Color(0xff56C385), Color(0xff41BFB5),Alignment.topCenter,
                  Alignment.bottomCenter, "Далее", SemiBoldText(16, Colors.white), Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }

/*  Future <void> showError(String errorText) async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(errorText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Try again'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference _users = FirebaseFirestore.instance.collection('users');

  isExist(String phone){
    return _users.doc(phone).get()
        .then((value){
      //print(value.exists);
      if(value.exists == true){
        checkPhone(phone);
      }
      if(value.exists == false){
        print("user not exist, create it");
        showError("user not created");
      }
    })
        .catchError((error) => print("Failed to check: $error"));
  }

  Future checkPhone(String phone) async {
    await _firebaseAuth.verifyPhoneNumber(
      forceResendingToken: 3,
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async{
        print("verification complete called ");
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          showError("nuber is not valid");
        }
      },
      codeSent: (String verificationId, int resendToken) async{
        currentCode = verificationId;
        Navigator.push(context, MaterialPageRoute(
               builder: (context) => VerificationScreen(phone, null, _authService)));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        currentCode = verificationId;
      },
    );
  }*/
}
