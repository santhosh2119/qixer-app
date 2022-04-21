import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/utils/others_helper.dart';

Future<bool> checkConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.none) {
    OthersHelper()
        .showToast("Please turn on your internet connection", Colors.black);
    return false;
  } else {
    return true;
  }
}
