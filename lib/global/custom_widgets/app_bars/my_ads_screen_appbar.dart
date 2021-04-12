import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/global/user.dart';


class MyAdsAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double _height;
  final String _title;
  final MaterialPageRoute _backScreen;
  const MyAdsAppBar(this._title, this._height, this._backScreen);

  @override
  _MyAdsAppBarState createState() => _MyAdsAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(82);
}

class _MyAdsAppBarState extends State<MyAdsAppBar> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {

    final ConcreteUser _user = Provider.of<ConcreteUser>(context);
    CollectionReference _userSaves = FirebaseFirestore.instance.collection('users').doc(_user.phone)
        .collection("user_collections").doc("myAd").collection("myAds");

    Future<void> getQuantity() {
      print("getQuantity starts");
      return _userSaves
          .get()
          .then((value) { if(quantity != value.size){setState(() {
        quantity = value.size;
      });} print("length is - $quantity");} )
          .catchError((error) => print("Failed to remove Favourite: $error"));
    }

    getQuantity();

    return Container(
      height: widget._height,
      child: Column(
        children: [
          Container(height: 22, color: Colors.white,), //for ios - 44
          Container(
            height: 60,
            color: Color(0xffF5F5F5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.black),padding: EdgeInsets.symmetric(horizontal: 10),
                        onPressed: ()=> Navigator.push(context, widget._backScreen)),
                    Text(widget._title , style: RegularText(20, Color(0xff2E2E2E)),),
                    SizedBox(width: 15),
                    Text("$quantity" ,style: RegularText(20, Color(0xff9D9D9D)),)
                  ],
                ),
                TextButton(child: Padding(padding: EdgeInsets.only(right: 10),child: Text("квартиры", style: MediumText(14, Color(0xff2E2E2E)),)),
                    onPressed: ()=> null)
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(widget._height);
}