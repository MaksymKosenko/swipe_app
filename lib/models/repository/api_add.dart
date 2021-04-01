import 'package:cloud_firestore/cloud_firestore.dart';

class ApiAdd {
  final String location;
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
  final String mainPhotoPath;
  final String additionalPhotosPath;

  final String chosenPhrase;

  final bool textColorRose;
  final bool textColorGreen;

  final bool bigAd;
  final bool promotedAd;
  final bool promotedBig;

  final Timestamp dateTime;

  ApiAdd.fromApi(Map<String, dynamic> map)
      :  location = map['location'],
        chosenZhK = map['chosenZhK'],
        apartmentsType = map['apartmentsType'],
        roomsQuantity = map['roomsQuantity'],
        housePlan = map['housePlan'],
        houseState = map['houseState'],
        overallArea = map['overallArea'],
        kitchenArea = map['kitchenArea'],
        balconyState = map['balconyState'],
        heatingType = map['heatingType'],
        paymentType = map['paymentType'],

        connectionType = map['connectionType'],
        description = map['description'],
        cost = map['cost'],
        agentPayment = map['agentPayment'],
        mainPhotoPath = map['mainPhotoPath'],
        additionalPhotosPath = map['additionalPhotosPath'],
        chosenPhrase = map['chosenPhrase'],
        textColorRose = map['textColor1'],
        textColorGreen = map['textColor2'],

        bigAd = map['icon1'],
        promotedAd = map['icon2'],
        promotedBig = map['icon3'],

        dateTime = map['dateTime'];
}