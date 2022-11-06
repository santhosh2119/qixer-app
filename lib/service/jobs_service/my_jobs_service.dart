import 'package:flutter/material.dart';

class MyJobsService with ChangeNotifier {
  List myJobsListMap = [
    {
      'title': 'Those medals you wear on your moth eaten chest should be there',
      'price': '100',
      'orders': '17',
      'views': '173',
      'isActive': true
    },
    {
      'title': 'Those medals you wear on your moth eaten chest should be there',
      'price': '100',
      'orders': '17',
      'views': '173',
      'isActive': true
    },
    {
      'title': 'Those medals you wear on your moth eaten chest should be there',
      'price': '100',
      'orders': '17',
      'views': '173',
      'isActive': true
    }
  ];

  setActiveStatus(bool status, int index) {
    myJobsListMap[index]['isActive'] = status;
    notifyListeners();
  }
}
