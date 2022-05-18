import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/book_steps_service.dart';
import 'package:qixer/service/booking_services/book_service.dart';
import 'package:qixer/service/booking_services/personalization_service.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/view/auth/signup/components/country_states_dropdowns.dart';
import 'package:qixer/view/booking/service_personalization_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

import 'components/steps.dart';

class BookingLocationPage extends StatefulWidget {
  const BookingLocationPage({Key? key, required this.serviceId})
      : super(key: key);

  final serviceId;

  @override
  _BookingLocationPageState createState() => _BookingLocationPageState();
}

class _BookingLocationPageState extends State<BookingLocationPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        appBar: CommonHelper()
            .appbarForBookingPages("Location", context, isLocPage: true),
        body: SingleChildScrollView(
          physics: physicsCommon,
          child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Circular Progress bar
                  Steps(cc: cc),

                  CommonHelper().titleCommon('Booking informations'),

                  const SizedBox(
                    height: 20,
                  ),

                  const CountryStatesDropdowns(),
                  //Login button ==================>
                  const SizedBox(
                    height: 27,
                  ),
                  CommonHelper().buttonOrange("Next", () {
                    //increase page steps by one
                    BookStepsService().onNext(context);
                    //setDefaultPrice ==> Before the user did any quantity increase decrease...etc
                    Provider.of<PersonalizationService>(context, listen: false)
                        .setDefaultPrice(
                            Provider.of<BookService>(context, listen: false)
                                .totalPrice);
                    //fetch service extra
                    Provider.of<PersonalizationService>(context, listen: false)
                        .fetchServiceExtra(widget.serviceId, context);
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: const ServicePersonalizationPage()));
                  }),

                  const SizedBox(
                    height: 30,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
