import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:qixer/model/profile_model.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileService with ChangeNotifier {
  bool isloading = false;

  var profileDetails;
  var profileImage;

  List ordersList = [];

  setLoadingTrue() {
    isloading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isloading = false;
    notifyListeners();
  }

  getProfileDetails() async {
    if (profileDetails == null) {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        //internet off
        OthersHelper()
            .showToast("Please turn on your internet connection", Colors.black);
        return false;
      } else {
        //internet connection is on
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.getString('token');

        setLoadingTrue();

        var header = {
          //if header type is application/json then the data should be in jsonEncode method
          "Accept": "application/json",
          // "Content-Type": "application/json"
          "Authorization": "Bearer $token",
        };

        var response =
            await http.get(Uri.parse('$baseApi/user/profile'), headers: header);

        if (response.statusCode == 201) {
          print(response.body);
          profileDetails = ProfileModel.fromJson(jsonDecode(response.body));

          ordersList.add(profileDetails.pendingOrder);
          ordersList.add(profileDetails.activeOrder);
          ordersList.add(profileDetails.completeOrder);
          ordersList.add(profileDetails.totalOrder);

          if (jsonDecode(response.body)['profile_image'] is List) {
            //then dont do anything because it means image is missing from database
          } else {
            profileImage =
                jsonDecode(response.body)['profile_image']['img_url'];
          }

          setLoadingFalse();
          notifyListeners();
        } else {
          print(response.body);
          profileDetails == 'error';
          setLoadingFalse();
          OthersHelper().showToast('Something went wrong', Colors.black);
          notifyListeners();
        }
      }
    } else {
      //data already loaded from server. no need to load again
    }
  }
}
