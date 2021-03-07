import 'package:cloud_firestore/cloud_firestore.dart';
class ConcreteAd {

  String _location;
  String _chosenZhK;
  String _apartmentsType;
  String _roomsQuantity;
  String _housePlan;
  String _houseState;
  String _overallArea;
  String _kitchenArea;
  String _balconyState;
  String _heatingType;
  String _paymentType;
  String _connectionType;
  String _description;
  String _cost;
  String _agentPayment;
  String _mainPhotoPath;
  String _additionalPhotosPath;

  bool phrase1 = false;
  bool phrase2 = false;
  bool phrase3 = false;
  bool phrase4 = false;
  bool phrase5 = false;
  bool phrase6 = false;
  bool phrase7 = false;
  bool phrase8 = false;

  String chosenPhrase = "null";

  bool textColor1 = false;
  bool textColor2 = false;

  bool icon1 = false;
  bool icon2 = false;
  bool icon3 = false;


  void setTextColor(String option){
    switch(option){
      case "option2sub1" : textColor1 = true; textColor2 = false; break;
      case "option2sub2" : textColor1 = false; textColor2 = true; break;
      case "null" : textColor1 = false; textColor2 = false; break;
    }
  }
  void setNullPhrases(){
    phrase1 = false;
    phrase2 = false;
    phrase3 = false;
    phrase4 = false;
    phrase5 = false;
    phrase6 = false;
    phrase7 = false;
    phrase8 = false;
    chosenPhrase = "null";
  }
  void setChosenPhrase(){
    if(phrase1 == true)
      chosenPhrase = "Подарок при покупке";
    if(phrase2 == true)
      chosenPhrase = "Возможен торг";
    if(phrase3 == true)
      chosenPhrase = "Квартира у моря";
    if(phrase4 == true)
      chosenPhrase = "В спальном районе";
    if(phrase5 == true)
      chosenPhrase = "Вам повезло с ценой!";
    if(phrase6 == true)
      chosenPhrase = "Для большой семьи";
    if(phrase7 == true)
      chosenPhrase = "Семейное гнездышко";
    if(phrase8 == true)
      chosenPhrase = "Отдельная парковка";
    if(phrase1 == phrase2 && phrase3 == phrase4 && phrase5 == phrase6 &&phrase7 == phrase8){
      chosenPhrase = "null";
    }
  }
  void setActivePhrase(String phrase){
    switch(phrase){
            case "phrase1":
          phrase1 = true;
          phrase2 = false;
          phrase3 = false;
          phrase4 = false;
          phrase5 = false;
          phrase6 = false;
          phrase7 = false;
          phrase8 = false;
          setChosenPhrase();
          break;
        case "phrase2":
          phrase1 = false;
          phrase2 = true;
          phrase3 = false;
          phrase4 = false;
          phrase5 = false;
          phrase6 = false;
          phrase7 = false;
          phrase8 = false;
          setChosenPhrase();
          break;
        case "phrase3":
          phrase1 = false;
          phrase2 = false;
          phrase3 = true;
          phrase4 = false;
          phrase5 = false;
          phrase6 = false;
          phrase7 = false;
          phrase8 = false;
          setChosenPhrase();
          break;
        case "phrase4":
          phrase1 = false;
          phrase2 = false;
          phrase3 = false;
          phrase4 = true;
          phrase5 = false;
          phrase6 = false;
          phrase7 = false;
          phrase8 = false;
          setChosenPhrase();
          break;
        case "phrase5":
          phrase1 = false;
          phrase2 = false;
          phrase3 = false;
          phrase4 = false;
          phrase5 = true;
          phrase6 = false;
          phrase7 = false;
          phrase8 = false;
          setChosenPhrase();
          break;
        case "phrase6":
          phrase1 = false;
          phrase2 = false;
          phrase3 = false;
          phrase4 = false;
          phrase5 = false;
          phrase6 = true;
          phrase7 = false;
          phrase8 = false;
          setChosenPhrase();
          break;
        case "phrase7":
          phrase1 = false;
          phrase2 = false;
          phrase3 = false;
          phrase4 = false;
          phrase5 = false;
          phrase6 = false;
          phrase7 = true;
          phrase8 = false;
          setChosenPhrase();
          break;
        case "phrase8":
          phrase1 = false;
          phrase2 = false;
          phrase3 = false;
          phrase4 = false;
          phrase5 = false;
          phrase6 = false;
          phrase7 = false;
          phrase8 = true;
          setChosenPhrase();
          break;

      case "null":
        phrase1 = false;
        phrase2 = false;
        phrase3 = false;
        phrase4 = false;
        phrase5 = false;
        phrase6 = false;
        phrase7 = false;
        phrase8 = false;
        setChosenPhrase();
    }
  }

  String get location => _location;

  void setLocation(String value){
    _location = value;
  }

  String get chosenZhK => _chosenZhK;

  void setChosenZhK(String value){
    _chosenZhK = value;
  }

  String get apartmentsType => _apartmentsType;

  void setApartmentsType(String value){
    _apartmentsType = value;
  }

  String get roomsQuantity => _roomsQuantity;

  void setRoomsQuantity(String value){
    _roomsQuantity = value;
  }

  String get housePlan => _housePlan;

  void setHousePlan(String value){
    _housePlan = value;
  }

  String get houseState => _houseState;

  void setHouseState(String value){
    _houseState = value;
  }


  String get overallArea => _overallArea;

  void setOverallArea(String value){
    _overallArea = value;
  }

  String get kitchenArea => _kitchenArea;

  void setKitchenArea(String value){
    _kitchenArea = value;
  }

  String get balconyState => _balconyState;

  void setBalconyState(String value){
    _balconyState = value;
  }

  String get heatingType => _heatingType;

  void setHeatingType(String value){
    _heatingType = value;
  }

  String get paymentType => _paymentType;

  void setPaymentType(String value){
    _paymentType = value;
  }

  String get connectionType => _connectionType;

  void setConnectionType(String value){
    _connectionType = value;
  }

  String get description => _description;

  void setDescription(String value){
    _description = value;
  }

  String get cost => _cost;

  void setCost(String value){
    _cost = value;
  }

  String get agentPayment => _agentPayment;

  void setAgentPayment(String value){
    _agentPayment = value;
  }

  String get mainPhotoPath => _mainPhotoPath;

  void setMainPhotoPath(String value){
    _mainPhotoPath = value;
  }

  String get additionalPhotosPath => _additionalPhotosPath;

  void setAdditionalPhotosPath(String value){
    if(_additionalPhotosPath == "")
    _additionalPhotosPath = value;
    else _additionalPhotosPath = "$_additionalPhotosPath $value";
  }

  CollectionReference _ads = FirebaseFirestore.instance.collection('ads');
  CollectionReference _users = FirebaseFirestore.instance.collection('users');
  Future<void> addMyAD(String phone){
    return _ads
    .add({
      'location': _location,
      'chosenZhK': _chosenZhK,
      'apartmentsType': _apartmentsType,
      'roomsQuantity': _roomsQuantity,
      'housePlan': _housePlan,
      'houseState': _houseState,
      'overallArea': _overallArea,
      'kitchenArea': _kitchenArea,
      'balconyState': _balconyState,
      'heatingType': _heatingType,
      'paymentType': _paymentType,
      'connectionType': _connectionType,
      'description': _description,
      'cost': _cost,
      'agentPayment': _agentPayment,
      'mainPhotoPath': _mainPhotoPath,
      'additionalPhotosPath': _additionalPhotosPath,

      'chosenPhrase': chosenPhrase,

      'textColor1': textColor1,
      'textColor2': textColor2,
      'icon1': icon1,
      'icon2': icon2,
      'icon3': icon3,
    })
    .then((value) {print("ads added"); addToMyCollection(value.id, phone);})
    .catchError((error) => print("Failed to add asd: $error"));
  }

  Future<void>addToMyCollection(String addID, String phone){
    return _users
        .doc(phone)
        .collection("user_collections")
        .doc("myAd")
        .collection("myAds")
        .doc(addID)
        .set({
          'addID': addID,
        })
       // .add({
    // 'addID': addID,
   // })
        .then((value) => print("toUser add added"))
        .catchError((error) => print("Failed to add Agent: $error"));
  }
}
