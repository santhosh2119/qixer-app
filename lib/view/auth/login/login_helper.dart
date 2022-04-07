import 'package:flutter/material.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class LoginHelper {
  ConstantColors cc = ConstantColors();
  commonButton(String icon, String title) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: cc.greyFive),
          borderRadius: BorderRadius.circular(6)),
      alignment: Alignment.center,
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 20.0,
            width: 30.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(icon), fit: BoxFit.fitHeight),
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          Text(
            title,
            style: TextStyle(color: cc.greyFour),
          ),
        ],
      ),
    );
  }
}
