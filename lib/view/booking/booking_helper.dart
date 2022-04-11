import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qixer/view/utils/constant_colors.dart';

import '../utils/common_helper.dart';

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

  bdetailsContainer(String iconLink, String title, String text) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BookingHelper().rowLeftRight('assets/svg/location.svg', 'Date', ''),
      const SizedBox(
        height: 10,
      ),
      Text(
        'Dhanmondi, Dhaka, Bangladesh',
        style: TextStyle(
          color: cc.greyFour,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      )
    ]);
  }

  bRow(String icon, String title, String text) {
    return Column(
      children: [
        Row(
          children: [
            //icon
            Container(
              width: 125,
              child: Row(children: [
                SvgPicture.asset(
                  icon,
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
            ),

            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  color: cc.greyFour,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 14),
          child: CommonHelper().dividerCommon(),
        )
      ],
    );
  }

  detailsPanelRow(String title, int quantity, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: cc.greyFour,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        quantity != 0
            ? Expanded(
                child: Text(
                'x1',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: cc.greyFour,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ))
            : Container(),
        Expanded(
          child: Text(
            '\$ $price',
            textAlign: TextAlign.right,
            style: TextStyle(
              color: cc.greyFour,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
