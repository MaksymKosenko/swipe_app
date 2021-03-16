import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/screens/Feed/StandartADCard.dart';
import 'package:swipe_app/screens/Feed/UpgradedADCard.dart';
import 'package:swipe_app/screens/myAD/confirmation/AdDataKeeper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:async' show Stream;
import 'package:async/async.dart' show StreamGroup;
import 'package:async/async.dart';
import 'package:rxdart/streams.dart';
import 'dart:async';
import 'package:rxdart/rxdart.dart';
class AdsList extends StatefulWidget {
  @override
  _AdsListState createState() => _AdsListState();
}

class _AdsListState extends State<AdsList> {
  @override
  Widget build(BuildContext context) {

   // Future<QuerySnapshot> _adsStream = FirebaseFirestore.instance.collection('ads').orderBy("dateTime", descending: true).get();//.snapshots();

    Stream _turbo = FirebaseFirestore.instance.collection('ads').where('icon3', isEqualTo: true).snapshots();
    Stream _promotedBig = FirebaseFirestore.instance.collection('ads').where('icon1', isEqualTo: true).where('icon2',isEqualTo: true).snapshots();
    Stream _promoted = FirebaseFirestore.instance.collection('ads').where('icon1', isEqualTo: false).where('icon2',isEqualTo: true).snapshots();


    Stream _bigAds = FirebaseFirestore.instance.collection('ads')
        //.orderBy("dateTime", descending: true).get()
        .where('icon1', isEqualTo: true).where('icon2', isEqualTo: false).snapshots();
    Stream _defaultADs = FirebaseFirestore.instance.collection('ads').where('icon1', isEqualTo: false).where('icon2', isEqualTo: false)
      .where('icon3', isEqualTo: false).snapshots();//.snapshots().cast();
  

    StaggeredTile _buildStaggeredTile(index, counter0, counter0max) {
      if (index <= counter0max) {
        return StaggeredTile.count(4, 2.40);
      } else {
        //print("change view occur");
        return StaggeredTile.count(2, 2.35);
      }
    }

    return  StreamBuilder(
        stream: CombineLatestStream.list([_bigAds, _defaultADs]),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          var data0;
          var data1;
         // if(snapshot.data[0] != null)
           // data0 = snapshot.data[0];
         // if(snapshot.data[1]!= null)
           // data1 = snapshot.data[1];

          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          if(snapshot.connectionState == ConnectionState.active){
            data1 = snapshot.data[1];
            data0 = snapshot.data[0];
          }


          var counter0 = -1;
          var counter1 = -1;
          return Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: StaggeredGridView.countBuilder(
                  crossAxisCount: 4,
                  itemCount: data0.docs.length + data1.docs.length,
                  itemBuilder: (context, index){

                    //print("data0.d0cs.len - ${data0.docs.length}");
                   // print("data1.d0cs.len - ${data1.docs.length}");
                    counter0++;

                    if(counter0 <= data0.docs.length-1){
                      //return Text(snapshot.data[0].docs[counter0].id);
                      return Container(alignment: Alignment.center,child: UpAdCard(ConcreteAd.fromFirestore(snapshot.data[0].docs[counter0])));
                    }
                    else if(counter1 <= data1.docs.length){
                      //print("else goes on");
                      counter1++;
                     // return Text(snapshot.data[1].docs[counter1].id);
                      return Container(alignment: Alignment.center,child: AdCard(ConcreteAd.fromFirestore(snapshot.data[1].docs[counter1])));
                    }

                    return Text("Wait a bit...");
                  },

                  staggeredTileBuilder: (index) => _buildStaggeredTile(index, counter0, data0.docs.length-1),
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 20.0,
                  ),
            ),
          );
        },
      );
  }
}
