import 'package:flutter/material.dart';

late double screenWidth;
late double screenHeight;

getScreenSize(BuildContext context) {
  screenWidth = MediaQuery.of(context).size.width;
  screenHeight = MediaQuery.of(context).size.height;
}

//responsive screen codes ========>

var fourinchScreenHeight = 610;
var fourinchScreenWidth = 385;
