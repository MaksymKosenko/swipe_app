import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/global/user.dart';


class MyAdAppBar extends StatefulWidget {
  String _addId;
  MaterialPageRoute _previousScreen;
  MyAdAppBar(this._addId, this._previousScreen);
  @override
  _MyAdAppBarState createState() => _MyAdAppBarState();
}

class _MyAdAppBarState extends State<MyAdAppBar> {
  int watches = 0;
  int saves = 0;
  bool isFavourite = false;
  @override
  Widget build(BuildContext context){
    final ConcreteUser _user = Provider.of<ConcreteUser>(context);
    CollectionReference _userSaves = FirebaseFirestore.instance.collection('users').doc(_user.phone)
        .collection("user_collections").doc("myAd").collection("myAds");
//TODO - брать простомтры и сохранения из бд, после того как они там появятся)
/*
    Future<void> getQuantity() {
      print("getQuantity starts");
      return _userSaves
          .get()
          .then((value) { if(quantity != value.size){setState(() {
        quantity = value.size;
      });} print("length is - $quantity");} )
          .catchError((error) => print("Failed to remove Favourite: $error"));
    }*/

    //getQuantity();


    return AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_back,color: Color(0xff9E9E9E),),
          onPressed: ()=> Navigator.push(context, widget._previousScreen)),
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Color(0xff27AEA4)),
      actions: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.remove_red_eye_outlined, color: Color(0xff828282)),
            SizedBox(width: 5),
            Text("$watches", style: RegularText(18 , Color(0xff828282)),),
            SizedBox(width: 20),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.check_mark_circled, color: Color(0xff828282)),
            SizedBox(width: 5),
            Text("$saves", style: RegularText(18 , Color(0xff828282)),),
            SizedBox(width: 20),
          ],
        ),

      ],
    );
  }
}