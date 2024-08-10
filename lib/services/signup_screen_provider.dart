import 'package:flutter/material.dart';

class SignupScreenProvider extends ChangeNotifier {
  List<String> options = [
    'User',
    'Admin',
  ];
  String currentItemSelected = "User";
  String loginAs = "User";
  void dropdownchange(newValueSelected) {
    currentItemSelected = newValueSelected!;
    loginAs = newValueSelected;
    notifyListeners();
  }
}
