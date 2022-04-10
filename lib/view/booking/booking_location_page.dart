import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/service/signup_service.dart';
import 'package:qixer/view/auth/signup/signup_helper.dart';
import 'package:qixer/view/booking/service_personalization_page.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'components/steps.dart';

class BookingLocationPage extends StatefulWidget {
  const BookingLocationPage({Key? key}) : super(key: key);

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
    return Scaffold(
      appBar: CommonHelper().appbarCommon('Location', context),
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

                CommonHelper().titleCommon('Booking informations'),

                const SizedBox(
                  height: 20,
                ),

                Consumer<CountryStatesService>(
                    builder: (context, provider, child) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //dropdown and search box
                            const SizedBox(
                              width: 17,
                            ),

                            // Country dropdown ===============>
                            CommonHelper().labelCommon("Choose country"),
                            provider.countryDropdown.isNotEmpty
                                ? Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: cc.greyFive),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.01),
                                            spreadRadius: -2,
                                            blurRadius: 13,
                                            offset: const Offset(0, 13)),
                                      ],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        // menuMaxHeight: 200,
                                        // isExpanded: true,
                                        value: provider.selectedCountry,
                                        icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: cc.greyFour),
                                        iconSize: 26,
                                        elevation: 17,
                                        style: TextStyle(color: cc.greyFour),
                                        onChanged: (newValue) {
                                          provider.setCountryValue(newValue);

                                          //setting the id of selected value
                                          // provider.setId(
                                          //     provider.valueIndexList[
                                          //         provider.dropdown
                                          //             .indexOf(newValue)]);
                                        },
                                        items: provider.countryDropdown
                                            .map<DropdownMenuItem<String>>(
                                                (value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  color: cc.greyPrimary
                                                      .withOpacity(.8)),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )
                                : Container(),

                            const SizedBox(
                              height: 25,
                            ),
                            // Country dropdown ===============>
                            CommonHelper().labelCommon("Choose states"),
                            provider.statesDropdown.isNotEmpty
                                ? Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: cc.greyFive),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.01),
                                            spreadRadius: -2,
                                            blurRadius: 13,
                                            offset: const Offset(0, 13)),
                                      ],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        // menuMaxHeight: 200,
                                        // isExpanded: true,
                                        value: provider.selectedStates,
                                        icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: cc.greyFour),
                                        iconSize: 26,
                                        elevation: 17,
                                        style: TextStyle(color: cc.greyFour),
                                        onChanged: (newValue) {
                                          provider.setStatesValue(newValue);

                                          //setting the id of selected value
                                          // provider.setId(
                                          //     provider.valueIndexList[
                                          //         provider.dropdown
                                          //             .indexOf(newValue)]);
                                        },
                                        items: provider.statesDropdown
                                            .map<DropdownMenuItem<String>>(
                                                (value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  color: cc.greyPrimary
                                                      .withOpacity(.8)),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )
                                : Container(),

                            const SizedBox(
                              height: 25,
                            ),

                            // Country dropdown ===============>
                            CommonHelper().labelCommon("Choose area"),
                            provider.areaDropdown.isNotEmpty
                                ? Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: cc.greyFive),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.01),
                                            spreadRadius: -2,
                                            blurRadius: 13,
                                            offset: const Offset(0, 13)),
                                      ],
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        // menuMaxHeight: 200,
                                        // isExpanded: true,
                                        value: provider.selectedArea,
                                        icon: Icon(
                                            Icons.keyboard_arrow_down_rounded,
                                            color: cc.greyFour),
                                        iconSize: 26,
                                        elevation: 17,
                                        style: TextStyle(color: cc.greyFour),
                                        onChanged: (newValue) {
                                          provider.setAreaValue(newValue);

                                          //setting the id of selected value
                                          // provider.setId(
                                          //     provider.valueIndexList[
                                          //         provider.dropdown
                                          //             .indexOf(newValue)]);
                                        },
                                        items: provider.areaDropdown
                                            .map<DropdownMenuItem<String>>(
                                                (value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  color: cc.greyPrimary
                                                      .withOpacity(.8)),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        )),
                //Login button ==================>
                const SizedBox(
                  height: 27,
                ),
                CommonHelper().buttonOrange("Next", () {
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          const ServicePersonalizationPage(),
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
