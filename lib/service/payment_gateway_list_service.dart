// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/service/pay_services/payment_constants.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common_service.dart';

class PaymentGatewayListService with ChangeNotifier {
  List paymentList = [];
  bool? isTestMode;
  var publicKey;
  var secretKey;

  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  Future fetchGatewayList() async {
    //if payment list already loaded, then don't load again
    if (paymentList.isNotEmpty) {
      return;
    }

    var connection = await checkConnection();
    if (connection) {
      setLoadingTrue();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.post(
          Uri.parse('$baseApi/user/payment-gateway-list'),
          headers: header);

      setLoadingFalse();

      if (response.statusCode == 201) {
        paymentList = jsonDecode(response.body)['gateway_list'];
      } else {
        //something went wrong
        print(response.body);
      }
    } else {
      //internet off
      return false;
    }
  }

  //set clientId or secretId
  //==================>
  setKey(String methodName) {
    switch (methodName) {
      case 'paypal':
        for (int i = 0; i < paymentList.length; i++) {
          if (paymentList[i]['name'] == 'paypal') {
            publicKey = paymentList[i]['client_id'];
            secretKey = paymentList[i]['secret_id'];
            isTestMode = secretKey = paymentList[i]['test_mode'];
            break;
          }
        }
        break;

      case 'cashfree':
        for (int i = 0; i < paymentList.length; i++) {
          if (paymentList[i]['name'] == 'cashfree') {
            publicKey = paymentList[i]['app_id'];
            secretKey = paymentList[i]['secret_key'];
            isTestMode = secretKey = paymentList[i]['test_mode'];
            break;
          }
        }
        break;

      case 'flutterwave':
        for (int i = 0; i < paymentList.length; i++) {
          if (paymentList[i]['name'] == 'flutterwave') {
            publicKey = paymentList[i]['public_key'];
            secretKey = paymentList[i]['secret_key'];
            isTestMode = secretKey = paymentList[i]['test_mode'];
            break;
          }
        }
        break;

      case 'instamojo':
        for (int i = 0; i < paymentList.length; i++) {
          if (paymentList[i]['name'] == 'instamojo') {
            publicKey = paymentList[i]['client_id'];
            secretKey = paymentList[i]['client_secret'];
            isTestMode = secretKey = paymentList[i]['test_mode'];
            break;
          }
        }
        break;

      case 'marcadopago':
        for (int i = 0; i < paymentList.length; i++) {
          if (paymentList[i]['name'] == 'marcadopago') {
            publicKey = paymentList[i]['client_id'];
            secretKey = paymentList[i]['client_secret'];
            isTestMode = secretKey = paymentList[i]['test_mode'];
            break;
          }
        }
        break;

      case 'midtrans':
        for (int i = 0; i < paymentList.length; i++) {
          if (paymentList[i]['name'] == 'midtrans') {
            publicKey = paymentList[i]['merchant_id'];
            secretKey = paymentList[i]['server_key'];
            isTestMode = secretKey = paymentList[i]['test_mode'];
            break;
          }
        }
        break;

      case 'mollie':
        for (int i = 0; i < paymentList.length; i++) {
          if (paymentList[i]['name'] == 'mollie') {
            publicKey = paymentList[i]['public_key'];
            secretKey = '';
            isTestMode = secretKey = paymentList[i]['test_mode'];
            break;
          }
        }
        break;

      case 'payfast':
        for (int i = 0; i < paymentList.length; i++) {
          if (paymentList[i]['name'] == 'payfast') {
            publicKey = paymentList[i]['merchant_id'];
            secretKey = paymentList[i]['merchant_key'];
            isTestMode = secretKey = paymentList[i]['test_mode'];
            break;
          }
        }
        break;

      case 'paystack':
        for (int i = 0; i < paymentList.length; i++) {
          if (paymentList[i]['name'] == 'paystack') {
            publicKey = paymentList[i]['public_key'];
            secretKey = paymentList[i]['secret_key'];
            isTestMode = secretKey = paymentList[i]['test_mode'];
            break;
          }
        }
        break;

      case 'paytm':
        for (int i = 0; i < paymentList.length; i++) {
          if (paymentList[i]['name'] == 'paytm') {
            publicKey = paymentList[i]['merchant_key'];
            secretKey = paymentList[i]['merchant_mid'];
            isTestMode = secretKey = paymentList[i]['test_mode'];
            break;
          }
        }
        break;

      case 'razorpay':
        for (int i = 0; i < paymentList.length; i++) {
          if (paymentList[i]['name'] == 'razorpay') {
            publicKey = paymentList[i]['api_key'];
            secretKey = paymentList[i]['api_secret'];
            isTestMode = secretKey = paymentList[i]['test_mode'];
            break;
          }
        }
        break;

      case 'stripe':
        for (int i = 0; i < paymentList.length; i++) {
          if (paymentList[i]['name'] == 'stripe') {
            publicKey = paymentList[i]['public_key'];
            secretKey = paymentList[i]['secret_key'];
            isTestMode = secretKey = paymentList[i]['test_mode'];
            break;
          }
        }
        break;

      case 'manual_payment':
        for (int i = 0; i < paymentList.length; i++) {
          if (paymentList[i]['name'] == 'manual_payment') {
            publicKey = '';
            secretKey = '';
            isTestMode = secretKey = paymentList[i]['test_mode'];
            break;
          }
        }
        break;

      case 'cash_on_delivery':
        for (int i = 0; i < paymentList.length; i++) {
          if (paymentList[i]['name'] == 'cash_on_delivery') {
            publicKey = '';
            secretKey = '';
            isTestMode = secretKey = paymentList[i]['test_mode'];
            break;
          }
        }
        break;

      //switch end
    }
  }
}
