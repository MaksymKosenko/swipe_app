
import 'package:cloud_firestore/cloud_firestore.dart';

class ApiZhk {
  final String _name;
  final GeoPoint _location;
  final String _address;



  ApiZhk.fromApi(Map<String, dynamic> map)
      : _name = map['name'],
        _location = map['location'],
        _address = map['address'];

  String get name => _name;

  GeoPoint get location => _location;

  String get address => _address;
}