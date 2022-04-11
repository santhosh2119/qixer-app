import 'package:flutter/material.dart';
import 'package:qixer/view/booking/booking_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';

import '../../utils/constant_colors.dart';

class OrderDetailsPanel extends StatefulWidget {
  const OrderDetailsPanel({Key? key}) : super(key: key);

  @override
  State<OrderDetailsPanel> createState() => _OrderDetailsPanelState();
}

class _OrderDetailsPanelState extends State<OrderDetailsPanel> {
  ConstantColors cc = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 17, bottom: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 30,
                height: 6,
                decoration: BoxDecoration(
                    color: cc.greyFive,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: CommonHelper().dividerCommon(),
                  ),

                  //service list ===================>
                  BookingHelper()
                      .detailsPanelRow('Weeding soft layer makeup', 2, '200'),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: CommonHelper().dividerCommon(),
                  ),
                  //Package fee
                  BookingHelper().detailsPanelRow('Package Fee', 0, '210'),
                  const SizedBox(
                    height: 20,
                  ),
                  //Extra service
                  BookingHelper().detailsPanelRow('Extra service', 0, '10'),

                  //Sub total and tax ============>
                  //Sub total
                  BookingHelper().detailsPanelRow('Subtotal', 0, '220'),
                  const SizedBox(
                    height: 20,
                  ),
                  //tax
                  BookingHelper().detailsPanelRow('Tax(+) 8%', 0, '18.6'),

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
                                borderSide: BorderSide(
                                    color: ConstantColors().greyFive),
                                borderRadius: BorderRadius.circular(7)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantColors().primaryColor)),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantColors().redColor)),
                            focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ConstantColors().primaryColor)),
                            hintText: 'Enter coupon code',
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 18)),
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  CommonHelper().buttonOrange('Proceed to payment', () {}),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
