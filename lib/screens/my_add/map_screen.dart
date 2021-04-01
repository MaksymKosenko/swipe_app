import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

import 'package:swipe_app/global/custom_widgets/app_bars/default_app_bar.dart';
import 'package:swipe_app/global/custom_widgets/custom_button.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/add_model.dart';
import 'package:swipe_app/screens/my_add/ad_address.dart';
import 'package:swipe_app/screens/my_add/whole_ad_container.dart';

class MapScreen extends StatefulWidget {
  final AddressState _addressState;
  final Add _add;
  MapScreen(this._addressState, this._add);
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  //var currentLocation;
  Set<Marker> _zhkMarkers = {};
  BitmapDescriptor mapMarker;
  BitmapDescriptor zhkMarker;
  Set<Circle> _circles = {};
  bool isSaveEnabled = false;

  double _currentLat;
  double _currentLong;
  String _currentName;
  String _address;
    static final CameraPosition _kSochi = CameraPosition(
    target: LatLng(43.6029303952233, 39.73395266559939),
    zoom: 16.4746,
  );
  //CameraPosition _kCurrent;
  static final CameraPosition _kCurrent = CameraPosition(
    target: LatLng(43.6029303952233, 39.73395266559939),
    zoom: 16.4746,
  );

  void changeView(){
    setState(() {
      isSaveEnabled = true;
    });
  }

  void setupSaveButton(double lat, double long, String name) async{
    _currentLat = lat;
    _currentLong = long;
    _currentName = name;
    //getLoc(lat, long);
  }



  @override
  Widget build(BuildContext context) {

    void setZhkMarker() async{
      zhkMarker = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), "assets/images/local_apps.png");
    }


    void setCustomMarker(double lat, double long, String location) async{
      setState(() {
        isSaveEnabled = false;
        _zhkMarkers.remove(Marker(markerId: MarkerId('id-0')));
        mapMarker = BitmapDescriptor.defaultMarker;
        isSaveEnabled = true;
        _zhkMarkers.add(
            Marker(
                markerId: MarkerId('id-0'),
                position: LatLng(lat, long),
                icon: mapMarker,
                infoWindow: InfoWindow(title: "$location")));
        setupSaveButton(lat, long, "Другое");
      });
    }

    void getLoc(double lat, double long) async{
      final coordinates = new Coordinates(lat, long);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var first = addresses.first;
      if(first.addressLine != null){
        setState(() {
          _address = "${first.thoroughfare} ${first.subThoroughfare}, ${first.locality}";
          print(first.thoroughfare);
          print(first.subThoroughfare);
          print(first.locality);
          setCustomMarker(lat, long, _address);
        });
      }
    }

    _circles.add(
      Circle(circleId: CircleId('id-1'),
      center: LatLng(43.6029303952233, 39.73395266559939),
      radius: 15,
      //strokeWidth: 6,
      fillColor: Color.lerp(Color(0xff56C386), Color(0xff42BFB4), 0.5),
      strokeColor: Colors.white70,
      )
    );
    Stream _zhk = FirebaseFirestore.instance.collection('zhk').snapshots();
    return  StreamBuilder(
        stream: _zhk,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          setZhkMarker();
          //_markers.clear();
          if(snapshot.connectionState == ConnectionState.active){

            for(int i = 0; i < snapshot.data.docs.length; i++){
              GeoPoint _geoPoint = snapshot.data.docs[i]['location'];
              setZhkMarker();
              _zhkMarkers.add(
                  Marker(
                      markerId: MarkerId('id-${i+1}'),
                      position: LatLng(_geoPoint.latitude, _geoPoint.longitude),
                      icon: zhkMarker,
                      onTap: (){
                        changeView();
                        setupSaveButton(_geoPoint.latitude, _geoPoint.longitude, snapshot.data.docs[i]['name']);} ,//isSaveEnabled = true,
                      infoWindow: InfoWindow(title: "${snapshot.data.docs[i]['name']}")));
            }
            return Scaffold(
              appBar: MyCustomAppBar("Адресс", 82, MaterialPageRoute(builder: (context)=> MyNewAD(widget._add))),

              body:  Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kSochi,
                    zoomControlsEnabled: false,
                    markers: _zhkMarkers,
                    circles: _circles,
                    //myLocationEnabled: true,
                    onTap:(latLng) => getLoc(latLng.latitude, latLng.longitude),//;setCustomMarker(latLng, _address);
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  isSaveEnabled ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: Container(
                        width:200, height: 40,
                        decoration: BoxDecoration(
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
                        child: GestureDetector(
                          onTap: (){
                            widget._add.address = _address;
                            widget._add.location = GeoPoint(_currentLat, _currentLong);
                            widget._add.chosenZhK = _currentName;
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> MyNewAD(widget._add)), (route) => false);
                            },
                          child: CustomButton(200, 40, 12, Colors.white, Colors.white,
                              Alignment.centerRight, Alignment.centerLeft, "Сохранить",
                              MediumText(14, Color(0xff27AEA4)), Color(0xff27AEA4)),
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
          return Scaffold(
            appBar: MyCustomAppBar("Адресс", 82, MaterialPageRoute(builder: (context)=> MyNewAD(widget._add))),

            body:  Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: _kSochi,
                  zoomControlsEnabled: false,
                  markers: _zhkMarkers,
                  circles: _circles,
                  //myLocationEnabled: true,
                  onTap:(latLng) => getLoc(latLng.latitude, latLng.longitude),//setCustomMarker(latLng,_address);
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                isSaveEnabled ? Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Container(
                      width:200, height: 40,
                      decoration: BoxDecoration(
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
                      child: GestureDetector(
                        onTap: (){
                          widget._add.address = _address;
                          widget._add.location = GeoPoint(_currentLat, _currentLong);
                          widget._add.chosenZhK = _currentName;
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> MyNewAD(widget._add)), (route) => false);
                        },
                        child: CustomButton(200, 40, 12, Colors.white, Colors.white,
                            Alignment.centerRight, Alignment.centerLeft, "Сохранить",
                            MediumText(14, Color(0xff27AEA4)), Color(0xff27AEA4)),
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
        });
   /*
    return Scaffold(
      appBar: MyCustomAppBar("Адресс", 82, MaterialPageRoute(builder: (context)=> MyNewAD(widget._add))),

      body:  Stack(
        children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kSochi,
          zoomControlsEnabled: false,
          markers: _markers,
          circles: _circles,
          //myLocationEnabled: true,
          onTap:(latLng) => setCustomMarker(latLng) ,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
          isSaveEnabled ? Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Container(
                width:200, height: 40,
                decoration: BoxDecoration(
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
                child: CustomButton(200, 40, 12, Colors.white, Colors.white,
                    Alignment.centerRight, Alignment.centerLeft, "Сохранить",
                    MediumText(14, Color(0xff27AEA4)), Color(0xff27AEA4)),
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
    );*/
  }
  Future<void> _goToSochi() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kSochi));
  }

}
