import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/auth_services/login_service.dart';
import 'package:qixer/view/auth/login/login.dart';
import 'package:qixer/view/intro/introduction_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashService {
  loginOrGoHome(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? keepLogin = prefs.getBool('keepLoggedIn');
    String? email = prefs.getString('email');
    if (keepLogin == null) {
      //that means user is opening the app for the first time.. so , show the intro
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const IntroductionPage(),
          ),
        );
      });
    } else if (keepLogin == false) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const LoginPage(),
          ),
        );
      });
    } else {
      //Try to login with the saved email and password
      String? email = prefs.getString('email');
      String? pass = prefs.getString('pass');
      var result = Provider.of<LoginService>(context, listen: false)
          .login(email, pass, context, true, isFromLoginPage: false);

      if (result == false) {
        //if successfully registered
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const LoginPage(),
          ),
        );
      }
    }
  }
}
