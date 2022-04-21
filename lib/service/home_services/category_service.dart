import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qixer/model/categoryModel.dart';
import 'package:qixer/view/utils/others_helper.dart';

class CategoryService with ChangeNotifier {
  var categories;

  fetchCategory() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      OthersHelper()
          .showToast("Please turn on your internet connection", Colors.black);
      return false;
    } else {
      var response = await http.get(Uri.parse('$baseApi/category'));

      if (response.statusCode == 201) {
        categories = CategoryModel.fromJson(jsonDecode(response.body));

        notifyListeners();
      } else {
        //Something went wrong
        categories == 'error';
      }
    }
  }
}
