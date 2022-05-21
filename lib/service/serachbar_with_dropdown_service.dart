import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:qixer/model/all_city_dropdown_model.dart';
import 'package:qixer/model/search_bar_with_dropdown_service_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/db/db_service.dart';
import 'package:qixer/view/utils/others_helper.dart';

class SearchBarWithDropdownService with ChangeNotifier {
  var serviceMap = [];

  var cityDropdownList = [
    'Select City',
  ];
  var selectedCity = 'Select City';
  var cityDropdownIndexList = [0];
  var selectedCityId = 0;

  bool isLoading = false;
  bool alreadySaved = false;

  List averageRateList = [];
  List imageList = [];

  int currentPage = 1;
  late int totalPages;

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

  setLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  setCurrentPage(newValue) {
    currentPage = newValue;
    notifyListeners();
  }

  setTotalPage(newPageNumber) {
    totalPages = newPageNumber;
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

  // fetchService(context, {bool isrefresh = false}) async{
  //    if (isrefresh) {
  //     //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
  //     //we are make the list empty when the sub category or brand is selected because then the refresh is true
  //     serviceMap = [];
  //     notifyListeners();

  //     Provider.of<SearchBarWithDropdownService>(context, listen: false)
  //         .setCurrentPage(currentPage);
  //   } else {
  //     // if (currentPage > 2) {
  //     //   refreshController.loadNoData();
  //     //   return false;
  //     // }
  //   }
  //   // serviceMap = [];
  //   // Future.delayed(const Duration(microseconds: 500), () {
  //   //   notifyListeners();
  //   // });
  //   var connection = await checkConnection();
  //   if (connection) {
  //     //if connection is ok
  //     var response = await http.get(Uri.parse(
  //         "$baseApi/home/home-search"));

  //     if (response.statusCode == 201) {
  //       var data = SearchBarWithDropdownServiceModel.fromJson(jsonDecode(response.body));

  //       setTotalPage(data.allServices.lastPage);

  //       for (int i = 0; i < data.allServices.data.length; i++) {
  //         var serviceImage;

  //         if (data.serviceImage.length > i) {
  //           serviceImage = data.serviceImage[i].imgUrl;
  //         } else {
  //           serviceImage = null;
  //         }

  //         int totalRating = 0;
  //         for (int j = 0;
  //             j < data.allServices.data[i].reviewsForMobile.length;
  //             j++) {
  //           totalRating = totalRating +
  //               data.allServices.data[i].reviewsForMobile[j].rating!.toInt();
  //         }
  //         double averageRate = 0;

  //         if (data.allServices.data[i].reviewsForMobile.isNotEmpty) {
  //           averageRate = (totalRating /
  //               data.allServices.data[i].reviewsForMobile.length);
  //         }
  //         averageRateList.add(averageRate);
  //         imageList.add(serviceImage);

  //       }

  //       if (isrefresh) {
  //         print('refresh true');
  //         //if refreshed, then remove all service from list and insert new data
  //         setServiceList(
  //             data.allServices.data, averageRateList, imageList, false);
  //       } else {
  //         print('add new data');

  //         //else add new data
  //         setServiceList(
  //             data.allServices.data, averageRateList, imageList, true);
  //       }

  //       currentPage++;
  //       setCurrentPage(currentPage);
  //       return true;
  //     } else {
  //       print(response.body);
  //       // serviceMap = [];
  //       serviceMap.add('error');
  //       //No more data
  //       //Something went wrong
  //       // serviceMap.add('error');
  //       // notifyListeners();
  //       return false;
  //     }
  //   }
  // }

  //   saveOrUnsave(
  //     int serviceId,
  //     String title,
  //     String image,
  //     int price,
  //     String sellerName,
  //     double rating,
  //     int index,
  //     BuildContext context,
  //     sellerId) async {
  //   var newListMap = serviceMap;
  //   alreadySaved = await DbService().saveOrUnsave(
  //       serviceId, title, image, price, sellerName, rating, context, sellerId);
  //   newListMap[index]['isSaved'] = alreadySaved;
  //   serviceMap = newListMap;
  //   notifyListeners();
  // }

  //   setServiceList(data, averageRateList, imageList, bool addnewData) {
  //   if (addnewData == false) {
  //     //make the list empty first so that existing data doesn't stay
  //     serviceMap = [];
  //     notifyListeners();
  //   }

  //   for (int i = 0; i < data.length; i++) {
  //     serviceMap.add({
  //       'serviceId': data[i].id,
  //       'title': data[i].title,
  //       'sellerName': data[i].sellerForMobile.name,
  //       'price': data[i].price,
  //       'rating': averageRateList[i],
  //       'image': imageList[i],
  //       'isSaved': false,
  //       'sellerId': data[i].sellerId,
  //     });
  //     checkIfAlreadySaved(data[i].id, data[i].title,
  //         data[i].sellerForMobile.name, serviceMap.length - 1);
  //   }
  // }

  //   checkIfAlreadySaved(serviceId, title, sellerName, index) async {
  //   var newListMap = serviceMap;
  //   alreadySaved = await DbService().checkIfSaved(serviceId, title, sellerName);
  //   newListMap[index]['isSaved'] = alreadySaved;
  //   serviceMap = newListMap;
  //   notifyListeners();
  // }

}
