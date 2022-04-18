import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:qixer/model/country_dropdown_model.dart';
import 'package:qixer/view/utils/others_helper.dart';

class CountryStatesService with ChangeNotifier {
  var countryDropdownList = [];
  var countryDropdownIndexList = [];
  var selectedCountry;
  var selectedCountryId;

  var statesDropdown = ['New york', 'Banasree', 'Lalbag'];
  var selectedStates = 'New york';

  var areaDropdown = ['Block A', 'Block B', 'Block C'];
  var selectedArea = 'Block A';

  bool isLoading = false;

  setCountryValue(value) {
    selectedCountry = value;
    notifyListeners();
  }

  setSelectedCountryId(value) {
    selectedCountryId = value;
    notifyListeners();
  }

  setStatesValue(value) {
    selectedStates = value;
    notifyListeners();
  }

  setAreaValue(value) {
    selectedArea = value;
    notifyListeners();
  }

  setLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  fetchCountries() async {
    Future.delayed(const Duration(milliseconds: 500), () {
      setLoadingTrue();
    });
    var response = await http.get(Uri.parse('$baseApi/country'));
    var data = CountryDropdownModel.fromJson(jsonDecode(response.body));
    for (int i = 0; i < data.countries.length; i++) {
      countryDropdownList.add(data.countries[i].country);
      countryDropdownIndexList.add(data.countries[i].id);
    }

    selectedCountry = data.countries[0].country;
    selectedCountryId = data.countries[0].id;

    notifyListeners();
  }
}
