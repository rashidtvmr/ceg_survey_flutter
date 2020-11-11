// import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppModel extends ChangeNotifier {
  bool isAuth = false;
  // String serverURL = "https://thesurvey.herokuapp.com";
  String serverURL = "http://192.168.1.17:3003";
  String get getServerURL => serverURL;

  String authCode = "";
  String userName = "Guest User";

  bool get getAuth => isAuth;
  String get getUserName => userName;
  String get getAuthCode => authCode;

  void setAuthCode(String pd) {
    authCode = pd;
  }

  void setName(String payload) {
    userName = payload;
    notifyListeners();
  }

  void authenticate(bool payload) {
    if (!payload) {
      userName = "Guest User";
      authCode = "";
    }
    isAuth = payload;
    notifyListeners();
  }
}
