import 'package:flutter/material.dart';

class User{
  final String email;
  final String userName;
  final String userSurName;
  final String phone;
  final String photoPath;

  User({
    @required this.email,
    @required this.userName,
    @required this.userSurName,
    @required this.phone,
    this.photoPath
  });
}