import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/model/all_city_dropdown_model.dart';
import 'package:qixer/view/utils/others_helper.dart';

class SearchBarWithDropdownService with ChangeNotifier {
  var serviceMap = [];

  var cityDropdownList = [
    'Select City',
  ];
  var selectedCity = 'Select City';
  var cityDropdownIndexList = [0];
  var selectedCityId = 0;

  setCityValue(value) {
    selectedCity = value;
    print('selected city $selectedCity');
    notifyListeners();
  }

  setSelectedCityId(value) {
    selectedCityId = value;
    print('selected city id $selectedCityId');
    notifyListeners();
  }

  fetchCountries() async {
    if (cityDropdownList.length < 2) {
      var response = await http.get(Uri.parse('$baseApi/city/service-city'));

      if (response.statusCode == 201) {
        var data = AllCityDropdownModel.fromJson(jsonDecode(response.body));
        for (int i = 0; i < data.serviceCity.length; i++) {
          cityDropdownList.add(data.serviceCity[i].serviceCity);
          cityDropdownIndexList.add(data.serviceCity[i].id);
        }

        notifyListeners();
      } else {
        //error fetching data
        cityDropdownList = [];
        notifyListeners();
      }
    } else {
      //country list already loaded from api
    }
  }
}
