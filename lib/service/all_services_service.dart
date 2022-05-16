import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/service_by_filter_model.dart';
import 'package:qixer/model/sub_category_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/db/db_service.dart';
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

  var serviceMap = [];
  bool alreadySaved = false;
  fetchCategories(BuildContext context) async {
    var categoriesList = Provider.of<CategoryService>(context, listen: false)
        .categoriesDropdownList;
    if (categoriesList.isNotEmpty && categoryDropdownList.isEmpty) {
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
      //already showed in dropdown. no need to do anything

      // categoryDropdownList = [];
      // notifyListeners();
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

  fetchServiceByFilter() async {
    serviceMap = [];
    Future.delayed(const Duration(microseconds: 500), () {
      notifyListeners();
    });
    var connection = await checkConnection();
    if (connection) {
      //if connection is ok
      var response = await http.get(Uri.parse(
          '$baseApi/service-list/category-subcategory-search/$selectedCategoryId/$selectedSubcatId'));

      if (response.statusCode == 201) {
        var data = ServiceByFilterModel.fromJson(jsonDecode(response.body));

        for (int i = 0; i < data.allServices.length; i++) {
          var serviceImage;

          if (data.serviceImage.length > i) {
            serviceImage = data.serviceImage[i].imgUrl;
          } else {
            serviceImage = null;
          }

          int totalRating = 0;
          for (int j = 0;
              j < data.allServices[i].reviewsForMobile.length;
              j++) {
            totalRating = totalRating +
                data.allServices[i].reviewsForMobile[j].rating!.toInt();
          }
          double averageRate = 0;

          if (data.allServices[i].reviewsForMobile.isNotEmpty) {
            averageRate =
                (totalRating / data.allServices[i].reviewsForMobile.length);
          }
          setServiceList(
              data.allServices[i].id,
              data.allServices[i].title,
              data.allServices[i].sellerForMobile.name,
              data.allServices[i].price,
              averageRate,
              serviceImage,
              i);
        }

        notifyListeners();
      } else {
        //Something went wrong
        serviceMap.add('error');
        notifyListeners();
      }
    }
  }

  setServiceList(serviceId, title, sellerName, price, rating, image, index) {
    serviceMap.add({
      'serviceId': serviceId,
      'title': title,
      'sellerName': sellerName,
      'price': price,
      'rating': rating,
      'image': image,
      'isSaved': false,
    });
    checkIfAlreadySaved(serviceId, title, sellerName, index);
  }

  checkIfAlreadySaved(serviceId, title, sellerName, index) async {
    var newListMap = serviceMap;
    alreadySaved = await DbService().checkIfSaved(serviceId, title, sellerName);
    newListMap[index]['isSaved'] = alreadySaved;
    serviceMap = newListMap;
    notifyListeners();
  }

  saveOrUnsave(int serviceId, String title, String image, int price,
      String sellerName, double rating, int index, BuildContext context) async {
    var newListMap = serviceMap;
    alreadySaved = await DbService().saveOrUnsave(
        serviceId, title, image, price, sellerName, rating, context);
    newListMap[index]['isSaved'] = alreadySaved;
    serviceMap = newListMap;
    notifyListeners();
  }
}
