import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qixer/model/service_details_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

class ServiceDetailsService with ChangeNotifier {
  var serviceAllDetails;

  bool isloading = false;

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  fetchServiceDetails(serviceId) async {
    setLoadingTrue();
    var connection = await checkConnection();
    if (connection) {
      //internet connection is on
      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        // "Content-Type": "application/json"
      };

      var response = await http.get(Uri.parse('$baseApi/service-details/1'),
          headers: header);

      if (response.statusCode == 201) {
        serviceAllDetails =
            ServiceDetailsModel.fromJson(jsonDecode(response.body));
        // var data = ServiceDetailsModel.fromJson(jsonDecode(response.body));

        notifyListeners();
        setLoadingFalse();
      } else {
        serviceAllDetails == 'error';
        setLoadingFalse();
        OthersHelper().showToast('Something went wrong', Colors.black);
        notifyListeners();
      }
    }
  }
}
