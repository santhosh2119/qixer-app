// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:qixer/view/utils/others_helper.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'common_service.dart';

// class OrderDetailsService with ChangeNotifier{
//     var orderDetails;

//   bool isLoading = true;

//   setLoadingTrue() {
//     Future.delayed(Duration(seconds: 1), () {
//       isLoading = true;
//     });
//   }

//   fetchOrderDetails(orderId) async{
//         //get user id
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     int? userId = prefs.getInt('userId');
//     var token = prefs.getString('token');

//     var header = {
//       //if header type is application/json then the data should be in jsonEncode method
//       "Accept": "application/json",
//       "Content-Type": "application/json",
//       "Authorization": "Bearer $token",
//     };



//         var connection = await checkConnection();
//     if (connection) {
//       //if connection is ok
//       var response = await http.post(Uri.parse('$baseApi/user/my-orders/$orderId'),
//           headers: header);

//       if (response.statusCode == 201) {
//         print(response.body);
//         var data = MyordersListModel.fromJson(jsonDecode(response.body));
//         print(data);
//         myServices = data.myOrders;

//         isLoading = false;
//         notifyListeners();
//         setLoadingTrue();
//         return myServices;
//       } else {
//         //Something went wrong
//         myServices = 'error';
//         isLoading = false;
//         notifyListeners();
//         setLoadingTrue();
//         return myServices;
//       }
//     }
    
//   }

// }