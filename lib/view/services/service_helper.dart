import 'package:flutter/material.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class ServiceHelper {
  ConstantColors cc = ConstantColors();
  checkListCommon(String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Icon(
            Icons.check,
            color: cc.successColor,
          ),
          const SizedBox(
            width: 14,
          ),
          Text(
            title,
            style: TextStyle(
              color: cc.greyFour,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
