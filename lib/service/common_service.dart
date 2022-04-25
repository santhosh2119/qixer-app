import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

twoDouble(double value) {
  return double.parse(value.toStringAsFixed(1));
}

getYear(value) {
  final f = DateFormat('yyyy');
  var d = f.format(value);
  return d;
}

getTime(value) {
  final f = DateFormat('hh:mm a');
  var d = f.format(value);
  return d;
}
