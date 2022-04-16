import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/book_confirmation_service.dart';
import 'package:qixer/view/booking/booking_helper.dart';
import 'package:qixer/view/booking/components/order_details_panel_procced.dart';
import 'package:qixer/view/booking/payment_choose_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_styles.dart';

import '../../utils/constant_colors.dart';

class OrderDetailsPanel extends StatefulWidget {
  const OrderDetailsPanel({Key? key, this.panelController}) : super(key: key);
  final panelController;

  @override
  State<OrderDetailsPanel> createState() => _OrderDetailsPanelState();
}

class _OrderDetailsPanelState extends State<OrderDetailsPanel>
    with TickerProviderStateMixin {
  ConstantColors cc = ConstantColors();
  FocusNode couponFocus = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<BookConfirmationService>(
      builder: (context, bcProvider, child) => Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 17, bottom: 6),
            child: InkWell(
              onTap: () {
                if (widget.panelController.isPanelOpen) {
                  widget.panelController.close();
                } else {
                  widget.panelController.open();
                }
              },
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
          ),
          Expanded(
            child: Listener(
              onPointerDown: (_) {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.focusedChild?.unfocus();
                }
              },
              child: SingleChildScrollView(
                physics: physicsCommon,
                controller: _scrollController,
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: CommonHelper().dividerCommon(),
                                  ),
                                  //Package fee
                                  BookingHelper()
                                      .detailsPanelRow('Package Fee', 0, '210'),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  //Extra service
                                  BookingHelper().detailsPanelRow(
                                      'Extra service', 0, '10'),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20),
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
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: CommonHelper().dividerCommon(),
                                  ),
                                ],
                              )
                            : Container(),

                        //total ===>

                        BookingHelper().detailsPanelRow('Total', 0, '237.6'),

                        bcProvider.isPanelOpened == true
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CommonHelper().labelCommon("Coupon code"),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                            decoration: BoxDecoration(
                                                // color: const Color(0xfff2f2f2),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: TextFormField(
                                              // controller: controller,

                                              style:
                                                  const TextStyle(fontSize: 14),
                                              focusNode: couponFocus,
                                              decoration: InputDecoration(
                                                  enabledBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ConstantColors()
                                                              .greyFive),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ConstantColors()
                                                              .primaryColor)),
                                                  errorBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: ConstantColors()
                                                              .warningColor)),
                                                  focusedErrorBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              color: ConstantColors().primaryColor)),
                                                  hintText: 'Enter coupon code',
                                                  contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18)),
                                            )),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 15),
                                        width: 100,
                                        child: CommonHelper()
                                            .buttonOrange('Apply', () {}),
                                      )
                                    ],
                                  ),
                                ],
                              )
                            : Container(),

                        //Buttons
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            widget.panelController.isPanelClosed
                                ? Expanded(
                                    child: CommonHelper()
                                        .borderButtonOrange('Apply coupon', () {
                                      widget.panelController.open();
                                      couponFocus.requestFocus();
                                      _scrollController.animateTo(
                                        155,
                                        duration:
                                            const Duration(milliseconds: 1200),
                                        curve: Curves.fastOutSlowIn,
                                      );
                                    }),
                                  )
                                : Container(),
                            widget.panelController.isPanelClosed
                                ? const SizedBox(
                                    width: 20,
                                  )
                                : Container(),
                            Expanded(
                              child: CommonHelper()
                                  .buttonOrange('Proceed to payment', () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const PaymentChoosePage(),
                                  ),
                                );
                              }),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 105,
                        ),
                      ],
                    ),
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
