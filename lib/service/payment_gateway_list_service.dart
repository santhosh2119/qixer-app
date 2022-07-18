import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/service/pay_services/payment_constants.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'common_service.dart';

class PaymentGatewayListService with ChangeNotifier {
  List paymentList = [
    // PayMethods('paypal', 'assets/icons/payment/paypal.png'),
    // PayMethods('cashfree', 'assets/icons/payment/cashfree.png'),
    // PayMethods('flutterwave', 'assets/icons/payment/flutterwave.png'),
    // PayMethods('instamojo', 'assets/icons/payment/instamojo.png'),
    // PayMethods('mercado', 'assets/icons/payment/mercado.png'),
    // PayMethods('midtrans', 'assets/icons/payment/midtrans.png'),
    // PayMethods('mollie', 'assets/icons/payment/mollie.png'),
    // PayMethods('payfast', 'assets/icons/payment/payfast.png'),
    // PayMethods('paystack', 'assets/icons/payment/paystack.png'),
    // PayMethods('paytm', 'assets/icons/payment/paytm.png'),
    // PayMethods('razorpay', 'assets/icons/payment/razorpay.png'),
    // PayMethods('stripe', 'assets/icons/payment/stripe.png'),
    // PayMethods('manual_payment', 'assets/icons/payment/bank_transfer.png'),
    // PayMethods('cash_on_delivery', 'assets/icons/payment/cash_on_delivery.png'),
  ];

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
        List gatewayList = jsonDecode(response.body)['gateway_list'];

        for (int i = 0; i < gatewayList.length; i++) {
          paymentList.add(
              PayMethods(gatewayList[i]['name'], gatewayList[i]['logo_link']));
        }
      } else {
        //something went wrong
        print(response.body);
      }
    } else {
      //internet off
      return false;
    }
  }
}

class PayMethods {
  final methodName;
  final image;

  PayMethods(this.methodName, this.image);
}
