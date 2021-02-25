import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/services/auth.dart';
import 'package:swipe_app/User.dart';
import 'package:swipe_app/screens/verificationScreen.dart';

class UserActions {
  final String _name;
  final String _surName;
  final String _email;
  final String _phone;
  final BuildContext context;
  UserActions(this._name, this._surName, this._email, this._phone, this.context);

  String status;
  CollectionReference _users = FirebaseFirestore.instance.collection('users');

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> addUser() {
        return _users
        .doc(_phone)
        .set({
          'name': _name,
          'surName': _surName,
          'email': _email,
          'phone': _phone,
          'profilePic': "null",
        })
        .then((value) => print("user added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
  Future<void> addAgentData() {
    return _users
        .doc(_phone)
        .collection("user_collections")
        .doc("Agent")
        .set({
          'agentName': "null",
          'agentSurName': "null",
          'agentEmail': "null",
          'agentPhone': "null",
        })
        .then((value) => print("Agent added"))
        .catchError((error) => print("Failed to add Agent: $error"));
  }
  Future<void> addSubscribeData() {
    return _users
        .doc(_phone)
        .collection("user_collections")
        .doc("Subscribe").set({
      'startData': "null",
      'endData': "null",
      'status': false,
      'autoSubscribe': false,
    })
        .then((value) => print("Subscribe added"))
        .catchError((error) => print("Failed to add Subscribe: $error"));
  }
  Future<void> addNotificationsData() {
    return _users
        .doc(_phone)
        .collection("user_collections")
        .doc("Notifications").set({
      'disable': false,
      'toAgent': false,
      'toEach': true,
      'toUser': false,
    })
        .then((value) => print("Notifications added"))
        .catchError((error) => print("Failed to add Notifications: $error"));
  }
  isExist(){
    return _users.doc(_phone).get()
        .then((value){
        print(value.exists);
        if(value.exists == true){
          print("user already exist");
          showError("user already exist", context);
        }
        if(value.exists == false){
          verifyPhone();
        }
    })
        .catchError((error) => print("Failed to check: $error"));
  }


  Future verifyPhone() async{
    await _firebaseAuth.verifyPhoneNumber(
      forceResendingToken: 3,
      phoneNumber: _phone,
      verificationCompleted: (PhoneAuthCredential credential) async{
        print("verification complete called ");
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          showError("invalid phone number", context);
        }
      },
      codeSent: (String verificationId, int resendToken) async{
        currentCode = verificationId;
        addUser();
        addAgentData();
        addNotificationsData();
        addSubscribeData();
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => VerificationScreen(_phone)));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        currentCode = verificationId;
      },
    );
  }

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
