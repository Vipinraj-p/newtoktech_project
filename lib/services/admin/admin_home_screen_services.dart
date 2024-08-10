import 'package:flutter/material.dart';

class AdminHomeScreenServices extends ChangeNotifier {
  String countryValue = "";
  String stateValue = "";
  String cityValue = "";
  // var countryFlag;
  dynamic location;
  setLocation() {
    //  var countryFlag;
    location = <String, String>{
      "country": countryValue,
      "state": stateValue,
      "city": cityValue,
    };
    notifyListeners();
  }
}
