import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:pusher_beams/pusher_beams.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/pay_services/stripe_service.dart';
import 'package:qixer/service/push_notification_service.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginService with ChangeNotifier {
  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Future<bool> login(email, pass, BuildContext context, bool keepLoggedIn,
      {isFromLoginPage = true}) async {
    var connection = await checkConnection();
    if (connection) {
      setLoadingTrue();
      var data = jsonEncode({
        'email': email,
        'password': pass,
      });
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json"
      };

      var response = await http.post(Uri.parse('$baseApi/login'),
          body: data, headers: header);

      print(response.body);

      if (response.statusCode == 201) {
        if (isFromLoginPage) {
          print("called");
          OthersHelper()
              .showToast("Login successful", ConstantColors().successColor);
        }
        setLoadingFalse();

        String token = jsonDecode(response.body)['token'];
        int userId = jsonDecode(response.body)['users']['id'];
        String state = jsonDecode(response.body)['users']['state'].toString();
        String countryId =
            jsonDecode(response.body)['users']['country_id'].toString();

        if (keepLoggedIn) {
          saveDetails(email, pass, token, userId, state, countryId);
        } else {
          setKeepLoggedInFalseSaveToken(token);
        }

        // //start pusher
        // //============>
        await Provider.of<PushNotificationService>(context, listen: false)
            .fetchPusherCredential();
        var pusherInstance =
            Provider.of<PushNotificationService>(context, listen: false)
                .pusherInstance;
        await PusherBeams.instance.start(pusherInstance);

        // //start stripe
        // //============>
        // var publishableKey = await StripeService().getStripeKey();
        // Stripe.publishableKey = publishableKey;
        // Stripe.instance.applySettings();

        // =======>
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const LandingPage(),
          ),
        );

        return true;
      } else {
        print(response.body);
        //Login unsuccessful ==========>
        if (isFromLoginPage) {
          OthersHelper().showToast(
              "Invalid Email or Password", ConstantColors().warningColor);
        }
        setLoadingFalse();
        return false;
      }
    } else {
      //internet off
      return false;
    }
  }

  saveDetails(
      String email, pass, String token, int userId, state, countryId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setBool('keepLoggedIn', true);
    prefs.setString("pass", pass);
    prefs.setString("token", token);
    prefs.setInt('userId', userId);
    prefs.setString("state", state);
    prefs.setString("countryId", countryId);
    print('token is $token');
    print('user id is $userId');
    print('user state id is $state');
  }

  setKeepLoggedInFalseSaveToken(token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('keepLoggedIn', false);
    prefs.setString("token", token);
  }
}
