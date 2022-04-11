import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/view/booking/components/extras.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

import 'components/quantity.dart';
import 'components/steps.dart';

class ServicePersonalizationPage extends StatefulWidget {
  const ServicePersonalizationPage({Key? key}) : super(key: key);

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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('Personalize', context),
      body: SingleChildScrollView(
        child: Container(
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

                for (int i = 0; i < 2; i++) Quantity(cc: cc),

                const SizedBox(
                  height: 20,
                ),

                Extras(cc: cc),

                //Login button ==================>
                const SizedBox(
                  height: 27,
                ),
                CommonHelper().buttonOrange("Next", () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const LandingPage(),
                    ),
                  );
                }),

                const SizedBox(
                  height: 30,
                ),
              ],
            )),
      ),
    );
  }
}
