// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/order_details_model.dart';
import 'package:qixer/model/order_extra_model.dart';
import 'package:qixer/service/payment_gateway_list_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'common_service.dart';

class OrderDetailsService with ChangeNotifier {
  var orderDetails;

  var orderStatus;

  List orderExtra = [];

  bool isLoading = true;

  setLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  fetchOrderDetails(orderId, BuildContext context) async {
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
    if (connection) {
      //if connection is ok

      setLoadingStatus(true);
      var response = await http
          .post(Uri.parse('$baseApi/user/my-orders/$orderId'), headers: header);

      if (response.statusCode == 201) {
        print(response.body);
        var data = OrderDetailsModel.fromJson(jsonDecode(response.body));
        print(data);
        orderDetails = data.orderInfo;

        var status = data.orderInfo.status;

        orderStatus = getOrderStatus(status ?? -1);

        Provider.of<OrderDetailsService>(context, listen: false)
            .fetchOrderExtraList(orderId);

        notifyListeners();
        return orderDetails;
      } else {
        //Something went wrong
        orderDetails = 'error';
        notifyListeners();
        return orderDetails;
      }
    }
  }

  //fetch order extra list
  fetchOrderExtraList(orderId) async {
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
    if (connection) {
      //if connection is ok
      var response = await http.get(
          Uri.parse('$baseApi/user/order/extra-service/list/$orderId'),
          headers: header);

      final decodedData = jsonDecode(response.body);

      setLoadingStatus(false);

      print(response.body);

      if (response.statusCode == 201 &&
          decodedData.containsKey('extra_service_list')) {
        var data = OrderExtraModel.fromJson(decodedData);

        orderExtra = data.extraServiceList;

        notifyListeners();
      } else {
        print('error fetching order extra ${response.body}');
      }
    }
  }

  var selectedExtraId;
  var selectedOrderIdForExtra;
  var selectedExtraPrice;

  setExtraDetails({required orderId, required extraId, required extraPrice}) {
    selectedOrderIdForExtra = orderId;
    selectedExtraId = extraId;
    selectedExtraPrice = extraPrice;
    notifyListeners();
  }

  //============>
  acceptOrderExtra(BuildContext context) async {
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
    if (connection) {
      //if connection is ok

      var selectedPayment =
          Provider.of<PaymentGatewayListService>(context, listen: false)
              .selectedMethodName;

      var data = jsonEncode({
        'id': selectedExtraId,
        'order_id': selectedOrderIdForExtra,
        'selected_payment_gateway': selectedPayment,
      });

      var response = await http.post(
          Uri.parse('$baseApi/user/order/extra-service/accept'),
          headers: header,
          body: data);

      final decodedData = jsonDecode(response.body);

      setLoadingStatus(false);

      print(response.body);

      if (response.statusCode == 201) {
        print('order extra accepted');
        Navigator.pop(context);
      } else {
        print('error accepting order extra ${response.body}');
      }
    }
  }

  //==============>

  declineOrderExtra({required extraId, required orderId}) async {
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
    if (connection) {
      //if connection is ok

      // setLoadingStatus(true);

      var data = jsonEncode({'id': extraId, 'order_id': orderId});

      var response = await http.post(
          Uri.parse('$baseApi/user/order/extra-service/decline'),
          headers: header,
          body: data);

      print('extra id $extraId');
      print('order id $orderId');

      return;

      // final decodedData = jsonDecode(response.body);

      print(response.body);
      print(response.statusCode);

      setLoadingStatus(false);

      // if (response.statusCode == 201 &&
      //     decodedData.containsKey('extra_service_list')) {
      //   var data = OrderExtraModel.fromJson(decodedData);

      //   orderExtra = data.extraServiceList;

      //   notifyListeners();
      // } else {
      //   print('error fetching order extra ${response.body}');
      // }
    }
  }

  //=========>

  getOrderStatus(int status) {
    if (status == 0) {
      return 'Pending';
    } else if (status == 1) {
      return 'Active';
    } else if (status == 2) {
      return "Completed";
    } else if (status == 3) {
      return "Delivered";
    } else if (status == 4) {
      return 'Cancelled';
    } else {
      return 'Unknown';
    }
  }
}
