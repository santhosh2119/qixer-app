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
  var categoryDropdownList = ['All'];
  var categoryDropdownIndexList = [-1];
  var selectedCategory = 'All';
  var selectedCategoryId = -1;

  var subcatDropdownList = ['All'];
  var subcatDropdownIndexList = [-1];
  var selectedSubcat = 'All';
  var selectedSubcatId = -1;

  var ratingDropdownList = ['5 Star', '4 Star', '3 Star', '2 Star', '1 Star'];
  var ratingDropdownIndexList = [5, 4, 3, 2, 1];
  var selectedRating = '5 Star';
  var selectedRatingId = '5';

  var sortbyDropdownList = ['Newest', 'Oldest'];
  var sortbyDropdownIndexList = [1, 2];
  var selectedSortby = 'Newest';
  var selectedSortbyId = 1;

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

  defaultSubcategory() {
    subcatDropdownList = ['All'];
    subcatDropdownIndexList = [-1];
    selectedSubcat = 'All';
    selectedSubcatId = -1;
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
    if (categoriesList.isNotEmpty && categoryDropdownList.length == 1) {
      for (int i = 0; i < categoriesList.length; i++) {
        categoryDropdownList.add(categoriesList[i].name);
        categoryDropdownIndexList.add(categoriesList[i].id);
      }
      Future.delayed(const Duration(microseconds: 500), () {
        notifyListeners();
      });

      // selectedCategory = categoriesList[0].name;
      // selectedCategoryId = categoriesList[0].id;

      //if all category is selected then don't load sub category
      if (categoryDropdownList.length != 1 && selectedCategoryId != -1) {
        fetchSubcategory(selectedCategoryId);
      }
    } else {
      //already showed in dropdown. no need to do anything

      // categoryDropdownList = [];
      // notifyListeners();
    }
  }

  fetchSubcategory(categoryId) async {
    //make sub category list to default first
    if (selectedCategoryId == -1) {
      defaultSubcategory();
    } else {
      // defaultSubcategory();

      if (selectedCategoryId != -1) {
        //this trick is only to show loading when category other than 'All' is selected
        subcatDropdownList = [];
        selectedSubcat = '';
        notifyListeners();
      }

      var response = await http
          .get(Uri.parse('$baseApi/category/sub-category/$categoryId'));

      if (response.statusCode == 200 || response.statusCode == 201) {
        defaultSubcategory();
        var data = SubcategoryModel.fromJson(jsonDecode(response.body));
        for (int i = 0; i < data.subCategories.length; i++) {
          subcatDropdownList.add(data.subCategories[i].name!);
          subcatDropdownIndexList.add(data.subCategories[i].id!);
        }

        // selectedSubcat = data.subCategories[0].name!;
        // selectedSubcatId = data.subCategories[0].id!;
        notifyListeners();
      } else {
        //error fetching data // no data found
        // subcatDropdownList = [];
        // notifyListeners();
        defaultSubcategory();
      }
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
      var response = await http.get(Uri.parse("${getApiLink()}?page=1"));

      if (response.statusCode == 201) {
        var data = ServiceByFilterModel.fromJson(jsonDecode(response.body));

        for (int i = 0; i < data.allServices.data.length; i++) {
          var serviceImage;

          if (data.serviceImage.length > i) {
            serviceImage = data.serviceImage[i].imgUrl;
          } else {
            serviceImage = null;
          }

          int totalRating = 0;
          for (int j = 0;
              j < data.allServices.data[i].reviewsForMobile.length;
              j++) {
            totalRating = totalRating +
                data.allServices.data[i].reviewsForMobile[j].rating!.toInt();
          }
          double averageRate = 0;

          if (data.allServices.data[i].reviewsForMobile.isNotEmpty) {
            averageRate = (totalRating /
                data.allServices.data[i].reviewsForMobile.length);
          }
          setServiceList(
              data.allServices.data[i].id,
              data.allServices.data[i].title,
              data.allServices.data[i].sellerForMobile.name,
              data.allServices.data[i].price,
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

  getApiLink() {
    if (selectedCategoryId == -1 && selectedSubcatId == -1) {
      //when no option is selected from dropdown
      return '$baseApi/service-list/all-services';
    } else if (selectedCategoryId != -1 && selectedSubcatId == -1) {
      //if only category is selected
      return '$baseApi/service-list/search-by-category/$selectedCategoryId/';
    } else {
      //else category and subcategory both is selected
      return '$baseApi/service-list/category-subcategory-search/$selectedCategoryId/$selectedSubcatId/';
    }
  }
}
