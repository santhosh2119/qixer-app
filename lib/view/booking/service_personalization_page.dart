import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/booking_services/personalization_service.dart';
import 'package:qixer/service/service_details_service.dart';
import 'package:qixer/view/booking/components/extras.dart';
import 'package:qixer/view/booking/service_schedule_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../../service/book_steps_service.dart';
import 'booking_helper.dart';
import 'components/included.dart';
import 'components/steps.dart';

class ServicePersonalizationPage extends StatefulWidget {
  const ServicePersonalizationPage({Key? key, required this.serviceId})
      : super(key: key);

  final serviceId;

  @override
  _ServicePersonalizationPageState createState() =>
      _ServicePersonalizationPageState();
}

class _ServicePersonalizationPageState
    extends State<ServicePersonalizationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return WillPopScope(
      onWillPop: () {
        BookStepsService().decreaseStep(context);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarForBookingPages('Personalize', context),
        body: SingleChildScrollView(
          physics: physicsCommon,
          child: Consumer<PersonalizationService>(
              builder: (context, provider, child) => provider.isloading == false
                  ? provider.serviceExtraData != 'error'
                      ? Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenPadding,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //Circular Progress bar
                              Steps(cc: cc),

                              CommonHelper().titleCommon('What’s included:'),

                              const SizedBox(
                                height: 20,
                              ),

                              // for (int i = 0; i < 2; i++)
                              Included(
                                cc: cc,
                                data: provider
                                    .serviceExtraData.service.serviceInclude,
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              Extras(
                                cc: cc,
                                additionalServices: provider
                                    .serviceExtraData.service.serviceAdditional,
                                serviceBenefits: provider
                                    .serviceExtraData.service.serviceBenifit,
                              ),

                              // button ==================>
                              const SizedBox(
                                height: 27,
                              ),
                              // CommonHelper().buttonOrange("Next", () {
                              //   Navigator.push(
                              //     context,
                              //     MaterialPageRoute<void>(
                              //       builder: (BuildContext context) =>
                              //           const ServiceSchedulePage(),
                              //     ),
                              //   );
                              // }),

                              const SizedBox(
                                height: 147,
                              ),
                            ],
                          ))
                      : const Text("Something went wrong")
                  : Container(
                      height: MediaQuery.of(context).size.height - 250,
                      alignment: Alignment.center,
                      child: OthersHelper().showLoading(cc.primaryColor),
                    )),
        ),
        bottomSheet: Container(
          height: 157,
          padding: EdgeInsets.only(
              left: screenPadding, top: 30, right: screenPadding),
          decoration: BookingHelper().bottomSheetDecoration(),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            BookingHelper().detailsPanelRow('Total', 0, '237.6'),
            const SizedBox(
              height: 23,
            ),
            CommonHelper().buttonOrange("Next", () {
              //increase page steps by one
              BookStepsService().onNext(context);
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: const ServiceSchedulePage()));
            }),
            const SizedBox(
              height: 30,
            ),
          ]),
        ),
      ),
    );
  }
}
