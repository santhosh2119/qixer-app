import 'package:flutter/material.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

import '../../booking/booking_helper.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({Key? key}) : super(key: key);

  @override
  _OrdersDetailsPageState createState() => _OrdersDetailsPageState();
}

class _OrdersDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  ConstantColors cc = ConstantColors();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cc.bgColor,
        appBar: CommonHelper().appbarCommon('Order Details', context, () {
          Navigator.pop(context);
        }),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: physicsCommon,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonHelper().titleCommon('Seller Details'),
                            const SizedBox(
                              height: 25,
                            ),
                            //Service row

                            Container(
                              child:
                                  BookingHelper().bRow('null', 'Name', '200'),
                            ),

                            Container(
                              child:
                                  BookingHelper().bRow('null', 'Email', '200'),
                            ),

                            Container(
                              child:
                                  BookingHelper().bRow('null', 'Phone', '200'),
                            ),

                            Container(
                              child: BookingHelper()
                                  .bRow('null', 'Post code', '200'),
                            ),

                            Container(
                              child: BookingHelper().bRow(
                                  'null', 'Address', '200',
                                  lastBorder: false),
                            ),
                          ]),
                    ),

                    // Date and schedule
                    Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonHelper().titleCommon('Date & Schedule'),
                            const SizedBox(
                              height: 25,
                            ),
                            //Service row

                            Container(
                              child:
                                  BookingHelper().bRow('null', 'Date', '200'),
                            ),

                            Container(
                              child: BookingHelper().bRow(
                                  'null', 'Schedule', '200',
                                  lastBorder: false),
                            ),
                          ]),
                    ),

                    // Date and schedule
                    Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonHelper().titleCommon('Amound Details'),
                            const SizedBox(
                              height: 25,
                            ),
                            //Service row

                            Container(
                              child: BookingHelper()
                                  .bRow('null', 'Package fee', '200'),
                            ),

                            Container(
                              child: BookingHelper()
                                  .bRow('null', 'Extra service', '200'),
                            ),

                            Container(
                              child: BookingHelper()
                                  .bRow('null', 'Sub total', '200'),
                            ),

                            Container(
                              child: BookingHelper().bRow('null', 'Tax', '200'),
                            ),

                            Container(
                              child:
                                  BookingHelper().bRow('null', 'Total', '200'),
                            ),

                            Container(
                              child: BookingHelper()
                                  .bRow('null', 'Extra service', '200'),
                            ),

                            Container(
                              child: BookingHelper().bRow(
                                  'null', 'Payment status', '200',
                                  lastBorder: false),
                            ),
                          ]),
                    ),

                    // Date and schedule
                    Container(
                      margin: const EdgeInsets.only(bottom: 25),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonHelper().titleCommon('Order Status'),
                            const SizedBox(
                              height: 25,
                            ),
                            //Service row

                            Container(
                              child: BookingHelper().bRow(
                                  'null', 'Order status', 'pending',
                                  lastBorder: false),
                            ),
                          ]),
                    ),
                    //
                  ]),
            ),
          ),
        ));
  }
}
