import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/default_app_bar.dart';
import 'package:swipe_app/screens/feed/landing_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MfcMapScreen extends StatefulWidget {
  MfcMapScreen();
  @override
  _MfcMapScreenState createState() => _MfcMapScreenState();
}

class _MfcMapScreenState extends State<MfcMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Circle> _circles = {};
  Set<Marker> _mfcMarkers = {};
  BitmapDescriptor mfcMarker;


  static final CameraPosition _kSochi = CameraPosition(
    target: LatLng(43.6029303952233, 39.73395266559939),
    zoom: 16.4746,
  );

  void setMfcMarker() async{
    mfcMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), "assets/images/local_apps.png");
  }

  Stream _mfc = FirebaseFirestore.instance.collection('mfc').snapshots();
  int counter = 0;
  getData() async{
    setMfcMarker();
    await FirebaseFirestore.instance.collection('mfc').get().then((value) {
      print("value${value.size}");
      counter = value.size;
    });
    for(int i = 1; i <= counter; i++){

      setMarkers(i);
    }


  }

  setMarkers(int index) async {
    print("setmarkers$index");
    await FirebaseFirestore.instance.collection('mfc').doc("mfc$index").get()
        .then((DocumentSnapshot documentSnapshot) {
    setState(() {
        _mfcMarkers.add(
            Marker(
              onTap: ()=> setState(() {
                isMfcSelected = true;
                phone = documentSnapshot.data()['phone'];
                print("iMfcSelecterd - $isMfcSelected, phone = $phone");
              }),
                markerId: MarkerId('id-$index'),
                position: LatLng(documentSnapshot.data()['location'].latitude, documentSnapshot.data()['location'].longitude),
                icon: mfcMarker,
                infoWindow: InfoWindow(title: "${documentSnapshot.data()['name']}")));
      });
    });
  }
  bool isMfcSelected = false;
  String phone;
  @override
  Widget build(BuildContext context) {
    setMfcMarker();
    if(counter == 0)
    getData();
      _circles.add(
          Circle(circleId: CircleId('id-1'),
            center: LatLng(43.6029303952233, 39.73395266559939),
            radius: 15,
            //strokeWidth: 6,
            fillColor: Color.lerp(Color(0xff56C386), Color(0xff42BFB4), 0.5),
            strokeColor: Colors.white70,
          )
      );

      return Scaffold(
        appBar: MyCustomAppBar("МфЦ", 82, MaterialPageRoute(builder: (context)=> LandingPage())),
        body:  Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kSochi,
              zoomControlsEnabled: false,
              markers: _mfcMarkers,
              circles: _circles,
              //myLocationEnabled: true,
              //onTap:(latLng) => null,//;setCustomMarker(latLng, _address);
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            isMfcSelected ? Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only( bottom: 16),
                child: GestureDetector(
                  onTap: ()=> launch('tel:$phone'),
                  child: Container(
                    height: 52,
                    width: 187,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: Color(0xff4CC19A),
                      boxShadow: [BoxShadow(
                      color: Colors.black26,
                      blurRadius: 12.0, // soften the shadow
                      spreadRadius: 1.0, //extend the shadow
                      offset: Offset(
                        7.0, // Move to right 10  horizontally
                        7.0, // Move to bottom 5 Vertically
                      ),
                    )]
                    ),
                    child: Icon(Icons.phone_in_talk_outlined, color: Colors.white, size: 24,),
                  ),
                ),
              ),
            )
                : Container(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: _goToSochi,
          child: Icon(CupertinoIcons.location_fill, size: 30, color: Color(0xff27AEA4)),
        ),
      );

    }
    Future<void> _goToSochi() async {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(_kSochi));
    }

  }

