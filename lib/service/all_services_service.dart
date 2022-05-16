import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/sub_category_model.dart';
import 'package:qixer/service/home_services/category_service.dart';
import 'package:http/http.dart' as http;
import 'package:qixer/view/utils/others_helper.dart';

class AllServicesService with ChangeNotifier {
  var categoryDropdownList = [];
  var categoryDropdownIndexList = [];
  var selectedCategory;
  var selectedCategoryId;

  var subcatDropdownList = [];
  var subcatDropdownIndexList = [];
  var selectedSubcat;
  var selectedSubcatId;

  var ratingDropdownList = ['5 Star', '4 Star', '3 Star', '2 Star', '1 Star'];
  var ratingDropdownIndexList = ['5', '4', '3', '2', '1'];
  var selectedRating = '5 Star';
  var selectedRatingId = '5';

  var sortbyDropdownList = ['Newest', 'Oldest'];
  var sortbyDropdownIndexList = ['1', '2'];
  var selectedSortby = 'Newest';
  var selectedSortbyId = '1';

  bool isLoading = false;

  setCategoryValue(value) {
    selectedCategory = value;
    notifyListeners();
  }

  setSubcatValue(value) {
    selectedSubcat = value;
    notifyListeners();
  }

  setRatingValue(value) {
    selectedRating = value;
    notifyListeners();
  }

  setSortbyValue(value) {
    selectedSortby = value;
    notifyListeners();
  }

  setSelectedCategoryId(value) {
    selectedCategoryId = value;
    notifyListeners();
  }

  setSelectedSubcatsId(value) {
    selectedSubcatId = value;
    notifyListeners();
  }

  setSelectedRatingId(value) {
    selectedRatingId = value;
    notifyListeners();
  }

  setSelectedSortbyId(value) {
    selectedSortbyId = value;
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

  fetchCategories(BuildContext context) async {
    var categoriesList = Provider.of<CategoryService>(context, listen: false)
        .categoriesDropdownList;
    if (categoriesList.isNotEmpty) {
      for (int i = 0; i < categoriesList.length; i++) {
        categoryDropdownList.add(categoriesList[i].name);
        categoryDropdownIndexList.add(categoriesList[i].id);
      }

      selectedCategory = categoriesList[0].name;
      selectedCategoryId = categoriesList[0].id;
      Future.delayed(const Duration(microseconds: 500), () {
        notifyListeners();
      });
      fetchSubcategory(selectedCategoryId);
    } else {
      //error fetching data
      categoryDropdownList = [];
      notifyListeners();
    }
  }

  fetchSubcategory(categoryId) async {
    //make states list empty first
    subcatDropdownList = [];
    subcatDropdownIndexList = [];
    Future.delayed(const Duration(microseconds: 500), () {
      notifyListeners();
    });

    var response =
        await http.get(Uri.parse('$baseApi/category/sub-category/$categoryId'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = SubcategoryModel.fromJson(jsonDecode(response.body));
      for (int i = 0; i < data.subCategories.length; i++) {
        subcatDropdownList.add(data.subCategories[i].name);
        subcatDropdownIndexList.add(data.subCategories[i].id);
      }

      selectedSubcat = data.subCategories[0].name;
      selectedSubcatId = data.subCategories[0].id;
      notifyListeners();
    } else {
      //error fetching data
      subcatDropdownList = [];
      notifyListeners();
    }
  }
}
