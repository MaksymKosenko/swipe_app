import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class Add{
  GeoPoint location;
  String address;
  String chosenZhK;
  String apartmentsType;
  String roomsQuantity;
  String housePlan;
  String houseState;
  String overallArea;
  String kitchenArea;
  String balconyState;
  String heatingType;
  String paymentType;
  String connectionType;
  String description;
  String cost;
  String agentPayment;
  List<dynamic> photos = List<dynamic>.empty(growable: true);
  List<File> photoFiles = [null, null, null, null, null, null];


  String chosenPhrase;

  bool textColorRose = false;
  bool textColorGreen = false;

  bool bigAd;
  bool promotedAd;
  bool promotedBig;

  Timestamp dateTime;

  Add({
    this.location,
    this.address,
    this.chosenZhK,
    this.apartmentsType,
    this.roomsQuantity,
    this.housePlan,
    this.houseState,
    this.overallArea,
    this.kitchenArea,
    this.balconyState,
    this.heatingType,
    this.paymentType,
    this.connectionType,
    this.description,
    this.cost,
    this.agentPayment,
    this.photos,
    this.chosenPhrase,
    this.textColorRose,
    this.textColorGreen,
    this.bigAd,
    this.promotedAd,
    this.promotedBig,
    this.dateTime,
    this.photoFiles,
  });
}
