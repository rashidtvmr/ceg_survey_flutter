class AppModel {
  bool isAuth = false;

  bool getAuth() {
    return isAuth;
  }

  void authenticate() {
    isAuth = true;
  }
}
