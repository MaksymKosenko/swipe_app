import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_app/global/user.dart';


class AdAppBar extends StatefulWidget {
  String _addId;
  AdAppBar(this._addId);
  @override
  _AdAppBarState createState() => _AdAppBarState();
}

class _AdAppBarState extends State<AdAppBar> {

  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    final ConcreteUser _user = Provider.of<ConcreteUser>(context);
    print("appbar id - ${widget._addId}");
    CollectionReference _users = FirebaseFirestore.instance.collection('users');
    Future<void> addFavourite(String id) {
      return _users
          .doc(_user.phone)
          .collection("user_collections")
          .doc("myFavourites")
          .collection("myFavourites")
          .doc("${widget._addId}")
          .set({
        'addID': "${widget._addId}",
      })
          .then((value) => print("Favourite added"))
          .catchError((error) => print("Failed to add Favourite: $error"));
    }
    Future<void> removeFavourite(String id) {
      return _users
          .doc(_user.phone)
          .collection("user_collections")
          .doc("myFavourites")
          .collection("myFavourites")
          .doc("${widget._addId}").delete()
          .then((value) => print("Favourite removed"))
          .catchError((error) => print("Failed to remove Favourite: $error"));
    }

    void saveToFavourites(bool isFav){
      if(isFav == true){
        setState(() {
          isFavourite = isFav;
          print("isFavourite - $isFavourite");
          addFavourite(widget._addId);
        });
      }
      if(isFav == false){
        setState(() {
          isFavourite = isFav;
          print("isFavourite - $isFavourite");
          removeFavourite(widget._addId);
        });
      }
    }

    void changeStatus(){
      isFavourite = !isFavourite;
      saveToFavourites(isFavourite);
    }

    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Color(0xff27AEA4)),
      actions: [
        IconButton(icon: Icon(CupertinoIcons.check_mark_circled),
            color: isFavourite ? Color(0xff27AE60) : Color(0xff828282),
            onPressed: changeStatus),
      ],
    );
  }
}



