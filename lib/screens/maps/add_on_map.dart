import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:swipe_app/global/custom_widgets/app_bars/default_app_bar.dart';
import 'package:swipe_app/global/style/text_styles.dart';
import 'package:swipe_app/models/repository/api_add.dart';
import 'package:swipe_app/screens/add_cards/full_ad_card.dart';
class AddMapScreen extends StatefulWidget {
  final ApiAdd _add;
  final String _id;
  final double _lat;
  final double _long;
  AddMapScreen(this._add, this._id, this._lat, this._long);
  @override
  _AddMapScreenState createState() => _AddMapScreenState();
}

class _AddMapScreenState extends State<AddMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Circle> _circles = {};
  Set<Marker> _zhkMarkers = {};
  //BitmapDescriptor zhkMarker;

  @override
  Widget build(BuildContext context) {
    _circles.add(
        Circle(circleId: CircleId('id-1'),
          center: LatLng(43.6029303952233, 39.73395266559939),
          radius: 15,
          //strokeWidth: 6,
          fillColor: Color.lerp(Color(0xff56C386), Color(0xff42BFB4), 0.5),
          strokeColor: Colors.white70,
        )
    );

    _zhkMarkers.add(
        Marker(
            markerId: MarkerId('id-0'),
            position: LatLng(widget._lat, widget._long),
            infoWindow: InfoWindow(title: "${widget._add.address}")));

    return Scaffold(
      appBar: MyCustomAppBar("Адресс", 82,
        MaterialPageRoute(builder: (context) => FullAdCard(widget._add, widget._id)),),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(widget._lat, widget._long),
              zoom: 16.4746,
            ),
            zoomControlsEnabled: false,
            markers: _zhkMarkers,
            circles: _circles,
            //myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),

          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 7.5, horizontal: 15),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color:  Colors.white,
                    border: Border.all(color: Color(0xff27AEA4)),
                boxShadow: [BoxShadow(
                  color: Colors.black26,
                  blurRadius: 12.0, // soften the shadow
                  spreadRadius: 1.0, //extend the shadow
                  offset: Offset(
                    7.0, // Move to right 10  horizontally
                    7.0, // Move to bottom 5 Vertically
                  ),
                )]),
                child: Text("${widget._add.address}", style: RegularText(14, Color(0xff27AEA4)),),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: ()=> _goAdd(),
                    child: Container(
                        height: 50, width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                              //stops: [2],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff56C587),
                                Color(0xff43C1B5),
                              ],
                            )),
                        child: Icon(Icons.location_city_outlined ,color: Colors.white,size: 28,)),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: ()=> _goToSochi(),
                    child: Container(
                        height: 50, width: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                              //stops: [2],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xff56C587),
                                Color(0xff43C1B5),
                              ],
                            )),
                        child: Icon(Icons.my_location ,color: Colors.white,size: 28,)),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goToSochi() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(43.6029303952233, 39.73395266559939),
      zoom: 16.4746,
    )));
  }

  Future<void> _goAdd() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(widget._add.location.latitude, widget._add.location.longitude),
      zoom: 16.4746,
    )));
  }

}
