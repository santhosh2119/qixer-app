import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/auth/reset_password/reset_pass_otp_page.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;

class ResetPasswordService with ChangeNotifier {
  bool isloading = false;

  String? otpNumber;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  sendOtp(email, BuildContext context) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      OthersHelper()
          .showToast("Please turn on your internet connection", Colors.black);
      return false;
    } else {
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json"
      };
      var data = jsonEncode({
        'email': email,
      });

      setLoadingTrue();
      var response = await http.post(Uri.parse('$baseApi/send-otp-in-mail'),
          headers: header, body: data);
      if (response.statusCode == 201) {
        otpNumber = jsonDecode(response.body)['otp'];
        print('otp is $otpNumber');
        notifyListeners();
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const ResetPassOtpPage(),
          ),
        );
        setLoadingFalse();
      } else {
        OthersHelper()
            .showToast(jsonDecode(response.body)['message'], Colors.black);
        setLoadingFalse();
      }
    }
  }
}
