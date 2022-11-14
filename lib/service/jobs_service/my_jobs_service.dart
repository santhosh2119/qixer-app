import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/model/jobs/job_details_model.dart';
import 'package:qixer/model/jobs/my_jobs_model.dart';
import 'package:qixer/service/common_service.dart';
import 'package:qixer/view/utils/others_helper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyJobsService with ChangeNotifier {
  var myJobsListMap = [];
  List imageList = [];

  bool isLoading = true;

  late int totalPages;

  int currentPage = 1;

  setLoadingStatus(bool status) {
    isLoading = status;
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

  setActiveStatus(bool status, int index) {
    myJobsListMap[index]['isActive'] = status;
    notifyListeners();
  }

  setDefault() {
    myJobsListMap = [];
    imageList = [];
    currentPage = 1;
    notifyListeners();
  }

  fetchMyJobs(context, {bool isrefresh = false}) async {
    if (isrefresh) {
      //making the list empty first to show loading bar (we are showing loading bar while the product list is empty)
      //we are make the list empty when the sub category or brand is selected because then the refresh is true
      myJobsListMap = [];
      notifyListeners();

      Provider.of<MyJobsService>(context, listen: false)
          .setCurrentPage(currentPage);
    } else {
      // if (currentPage > 2) {
      //   refreshController.loadNoData();
      //   return false;
      // }
    }

    var connection = await checkConnection();
    if (connection) {
      //if connection is ok

      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      setLoadingStatus(true);

      var response = await http.get(
          Uri.parse("$baseApi/user/job/job-lists?page=$currentPage"),
          headers: header);

      setLoadingStatus(false);

      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 201 &&
          decodedData['job_lists']['data'].isNotEmpty) {
        var data = MyJobsModel.fromJson(decodedData);

        setTotalPage(data.jobLists.lastPage);

        for (int i = 0; i < data.jobImage.length; i++) {
          String? serviceImage;

          if (i == 0) {
            //api giving an unnecessary null for first one, so skip it
            continue;
          } else {
            serviceImage = data.jobImage[i]?.imgUrl ?? placeHolderUrl;
          }

          imageList.add(serviceImage);
        }

        if (isrefresh) {
          print('refresh true');
          //if refreshed, then remove all service from list and insert new data
          setServiceList(data.jobLists.data, imageList, false);
        } else {
          print('add new data');

          //else add new data
          setServiceList(data.jobLists.data, imageList, true);
        }

        currentPage++;
        setCurrentPage(currentPage);
        return true;
      } else {
        print('error fetching my jobs ${response.body}');
        return false;
      }
    }
  }

  setServiceList(data, imageList, bool addnewData) {
    if (addnewData == false) {
      //make the list empty first so that existing data doesn't stay
      myJobsListMap = [];
      notifyListeners();
    }

    for (int i = 0; i < data.length; i++) {
      myJobsListMap.add({
        'id': data[i].id,
        'title': data[i].title,
        'isActive': data[i].isJobOn == 1 ? true : false,
        'price': data[i].price,
        'image': imageList[i],
        'viewCount': data[i].view,
      });
    }
  }

  //Fetch order details
  //=====================>

  bool loadingOrderDetails = false;

  setOrderDetailsLoadingStatus(bool status) {
    loadingOrderDetails = status;
    notifyListeners();
  }

  var jobDetails;

  fetchJobDetails(jobId, BuildContext context) async {
    //check internet connection
    var connection = await checkConnection();
    if (connection) {
      //internet connection is on
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');

      var header = {
        //if header type is application/json then the data should be in jsonEncode method
        "Accept": "application/json",
        // "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      setOrderDetailsLoadingStatus(true);

      var response = await http.get(
        Uri.parse('$baseApi/job/details/$jobId'),
        headers: header,
      );

      setOrderDetailsLoadingStatus(false);

      if (response.statusCode == 201) {
        final data = JobDetailsModel.fromJson(jsonDecode(response.body));

        jobDetails = data.jobDetails;

        notifyListeners();
      } else {
        OthersHelper().showToast('Something went wrong', Colors.black);
      }
    }
  }
}
