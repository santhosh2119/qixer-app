import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class BookingHelper {
  ConstantColors cc = ConstantColors();
  rowLeftRight(String iconLink, String title, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //icon
        Row(children: [
          SvgPicture.asset(
            iconLink,
            height: 19,
          ),
          const SizedBox(
            width: 7,
          ),
          Text(
            title,
            style: TextStyle(
              color: cc.greyFour,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          )
        ]),

        Text(
          text,
          style: TextStyle(
            color: cc.greyFour,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
