import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qixer/model/recent_service_model.dart';
import 'package:qixer/model/serviceby_category_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/service/db/db_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;

class ServiceByCategoryService with ChangeNotifier {
  var categoryServiceMap = [];
  bool alreadySaved = false;

  makeListEmpty() {
    categoryServiceMap = [];
    notifyListeners();
  }

  fetchCategoryService(categoryId) async {
    if (categoryServiceMap.isEmpty) {
      var connection = await checkConnection();
      if (connection) {
        //if connection is ok
        var response = await http.get(
            Uri.parse('$baseApi/service-list/search-by-category/$categoryId'));

        if (response.statusCode == 201) {
          var data = ServicebyCategoryModel.fromJson(jsonDecode(response.body));

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
                i,
                data.allServices[i].sellerId);

            // print(averageRate);
          }
          notifyListeners();
        } else {
          //Something went wrong
          categoryServiceMap.add('error');
          notifyListeners();
        }
      }
    } else {
      //already loaded from api
    }
  }

  setServiceList(
      serviceId, title, sellerName, price, rating, image, index, sellerId) {
    categoryServiceMap.add({
      'serviceId': serviceId,
      'title': title,
      'sellerName': sellerName,
      'price': price,
      'rating': rating,
      'image': image,
      'isSaved': false,
      'sellerId': sellerId,
    });

    checkIfAlreadySaved(serviceId, title, sellerName, index);
  }

  checkIfAlreadySaved(serviceId, title, sellerName, index) async {
    var newListMap = categoryServiceMap;
    alreadySaved = await DbService().checkIfSaved(serviceId, title, sellerName);
    newListMap[index]['isSaved'] = alreadySaved;
    categoryServiceMap = newListMap;
    notifyListeners();
  }

  saveOrUnsave(
      int serviceId,
      String title,
      String image,
      int price,
      String sellerName,
      double rating,
      int index,
      BuildContext context,
      sellerId) async {
    var newListMap = categoryServiceMap;
    alreadySaved = await DbService().saveOrUnsave(
        serviceId, title, image, price, sellerName, rating, context, sellerId);
    newListMap[index]['isSaved'] = alreadySaved;
    categoryServiceMap = newListMap;
    notifyListeners();
  }

  categoryServiceSaveUnsaveFromOtherPage(
    int serviceId,
    String title,
    String sellerName,
  ) async {
    int? index;
    for (int i = 0; i < categoryServiceMap.length; i++) {
      if (categoryServiceMap[i]['serviceId'] == serviceId &&
          categoryServiceMap[i]['title'] == title &&
          categoryServiceMap[i]['sellerName'] == sellerName) {
        index = i;
        break;
      }
    }

    if (index != null) {
      //if that product exist in other page then change the saved button accordingly
      var newListMap = categoryServiceMap;
      alreadySaved =
          await DbService().checkIfSaved(serviceId, title, sellerName);
      newListMap[index]['isSaved'] = alreadySaved;
      categoryServiceMap = newListMap;
      notifyListeners();
    }
  }
}
