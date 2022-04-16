import 'package:flutter/material.dart';

class AllServicesService with ChangeNotifier {
  var categoryDropdown = ['America', 'Bangladesh', 'Malaysia'];
  var selectedCategory = 'America';

  var subCategoryDropdown = ['New york', 'Banasree', 'Lalbag'];
  var selectedSubCategory = 'New york';

  var ratingsDropdown = ['Block A', 'Block B', 'Block C'];
  var selectedRatings = 'Block A';

  var sortByDropdown = ['Newest', 'Older'];
  var selectedSortBy = 'Newest';

  bool isLoading = false;

  setCategoryValue(value) {
    selectedCategory = value;
    notifyListeners();
  }

  setSubCategoryValue(value) {
    selectedSubCategory = value;
    notifyListeners();
  }

  setRatingsValue(value) {
    selectedRatings = value;
    notifyListeners();
  }

  setSortByValue(value) {
    selectedSortBy = value;
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
