import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FacebookLoginService with ChangeNotifier {
  Map<String, dynamic>? userData;
  AccessToken? accessToken;
  bool checking = true;

  checkIfLoggedIn() async {
    final token = await FacebookAuth.instance.accessToken;

    checking = false;

    if (token != null) {
      //that means user is logged in
      print('facebook access token is ${token.toJson()}');
      final userDetails = await FacebookAuth.instance.getUserData();

      accessToken = token;
      userData = userDetails;
      notifyListeners();
    } else {
      // user is not logged in by facebook
      //so redirect user to login to facebook
      _login();
    }
  }

  //login ==========>
  _login() async {
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      accessToken = result.accessToken;
      final userDetails = await FacebookAuth.instance.getUserData();
      userData = userDetails;
      notifyListeners();
    } else {
      //login by facebook failed
      print('facebook login status ${result.status}');
      print('facebook login message ${result.message}');
      checking = false;
      notifyListeners();
    }
  }

  logoutFromFacebook() async {
    await FacebookAuth.instance.logOut();
    accessToken = null;
    userData = null;
    notifyListeners();
  }
}
