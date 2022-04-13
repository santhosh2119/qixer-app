import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/book_confirmation_service.dart';
import 'package:qixer/view/booking/booking_helper.dart';
import 'package:qixer/view/booking/components/order_details_panel_procced.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_styles.dart';

import '../../utils/constant_colors.dart';

class OrderDetailsPanel extends StatefulWidget {
  const OrderDetailsPanel({Key? key}) : super(key: key);

  @override
  State<OrderDetailsPanel> createState() => _OrderDetailsPanelState();
}

class _OrderDetailsPanelState extends State<OrderDetailsPanel>
    with TickerProviderStateMixin {
  ConstantColors cc = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Consumer<BookConfirmationService>(
      builder: (context, bcProvider, child) => Column(
        children: [
          // Container(
          //   margin: const EdgeInsets.only(top: 17, bottom: 17),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(
          //         width: 30,
          //         height: 6,
          //         decoration: BoxDecoration(
          //             color: cc.greyFive,
          //             borderRadius: BorderRadius.circular(20)),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            margin: const EdgeInsets.only(top: 17, bottom: 6),
            child: Column(
              children: [
                bcProvider.isPanelOpened == false
                    ? Text(
                        'Swipe up for details',
                        style: TextStyle(
                          color: cc.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : Text(
                        'Collapse details',
                        style: TextStyle(
                          color: cc.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                bcProvider.isPanelOpened == false
                    ? Icon(
                        Icons.keyboard_arrow_up_rounded,
                        color: cc.primaryColor,
                      )
                    : Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: cc.primaryColor,
                      ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: physicsCommon,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: CommonHelper().dividerCommon(),
                      ),

                      //service list ===================>
                      bcProvider.isPanelOpened == true
                          ? Column(
                              children: [
                                BookingHelper().detailsPanelRow(
                                    'Weeding soft layer makeup', 2, '200'),

                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: CommonHelper().dividerCommon(),
                                ),
                                //Package fee
                                BookingHelper()
                                    .detailsPanelRow('Package Fee', 0, '210'),
                                const SizedBox(
                                  height: 20,
                                ),
                                //Extra service
                                BookingHelper()
                                    .detailsPanelRow('Extra service', 0, '10'),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: CommonHelper().dividerCommon(),
                                ),
                                //Sub total and tax ============>
                                //Sub total
                                BookingHelper()
                                    .detailsPanelRow('Subtotal', 0, '220'),

                                const SizedBox(
                                  height: 20,
                                ),
                                //tax
                                BookingHelper()
                                    .detailsPanelRow('Tax(+) 8%', 0, '18.6'),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: CommonHelper().dividerCommon(),
                                ),
                              ],
                            )
                          : Container(),

                      const OrderDetailsPanelProceed()
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
