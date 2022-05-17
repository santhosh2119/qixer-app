import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qixer/model/service_extra_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;

class PersonalizationService with ChangeNotifier {
  var serviceExtraData;

  bool isloading = true;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
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
          Uri.parse('$baseApi/service-list/service-book/7'),
          headers: header);

      if (response.statusCode == 201) {
        serviceExtraData =
            ServiceExtraModel.fromJson(jsonDecode(response.body));
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
