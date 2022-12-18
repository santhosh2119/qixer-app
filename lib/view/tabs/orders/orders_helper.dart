import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qixer/view/report/write_report_page.dart';
import 'package:qixer/view/services/review/write_review_page.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class OrdersHelper {
  List ordersPopupMenuList = [
    'Leave feedback',
    'Cancel order',
    'Report to admin'
  ];

  navigateMyOrders(BuildContext context, {required index, required serviceId}) {
    if (index == 0) {
      return Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => WriteReviewPage(
            serviceId: serviceId,
          ),
        ),
      );
    } else if (index == 2) {
      return Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => WriteReportPage(
            serviceId: serviceId,
            orderId: '',
            sellerId: '',
          ),
        ),
      );
    }
  }

  ConstantColors cc = ConstantColors();

  statusCapsule(String capsuleText, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 11),
      decoration: BoxDecoration(
          color: color.withOpacity(.1), borderRadius: BorderRadius.circular(4)),
      child: Text(
        capsuleText,
        style:
            TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }

  statusCapsuleBordered(String capsuleText, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(color: cc.borderColor),
          color: Colors.white,
          borderRadius: BorderRadius.circular(4)),
      child: Text(
        capsuleText,
        style:
            TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 12),
      ),
    );
  }

  ///
  orderRow(String icon, String title, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //icon
        Container(
          margin: const EdgeInsets.only(right: 15),
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
    );
  }
}
