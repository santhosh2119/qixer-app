import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/home/home.dart';
import 'package:qixer/view/tabs/orders/order_details_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

import 'orders_helper.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: physicsCommon,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenPadding),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    CommonHelper().titleCommon('My Orders'),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 18),
                      decoration: BoxDecoration(
                          border: Border.all(color: cc.borderColor),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AutoSizeText(
                              '#812466',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: cc.primaryColor,
                              ),
                            ),
                            Row(
                              children: [
                                OrdersHelper().statusCapsule(
                                    'Cancelled', cc.warningColor),
                                Container(
                                  margin: const EdgeInsets.only(left: 8),
                                  child: PopupMenuButton(
                                    // initialValue: 2,
                                    child: const Icon(Icons.more_vert),
                                    itemBuilder: (c) {
                                      return List.generate(1, (index) {
                                        return PopupMenuItem(
                                          value: index,
                                          onTap: () async {
                                            //without the below line, navigation won't work
                                            await Future.delayed(Duration.zero);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder: (BuildContext
                                                        context) =>
                                                    const OrderDetailsPage(),
                                              ),
                                            );
                                          },
                                          child: const Text('Details'),
                                        );
                                      });
                                    },
                                  ),
                                )
                              ],
                            )
                          ],
                        ),

                        //Divider
                        Container(
                          margin: const EdgeInsets.only(top: 17, bottom: 20),
                          child: CommonHelper().dividerCommon(),
                        ),

                        OrdersHelper().orderRow(
                          'assets/svg/calendar.svg',
                          'Date',
                          'Friday, 18 March 2022',
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 14),
                          child: CommonHelper().dividerCommon(),
                        ),
                        OrdersHelper().orderRow(
                          'assets/svg/clock.svg',
                          'Time',
                          '02:00 PM - 03:00 PM',
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 14),
                          child: CommonHelper().dividerCommon(),
                        ),
                        OrdersHelper().orderRow(
                          'assets/svg/bill.svg',
                          'Billed',
                          '\$239.36',
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
