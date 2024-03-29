import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/user.dart';
import 'package:swipe_app/screens/sing_in_up/verification_screen.dart';
import 'package:swipe_app/services/auth.dart';


class UserActions {
  final String _name;
  final String _surName;
  final String _email;
  final String _phone;
  final BuildContext _context;
  UserActions(this._name, this._surName, this._email, this._phone, this._context);

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
          showError("user already exist", _context);
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
        print(credential.smsCode);
        print(credential.verificationId);
        print(credential.token);
        print(credential.providerId);
        print(credential..signInMethod);
        await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
          showError("invalid phone number", _context);
        }
      },
      codeSent: (String verificationId, int resendToken) async{
        currentCode = verificationId;
        //currentCode = currentCode;
        addUser();
        addAgentData();
        addNotificationsData();
        addSubscribeData();
        Navigator.push(_context, MaterialPageRoute(
            builder: (context) => VerificationScreen(verificationId)));
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
