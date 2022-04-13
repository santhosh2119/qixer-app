import 'package:flutter/material.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:qixer/view/booking/booking_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

class PaymentSuccessPage extends StatefulWidget {
  const PaymentSuccessPage({Key? key}) : super(key: key);

  @override
  _PaymentSuccessPageState createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('Payment', context),
        body: SingleChildScrollView(
          physics: physicsCommon,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            clipBehavior: Clip.none,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              //success icon
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Icon(
                    Icons.check_circle,
                    color: cc.successColor,
                    size: 85,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    'Payment successful!',
                    style: TextStyle(
                        color: cc.greyFour,
                        fontSize: 21,
                        fontWeight: FontWeight.w600),
                  ),

                  //Date and Time =================>
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(
                      top: 30,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 18),
                    decoration: BoxDecoration(
                        border: Border.all(color: cc.borderColor),
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: [
                        Expanded(
                          child: BookingHelper().bdetailsContainer(
                              'assets/svg/calendar.svg',
                              'Date',
                              'Friday, 18 March 2022'),
                        ),
                        const SizedBox(
                          width: 13,
                        ),
                        Expanded(
                          child: BookingHelper().bdetailsContainer(
                              'assets/svg/clock.svg',
                              'Time',
                              '02:00 PM - 03:00 PM'),
                        )
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  //payment details
                  //Package fee and extra service =============>
                  BookingHelper().detailsPanelRow('Package Fee', 0, '210'),
                  sizedBox20(),
                  BookingHelper().detailsPanelRow('Extra service', 0, '10'),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: CommonHelper().dividerCommon(),
                  ),

//subtotal and tax =========>
                  BookingHelper().detailsPanelRow('Subtotal', 0, '220'),
                  sizedBox20(),
                  BookingHelper().detailsPanelRow('Tax(+) 8%', 0, '18.6'),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: CommonHelper().dividerCommon(),
                  ),

                  //total and payment gateway =========>

                  //Total ====>
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                          color: cc.greyFour,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '\$ 238.6',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: cc.greyFour,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                  sizedBox20(),
                  //Gateway
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Payment gateway',
                        style: TextStyle(
                          color: cc.greyFour,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Mobile',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: cc.greyFour,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: CommonHelper().dividerCommon(),
                  ),

                  //Payment status and order status ===========>
                  Row(
                    children: [
                      BookingHelper().colorCapsule(
                          'Payment status', 'Complete', cc.successColor),
                      const SizedBox(
                        width: 30,
                      ),
                      BookingHelper().colorCapsule(
                          'Order status', 'Pending', cc.yellowColor)
                    ],
                  ),
                ],
              ),

              //
            ]),
          ),
        ));
  }
}
