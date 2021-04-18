import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/favourites_appbar.dart';
import 'package:swipe_app/models/repository/api_add.dart';
import 'package:swipe_app/screens/add_cards/full_ad_card.dart';
import 'package:swipe_app/screens/add_cards/preview_ad_card.dart';
import 'package:swipe_app/screens/add_cards/standart_ad_card.dart';
import 'package:swipe_app/screens/feed/landing_page.dart';

class FavouriteScreen extends StatefulWidget {
  final String _phone;

  FavouriteScreen(this._phone);

  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  int quantity = 0;
  List _id = [];
  @override
  Widget build(BuildContext context) {
    CollectionReference _userSaves = FirebaseFirestore.instance.collection('users').doc(widget._phone).collection("user_collections").doc("myFavourites")
     .collection("myFavourites");
    Future<void> getQuantity() {
      print("getQuantity starts");
      return _userSaves
          .get()
          .then((value) { if(quantity != value.size){setState(() {
            value.docs.forEach((element) {_id.add(element.id);});
        quantity = value.size;
      });} print("length is - $quantity");} )
          .catchError((error) => print("Failed to get Favourite: $error"));
    }

    getQuantity();
    
    print("phone is - ${widget._phone}");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyFavouritesAppBar(
        "Избранное",
        82,
        MaterialPageRoute(builder: (context) => LandingPage()),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: StreamBuilder(
          stream:  FirebaseFirestore.instance.collection('ads').snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            var data;
            var list1 = [];
            var list2 = [];
            if (snapshot.hasError) {
              return Container();
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container();
            }
            if (snapshot.connectionState == ConnectionState.active) {
              data = snapshot.data;
              list1.addAll(data.docs);
            }
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: StaggeredGridView.countBuilder(
                crossAxisCount: 4,
                itemCount: _id.length,
                itemBuilder: (context, index) {
                  list1.forEach((element) {if(element.id == _id[index]) list2.add(element);});
                   print("list2 - $list2");
                    return GestureDetector(
                        onLongPress: () => showPreview(list2[index], _id[index], context),//data[index], list[index].id, context),
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => FullAdCard(ApiAdd.fromApi(list2[index]), _id[index], _id))),
                        child: Container(
                            alignment: Alignment.center, color: Colors.white, child: SAdCard.fromApi(ApiAdd.fromApi(list2[index]), _id)));
                },
                staggeredTileBuilder: (index) => StaggeredTile.count(2, 2.35),
                crossAxisSpacing: 15.0,
                mainAxisSpacing: 20.0,
              ),
            );
          },
        ),
      ),
    );
  }
  Future <void> showPreview(QueryDocumentSnapshot _add, String id,context) async{
    return showDialog<void>(
        context: context,
        barrierDismissible:true,// false, // user must tap button!
        builder: (BuildContext context) {
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 15),
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(10.0)),

            child: PreviewAdCard(ApiAdd.fromApi(_add), id, _id),
          );
        }
    );
  }
}
