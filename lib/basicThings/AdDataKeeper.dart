
class ConcreteAd{
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
}