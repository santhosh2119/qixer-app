import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qixer/model/top_service_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;

class TopRatedServicesSerivce with ChangeNotifier {
  var topService;

  List imageList = [];
  List ratingList = [];
  // List reviewerImgList = [];

  fetchTopService() async {
    if (topService == null) {
      var connection = await checkConnection();
      if (connection) {
        //if connection is ok
        var response = await http.get(Uri.parse('$baseApi/top-services'));

        if (response.statusCode == 201) {
          topService = TopServiceModel.fromJson(jsonDecode(response.body));

          for (int i = 0; i < topService.serviceImage.length; i++) {
            imageList.add(topService.serviceImage[i].imgUrl);
            // reviewerImgList.add(topService.reviewerImage[i].imgUrl);
            int totalRating = 0;
            for (int j = 0;
                j < topService.topServices[i].reviewsForMobile.length;
                j++) {
              totalRating = totalRating +
                  topService.topServices[i].reviewsForMobile[j].rating as int;
            }
            var averageRate = (totalRating /
                topService.topServices[i].reviewsForMobile.length);
            ratingList.add(averageRate);

            // print(averageRate);
          }
          notifyListeners();
        } else {
          //Something went wrong
          topService == 'error';
        }
      }
    } else {
      //already loaded from api
    }
  }
}
