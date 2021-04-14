import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ApiAdd {
  final GeoPoint location;
  final String address;
  final String chosenZhK;
  final String apartmentsType;
  final String roomsQuantity;
  final String housePlan;
  final String houseState;
  final String overallArea;
  final String kitchenArea;
  final String balconyState;
  final String heatingType;
  final String paymentType;
  final String connectionType;
  final String description;
  final String cost;
  final String agentPayment;
  final List<dynamic> photos;

  final String chosenPhrase;

  final bool textColorRose;
  final bool textColorGreen;

  final bool bigAd;
  final bool promotedAd;
  final bool promotedBig;

  final Timestamp dateTime;

  final String day;
  final String month;
  final int hours;
  final int minutes;

  final String id;
  final int watches;
  final int saves;
  final String ownerID;

  ApiAdd.fromApi(QueryDocumentSnapshot snapshot)
      :  location = snapshot.data()['location'],
        address = snapshot.data()['address'],
        chosenZhK = snapshot.data()['chosenZhK'],
        apartmentsType = snapshot.data()['apartmentsType'],
        roomsQuantity = snapshot.data()['roomsQuantity'],
        housePlan = snapshot.data()['housePlan'],
        houseState = snapshot.data()['houseState'],
        overallArea = snapshot.data()['overallArea'],
        kitchenArea = snapshot.data()['kitchenArea'],
        balconyState = snapshot.data()['balconyState'],
        heatingType = snapshot.data()['heatingType'],
        paymentType = snapshot.data()['paymentType'],

        connectionType = snapshot.data()['connectionType'],
        description = snapshot.data()['description'],
        cost = snapshot.data()['cost'],
        agentPayment = snapshot.data()['agentPayment'],
        photos = snapshot.data()['photos'],

        chosenPhrase = snapshot.data()['chosenPhrase'],
        textColorRose = snapshot.data()['textColorRose'],
        textColorGreen = snapshot.data()['textColorGreen'],

        bigAd = snapshot.data()['icon1'],
        promotedAd = snapshot.data()['icon2'],
        promotedBig = snapshot.data()['icon3'],

        dateTime = snapshot.data()['dateTime'],

        day = snapshot.data()['day'],
        month= snapshot.data()['month'],
        hours= snapshot.data()['hours'],
        minutes= snapshot.data()['minutes'],

        id= snapshot.data()['id'],
        watches = snapshot.data()['watches'],
        saves = snapshot.data()['saves'],
        ownerID = snapshot.data()['ownerID'];

  ApiAdd.fromApiToDoc(Map<String, dynamic> data)
      :  location = data['location'],
        address = data['address'],
        chosenZhK = data['chosenZhK'],
        apartmentsType = data['apartmentsType'],
        roomsQuantity = data['roomsQuantity'],
        housePlan = data['housePlan'],
        houseState = data['houseState'],
        overallArea = data['overallArea'],
        kitchenArea = data['kitchenArea'],
        balconyState = data['balconyState'],
        heatingType = data['heatingType'],
        paymentType = data['paymentType'],

        connectionType = data['connectionType'],
        description = data['description'],
        cost = data['cost'],
        agentPayment = data['agentPayment'],
        photos = data['photos'],

        chosenPhrase = data['chosenPhrase'],
        textColorRose = data['textColor1'],
        textColorGreen = data['textColor2'],

        bigAd = data['icon1'],
        promotedAd = data['icon2'],
        promotedBig = data['icon3'],

        dateTime = data['dateTime'],

        day = data['day'],
        month= data['month'],
        hours= data['hours'],
        minutes= data['minutes'],

        id= data['id'],
        watches = data['watches'],
        saves = data['saves'],
        ownerID = data['ownerID'];
}

