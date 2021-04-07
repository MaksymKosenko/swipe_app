import 'dart:async';
import 'dart:async' show Stream;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/streams.dart';
import 'package:swipe_app/models/repository/api_add.dart';
import 'package:swipe_app/screens/feed/promoted_ad_card.dart';
import 'package:swipe_app/screens/feed/standart_ad_card.dart';

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
                print("listLen - ${list.length}");
                print(snapshot.data[0].docs.length);
                print(snapshot.data[1].docs.length);
                print(snapshot.data[2].docs.length);
                print(snapshot.data[3].docs.length);

                if(counter3 <= data3.docs.length-1){
                  counter3++;
                  return Container(alignment: Alignment.center,child: UpAdCard(ApiAdd.fromApi(list[counter3])));
                }
                else if(counter2 <= data2.docs.length - 1){
                  counter2++;
                  return Container(alignment: Alignment.center,child: SAdCard.fromApi(ApiAdd.fromApi(list[counter2])));//(ApiAdd.fromApi(snapshot.data[1].docs[counter1])));
                }else if(counter1 <= data1.docs.length - 1){
                  counter1++;
                  return Container(alignment: Alignment.center,child: UpAdCard(ApiAdd.fromApi(list[counter1])));//(ApiAdd.fromApi(snapshot.data[1].docs[counter1])));
                }else if(counter0 <= data0.docs.length - 1){
                  counter0++;
                  return Container(alignment: Alignment.center,child:  SAdCard.fromApi(ApiAdd.fromApi(list[counter0])));//(ApiAdd.fromApi(snapshot.data[1].docs[counter1])));
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
}
