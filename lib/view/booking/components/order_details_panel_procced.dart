import 'package:flutter/material.dart';
import 'package:qixer/view/booking/payment_choose_page.dart';

import '../../utils/common_helper.dart';
import '../../utils/constant_colors.dart';
import '../booking_helper.dart';

class OrderDetailsPanelProceed extends StatelessWidget {
  const OrderDetailsPanelProceed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //total ===>
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: CommonHelper().dividerCommon(),
        ),
        BookingHelper().detailsPanelRow('Total', 0, '237.6'),
        const SizedBox(
          height: 20,
        ),
        CommonHelper().labelCommon("Coupon code"),
        Container(
            margin: const EdgeInsets.only(bottom: 19),
            decoration: BoxDecoration(
                // color: const Color(0xfff2f2f2),
                borderRadius: BorderRadius.circular(10)),
            child: TextFormField(
              // controller: controller,

              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ConstantColors().greyFive),
                      borderRadius: BorderRadius.circular(7)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ConstantColors().primaryColor)),
                  errorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ConstantColors().warningColor)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ConstantColors().primaryColor)),
                  hintText: 'Enter coupon code',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 18)),
            )),
        const SizedBox(
          height: 5,
        ),
        CommonHelper().buttonOrange('Proceed to payment', () {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => const PaymentChoosePage(),
            ),
          );
        }),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }
}
