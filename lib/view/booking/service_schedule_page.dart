import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qixer/view/booking/booking_helper.dart';
import 'package:qixer/view/booking/components/extras.dart';
import 'package:qixer/view/booking/delivery_address_page.dart.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

import 'components/quantity.dart';
import 'components/steps.dart';

class ServiceSchedulePage extends StatefulWidget {
  const ServiceSchedulePage({Key? key}) : super(key: key);

  @override
  _ServiceSchedulePageState createState() => _ServiceSchedulePageState();
}

class _ServiceSchedulePageState extends State<ServiceSchedulePage> {
  @override
  void initState() {
    super.initState();
  }

  int selectedDay = 0;
  int selectedTime = 0;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('Schedule', context),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Circular Progress bar
                      Steps(cc: cc),

                      CommonHelper().titleCommon('Available date:'),

                      const SizedBox(
                        height: 17,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 45,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          clipBehavior: Clip.none,
                          children: [
                            for (int i = 0; i < 8; i++)
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    selectedDay = i;
                                  });
                                },
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                        right: 17,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: selectedDay == i
                                                  ? cc.primaryColor
                                                  : cc.borderColor),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 13, vertical: 15),
                                      child: Text(
                                        'Wed, 16 Mar',
                                        style: TextStyle(
                                          color: cc.greyFour,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    selectedDay == i
                                        ? Positioned(
                                            right: 10,
                                            top: -7,
                                            child: CommonHelper().checkCircle())
                                        : Container()
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),

                      // Time =============================>
                      const SizedBox(
                        height: 26,
                      ),
                      CommonHelper().titleCommon('Available time:'),

                      const SizedBox(
                        height: 17,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        height: 45,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          clipBehavior: Clip.none,
                          children: [
                            for (int i = 0; i < 8; i++)
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  setState(() {
                                    selectedTime = i;
                                  });
                                },
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      margin: const EdgeInsets.only(
                                        right: 17,
                                      ),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: selectedTime == i
                                                  ? cc.primaryColor
                                                  : cc.borderColor),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 13, vertical: 15),
                                      child: Text(
                                        '10:00 AM - 11:00 AM',
                                        style: TextStyle(
                                          color: cc.greyFour,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    selectedTime == i
                                        ? Positioned(
                                            right: 10,
                                            top: -7,
                                            child: CommonHelper().checkCircle())
                                        : Container()
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),

          //  bottom container
          Container(
            padding: EdgeInsets.only(
                left: screenPadding, top: 20, right: screenPadding),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 8,
                  blurRadius: 17,
                  offset: const Offset(0, 0), // changes position of shadow
                ),
              ],
            ),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CommonHelper().titleCommon('Scheduling for:'),
              const SizedBox(
                height: 15,
              ),
              BookingHelper().rowLeftRight(
                  'assets/svg/calendar.svg', 'Date', 'Friday, 18 March 2022'),
              const SizedBox(
                height: 14,
              ),
              BookingHelper().rowLeftRight(
                  'assets/svg/clock.svg', 'Time', '02:00 PM -03:00 PM'),
              const SizedBox(
                height: 23,
              ),
              CommonHelper().buttonOrange("Next", () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        const DeliveryAddressPage(),
                  ),
                );
              }),
              const SizedBox(
                height: 30,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
