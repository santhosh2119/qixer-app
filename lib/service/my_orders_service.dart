import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:qixer/model/my_orders_list_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyOrdersService with ChangeNotifier {
  var myServices;

  bool isLoading = true;

  setLoadingTrue() {
    Future.delayed(Duration(seconds: 1), () {
      isLoading = true;
    });
  }

  fetchMyOrders() async {
    //get user id
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');

    var connection = await checkConnection();
    if (connection) {
      //if connection is ok
      var response = await http.get(Uri.parse('$baseApi/my-orders/$userId'));

      if (response.statusCode == 201) {
        var data = MyordersListModel.fromJson(jsonDecode(response.body));
        print(data);
        myServices = data.myOrders;
        isLoading = false;
        notifyListeners();
        setLoadingTrue();
      } else {
        //Something went wrong
        myServices = 'error';
        isLoading = false;
        notifyListeners();
        setLoadingTrue();
      }
    }
  }
}
