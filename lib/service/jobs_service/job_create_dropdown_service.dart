// ignore_for_file: prefer_typing_uninitialized_variables, avoid_print

import 'package:flutter/material.dart';

class JobCreateDropdownService with ChangeNotifier {
  var categoryDropdownList = ['Category1'];
  var categoryDropdownIndexList = ['1'];
  var selectedCategory = 'Category1';
  var selectedCategoryId;

  setCategoryValue(value) {
    selectedCategory = value;
    notifyListeners();
  }

  setSelectedCategoryId(value) {
    selectedCategoryId = value;
    print('selected category id $value');
    notifyListeners();
  }

  // sub category
  // ==============>

  var subCategoryDropdownList = ['subcat'];
  var subCategoryDropdownIndexList = ['1'];
  var selectedSubCategory = 'subcat';
  var selectedsubCategoryId;

  setSubCategoryValue(value) {
    selectedSubCategory = value;
    notifyListeners();
  }

  setSelectedSubCategoryId(value) {
    selectedsubCategoryId = value;
    print('selected subCategory id $value');
    notifyListeners();
  }

  // Country
  // ==============>

  var countryDropdownList = ['country'];
  var countryDropdownIndexList = ['1'];
  var selectedCountry = 'country';
  var selectedCountryId;

  setCountryValue(value) {
    selectedCountry = value;
    notifyListeners();
  }

  setSelectedCountryId(value) {
    selectedCountryId = value;
    print('selected country id $value');
    notifyListeners();
  }

  // Country
  // ==============>

  var cityDropdownList = ['city'];
  var cityDropdownIndexList = ['1'];
  var selectedCity = 'city';
  var selectedCityId;

  setCityValue(value) {
    selectedCity = value;
    notifyListeners();
  }

  setSelectedCityId(value) {
    selectedCityId = value;
    print('selected city id $value');
    notifyListeners();
  }
}
