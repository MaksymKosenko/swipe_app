import 'package:firebase_auth/firebase_auth.dart';

class ConcreteUser{
  String _id;
  String _phone;
  ConcreteUser.fromFirebase(User user){
    _id = user.uid;
    _phone = user.phoneNumber;
  }
}

