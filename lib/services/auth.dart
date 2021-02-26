import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'file:///C:/flutter_projects/flutterlearning/flutter_Dart_courses/swipe_app/lib/basicThings/User.dart';
import 'file:///C:/flutter_projects/flutterlearning/flutter_Dart_courses/swipe_app/lib/screens/singInUp/verificationScreen.dart';

String currentCode;


class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CollectionReference _users = FirebaseFirestore.instance.collection('users');

  isExist(String phone, context){
    return _users.doc(phone).get()
        .then((value){
      //print(value.exists);
      if(value.exists == true){
        checkPhone(phone, context);
      }
      if(value.exists == false){
        print("user not exist, create it");
        showError("user not created", context);
      }
    })
        .catchError((error) => print("Failed to check: $error"));
  }

  Future checkPhone(String phone, context) async {
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
          showError("nuber is not valid", context);
        }
      },
      codeSent: (String verificationId, int resendToken) async{
        currentCode = verificationId;
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => VerificationScreen(phone)));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        currentCode = verificationId;
      },
    );
  }
/*
  Future codeCompare(String smsCode) async{
    try {
      await _firebaseAuth.signInWithCredential(PhoneAuthProvider.credential(
          verificationId: currentCode,
          smsCode: smsCode))
          .then((value) async{
        if(value.user!=null){
          print(value.user.uid);
          return ConcreteUser.fromFirebase(value.user);
        }
      });
    }catch (e){
      print("We got some troubles!");
      print(e);
    }
  }
*/

  Stream<ConcreteUser> get currentUser{
    return _firebaseAuth.authStateChanges()
        .map((User user) => user !=null ? ConcreteUser.fromFirebase(user) :null);
  }

  Future <void> showError(String errorText, context) async{
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

}
