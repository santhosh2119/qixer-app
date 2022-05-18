import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qixer/model/service_extra_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;

class PersonalizationService with ChangeNotifier {
  var serviceExtraData;

  List includedList = [];

  bool isloading = true;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  increaseQuantity(index) {
    includedList[index]['qty'] = includedList[index]['qty'] + 1;
    notifyListeners();
  }

  decreaseQuantity(index) {
    if (includedList[index]['qty'] != 1) {
      includedList[index]['qty'] = includedList[index]['qty'] - 1;
      notifyListeners();
    }
  }

  fetchServiceExtra(serviceId) async {
    setLoadingTrue();
    var connection = await checkConnection();
    if (connection) {
      //internet connection is on
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        // "Content-Type": "application/json"
      };

      var response = await http.get(
          Uri.parse('$baseApi/service-list/service-book/$serviceId'),
          headers: header);

      if (response.statusCode == 201) {
        var data = ServiceExtraModel.fromJson(jsonDecode(response.body));

        //adding included list
        for (int i = 0; i < data.service.serviceInclude.length; i++) {
          includedList.add({
            'title': data.service.serviceInclude[i].includeServiceTitle,
            'price': data.service.serviceInclude[i].includeServicePrice,
            'qty': 1
          });
        }
        serviceExtraData = data;
        // var data = ServiceDetailsModel.fromJson(jsonDecode(response.body));

        notifyListeners();
        setLoadingFalse();
        // Future.delayed(Duration(microseconds: 500), () {
        //   isloading = true;
        // });
      } else {
        serviceExtraData == 'error';
        setLoadingFalse();
        OthersHelper().showToast('Something went wrong', Colors.black);
        notifyListeners();
      }
    }
  }
}
