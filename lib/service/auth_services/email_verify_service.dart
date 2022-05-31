import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmailVerifyService with ChangeNotifier {
  // bool isloading = false;

  // String? otpNumber;

  // setLoadingTrue() {
  //   isloading = true;
  //   notifyListeners();
  // }

  // setLoadingFalse() {
  //   isloading = false;
  //   notifyListeners();
  // }

  // Future<bool> sendOtpForEmailValidation(email, BuildContext context) async {
  //   var connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     OthersHelper()
  //         .showToast("Please turn on your internet connection", Colors.black);
  //     return false;
  //   } else {
  //     var header = {
  //       //if header type is application/json then the data should be in jsonEncode method
  //       "Accept": "application/json",
  //       "Content-Type": "application/json"
  //     };
  //     var data = jsonEncode({
  //       'email': email,
  //     });

  //     var response = await http.post(Uri.parse('$baseApi/send-otp-in-mail'),
  //         headers: header, body: data);
  //     if (response.statusCode == 201) {
  //       otpNumber = jsonDecode(response.body)['otp'];
  //       debugPrint('otp is $otpNumber');
  //       notifyListeners();

  //       return true;
  //     } else {
  //       OthersHelper()
  //           .showToast(jsonDecode(response.body)['message'], Colors.black);

  //       return false;
  //     }
  //   }
  // }

  // checkAndVerifyOtp(enteredOtp, BuildContext context) async {
  //   if (otpNumber != null) {
  //     if (enteredOtp == otpNumber) {
  //       setLoadingTrue();
  //       SharedPreferences prefs = await SharedPreferences.getInstance();
  //       var userId = prefs.getInt('userId');

  //       var header = {
  //         //if header type is application/json then the data should be in jsonEncode method
  //         "Accept": "application/json",
  //         "Content-Type": "application/json"
  //       };
  //       var data = jsonEncode({'user_id': userId, 'email_verified': 1});

  //       var response = await http.post(
  //           Uri.parse('$baseApi/user/send-otp-in-mail/success'),
  //           headers: header,
  //           body: data);

  //       if (response.statusCode == 201) {
  //         Navigator.pushReplacement(
  //           context,
  //           MaterialPageRoute<void>(
  //             builder: (BuildContext context) => const LandingPage(),
  //           ),
  //         );
  //       } else {
  //         OthersHelper().showToast(
  //             'Your otp seems correct but something went wrong. Please try again later',
  //             Colors.black);
  //       }
  //     } else {
  //       OthersHelper().showToast('Otp didn\'t match', Colors.black);
  //     }
  //   } else {
  //     OthersHelper().showToast('Otp is null', Colors.black);
  //   }
  // }
}


// Navigator.pushReplacement(
//           context,
//           MaterialPageRoute<void>(
//             builder: (BuildContext context) => ResetPasswordPage(
//               email: email,
//             ),
//           ),
//         );