import 'dart:async';
import 'dart:async' show Stream;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/streams.dart';
import 'package:swipe_app/models/repository/api_add.dart';
import 'file:///C:/flutter_projects/flutterlearning/flutter_Dart_courses/swipe_app/lib/screens/add_cards/promoted_ad_card.dart';
import 'file:///C:/flutter_projects/flutterlearning/flutter_Dart_courses/swipe_app/lib/screens/add_cards/standart_ad_card.dart';
import 'package:swipe_app/screens/add_cards/preview_ad_card.dart';

class AdsList extends StatefulWidget {
  @override
  _AdsListState createState() => _AdsListState();
}

class _AdsListState extends State<AdsList> {
  @override
  Widget build(BuildContext context) {
    // Future<QuerySnapshot> _adsStream = FirebaseFirestore.instance.collection('ads').orderBy("dateTime", descending: true).get();//.snapshots();

    Stream _turbo = FirebaseFirestore.instance
        .collection('ads')
        .where('icon3', isEqualTo: true)
        .snapshots();
    Stream _promoted = FirebaseFirestore.instance
        .collection('ads')
        .where('icon1', isEqualTo: false)
        .where('icon2', isEqualTo: true)
        .snapshots();

    Stream _bigAds = FirebaseFirestore.instance
        .collection('ads')
        //.orderBy("dateTime", descending: true).get()
        .where('icon1', isEqualTo: true)
        .where('icon2', isEqualTo: false)
        .snapshots();
    Stream _defaultADs = FirebaseFirestore.instance
        .collection('ads')
        .where('icon1', isEqualTo: false)
        .where('icon2', isEqualTo: false)
        .where('icon3', isEqualTo: false)
        .snapshots(); //.snapshots().cast();

    StaggeredTile _buildStaggeredTile(index, c0max, c1max, c2max, c3max) {
      if (index < c0max) {
        return StaggeredTile.count(4, 2.40);
      } else if(index < c0max + c1max){
        return StaggeredTile.count(2, 2.35);
      } else if(index < c0max + c1max + c2max){
        return StaggeredTile.count(4, 2.40);
      } else if(index < c0max + c1max + c2max + c3max){
        return StaggeredTile.count(2, 2.35);
      }
    }

    return StreamBuilder(
      stream:
          CombineLatestStream.list([_defaultADs, _bigAds, _promoted, _turbo]),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        var data0;
        var data1;
        var data2;
        var data3;
        var list = [];
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        if (snapshot.connectionState == ConnectionState.active) {
          data3 = snapshot.data[3];
          data2 = snapshot.data[2];
          data1 = snapshot.data[1];
          data0 = snapshot.data[0];
          list.addAll(snapshot.data[0].docs);
          list.addAll(snapshot.data[1].docs);
          list.addAll(snapshot.data[2].docs);
          list.addAll(snapshot.data[3].docs);
        }

        var counter3 = 0;
        var counter2 = 0;
        var counter1 = 0;
        var counter0 = 0;

        return Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: StaggeredGridView.countBuilder(
              crossAxisCount: 4,
              itemCount: list.length,
              itemBuilder: (context, index) {
                if(counter3 <= data3.docs.length-1){
                  counter3++;
                  return GestureDetector(
                    onLongPress: () => showPreview(list[index], context),
                      child: Container(alignment: Alignment.center,child: UpAdCard(ApiAdd.fromApi(list[index]))));
                }
                else if(counter2 <= data2.docs.length - 1){
                  counter2++;
                  return GestureDetector(
                      onLongPress: () => showPreview(list[index], context),
                      child: Container(alignment: Alignment.center,child: SAdCard.fromApi(ApiAdd.fromApi(list[index]))));//(ApiAdd.fromApi(snapshot.data[1].docs[counter1])));
                }else if(counter1 <= data1.docs.length - 1){
                  counter1++;
                  return GestureDetector(
                      onLongPress: ()=> showPreview(list[index], context),
                      child: Container(alignment: Alignment.center,child: UpAdCard(ApiAdd.fromApi(list[index]))));//(ApiAdd.fromApi(snapshot.data[1].docs[counter1])));
                }else if(counter0 <= data0.docs.length - 1){
                  counter0++;
                  return GestureDetector(
                      onLongPress: ()=> showPreview(list[index], context),
                      child: Container(alignment: Alignment.center,child:  SAdCard.fromApi(ApiAdd.fromApi(list[index]))));//(ApiAdd.fromApi(snapshot.data[1].docs[counter1])));
                }

                return Text("Wait a bit...");
              },
              staggeredTileBuilder: (index) =>  _buildStaggeredTile(index, data3.docs.length, data2.docs.length, data1.docs.length, data0.docs.length),
              //StaggeredTile.count(4, 2.40),
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 20.0,
            ),
          ),
        );
      },
    );
  }


  Future <void> showPreview(QueryDocumentSnapshot _add, context) async{
    return showDialog<void>(
        context: context,
        barrierDismissible:true,// false, // user must tap button!
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(10.0)),
            child: PreviewAdCard(ApiAdd.fromApi(_add)),
          );
          /*
          return AlertDialog(
            title: Text('Login error'),
            content: SingleChildScrollView(
              child: SAdCard.fromApi(ApiAdd.fromApi(_add)),
              /* ListBody(
                children: <Widget>[
                  Text(_add.cost),
                  Text(_add.roomsQuantity),
                  Text(_add.roomsQuantity),
                  Text(_add.address),
                ],
              ),*/
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

          */
        }
    );
  }

}
