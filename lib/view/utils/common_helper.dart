import 'package:flutter/material.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class CommonHelper {
  ConstantColors cc = ConstantColors();
  appbarCommon(String title) {
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: cc.greyPrimary),
      title: Text(
        title,
        style: TextStyle(
            color: cc.greyPrimary, fontSize: 18, fontWeight: FontWeight.w600),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }
}
