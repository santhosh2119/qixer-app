import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;

class RtlService with ChangeNotifier {
  /// RTL support
  var rtl = 'l';

  String currency = '\$';
  String currencyDirection = 'left';

  bool alreadyCurrencyLoaded = false;

  fetchCurrency() async {
    if (alreadyCurrencyLoaded == false) {
      var response = await http.get(Uri.parse('$baseApi/get-currency-symbol'));
      if (response.statusCode == 201) {
        currency = jsonDecode(response.body)['currency']['symbol'];
        currencyDirection = jsonDecode(response.body)['currency']['position'];
        alreadyCurrencyLoaded == true;
        notifyListeners();
      } else {
        print('failed loading currency');
        print(response.body);
      }
    } else {
      //already loaded from server. no need to load again
    }
  }
}
