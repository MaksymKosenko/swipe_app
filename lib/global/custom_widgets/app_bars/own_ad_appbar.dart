import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/global/user.dart';


class MyAdAppBar extends StatefulWidget {
  String _addId;
  MaterialPageRoute _previousScreen;
  MyAdAppBar(this._addId, this._previousScreen);
  @override
  _MyAdAppBarState createState() => _MyAdAppBarState();
}

class _MyAdAppBarState extends State<MyAdAppBar> {

  bool isFavourite = false;
  @override
  Widget build(BuildContext context){
    return AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_back,color: Color(0xff9E9E9E),),
          onPressed: ()=> Navigator.push(context, widget._previousScreen)),
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Color(0xff27AEA4)),
      actions: [
        IconButton(icon: Icon(CupertinoIcons.check_mark_circled),
            color: isFavourite ? Color(0xff27AE60) : Color(0xff828282),
            onPressed: null),
      ],
    );
  }
}