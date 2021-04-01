import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  String mainPhotoPath;
  String additionalPhotosPath;

  String chosenPhrase;

  bool textColorRose;
  bool textColorGreen;

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
    this.mainPhotoPath,
    this.additionalPhotosPath,
    this.chosenPhrase,
    this.textColorRose,
    this.textColorGreen,
    this.bigAd,
    this.promotedAd,
    this.promotedBig,
    this.dateTime,
  });
}
