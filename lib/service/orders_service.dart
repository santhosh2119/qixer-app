import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/order_details_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrdersService with ChangeNotifier {
  bool markLoading = false;

  setMarkLoadingStatus(bool status) {
    markLoading = status;
    notifyListeners();
  }

  completeOrder(BuildContext context, {required orderId}) async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      //if header type is application/json then the data should be in jsonEncode method
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var connection = await checkConnection();
    if (!connection) return;

    setMarkLoadingStatus(true);

    var data = jsonEncode({'order_id': orderId});

    var response = await http.post(
        Uri.parse('$baseApi/user/order/request/status/complete/approve'),
        headers: header,
        body: data);

    final decodedData = jsonDecode(response.body);

    if (response.statusCode == 201) {
      setMarkLoadingStatus(false);
      OthersHelper().showToast(decodedData['msg'], Colors.black);

      Future.delayed(const Duration(microseconds: 600), () async {
        Provider.of<OrderDetailsService>(context, listen: false)
            .fetchOrderDetails(orderId, context, isFromOrderComplete: true);
      });
    } else {
      setMarkLoadingStatus(false);

      if (decodedData.containsKey('msg')) {
        OthersHelper().showToast(decodedData['msg'], Colors.black);
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
      }
    }
  }
}
