import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qixer/model/recent_service_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;

class RecentServicesService with ChangeNotifier {
  var recentService;

  List imageList = [];
  List ratingList = [];
  // List reviewerImgList = [];

  fetchRecentService() async {
    if (recentService == null) {
      var connection = await checkConnection();
      if (connection) {
        //if connection is ok
        var response = await http.get(Uri.parse('$baseApi/latest-services'));

        if (response.statusCode == 201) {
          recentService =
              RecentServiceModel.fromJson(jsonDecode(response.body));

          for (int i = 0; i < recentService.serviceImage.length; i++) {
            imageList.add(recentService.serviceImage[i].imgUrl);
            // reviewerImgList.add(recentService.reviewerImage[i].imgUrl);
            int totalRating = 0;
            for (int j = 0;
                j < recentService.latestServices[i].reviewsForMobile.length;
                j++) {
              totalRating = totalRating +
                      recentService.latestServices[i].reviewsForMobile[j].rating
                  as int;
            }

            double averageRate = 0;

            if (recentService.latestServices[i].reviewsForMobile.isNotEmpty) {
              averageRate = (totalRating /
                  recentService.latestServices[i].reviewsForMobile.length);
            }

            ratingList.add(averageRate);

            // print(averageRate);
          }
          notifyListeners();
        } else {
          //Something went wrong
          recentService == 'error';
        }
      }
    } else {
      //already loaded from api
    }
  }
}
