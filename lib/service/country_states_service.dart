import 'package:flutter/material.dart';

class CountryStatesService with ChangeNotifier {
  var countryDropdown = ['America', 'Bangladesh', 'Malaysia'];
  var selectedCountry = 'America';

  var statesDropdown = ['New york', 'Banasree', 'Lalbag'];
  var selectedStates = 'New york';

  var areaDropdown = ['Block A', 'Block B', 'Block C'];
  var selectedArea = 'Block A';

  bool isLoading = false;

  setCountryValue(value) {
    selectedCountry = value;
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
}
