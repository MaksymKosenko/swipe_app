import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/screens/registrationScreen.dart';
import 'package:swipe_app/services/auth.dart';
import 'package:swipe_app/User.dart';

class UserActions {
  final String _name;
  final String _surName;
  final String _email;
  final String _phone;
  UserActions(this._name, this._surName, this._email, this._phone);

  String status;
  CollectionReference _users = FirebaseFirestore.instance.collection('users');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> addUser() {
    //var answer = _users.doc(_phone).get();
        return _users
        .doc(_phone)
        .set({
          'name': _name,
          'surName': _surName,
          'email': _email,
          'phone': _phone,
        })
        .then((value) => print("user added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  isExist(){
    return _users.doc(_phone).get()
        .then((value){
        print(value.exists);
        if(value.exists == true){
          print("user already exist");
         
        }
        if(value.exists == false){
          verifyPhone();
         // if(verifyPhone())
          
          //addUser();
        }
    })
        .catchError((error) => print("Failed to check: $error"));
  }



  Future verifyPhone() async{
    bool result;
    await _firebaseAuth.verifyPhoneNumber(
      //forceResendingToken: 3,
      phoneNumber: _phone,
      verificationCompleted: (PhoneAuthCredential credential) async{
        print("verification complete called ");
        await _firebaseAuth.signInWithCredential(credential).whenComplete(() => result = true);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          result = false;
        }
      },
      codeSent: (String verificationId, int resendToken) async{
        currentCode = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        currentCode = verificationId;
      },
    );
    if(result == true)
      addUser();
  }

  Future codeCompare(String smsCode) async{
    try {
      await _firebaseAuth.signInWithCredential(PhoneAuthProvider.credential(
          verificationId: currentCode,
          smsCode: smsCode))
          .then((value) async{
        if(value.user!=null){
          //TODO:СДЕЛАТЬ ТУТ ПРОВЕРКУ, СТРОЧАКУ НИЖЕ УДАЛИТЬ НАХУЙ
          //addUser();
          print(value.user.uid);
          return ConcreteUser.fromFirebase(value.user);
        }
      });
    }catch (e){
      print("We got some troubles!");
      print(e);
    }
  }
}
