import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/service/signup_service.dart';
import 'package:qixer/view/auth/signup/signup_helper.dart';
import 'package:qixer/view/home/landing_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class SignupCountryStates extends StatefulWidget {
  const SignupCountryStates({Key? key}) : super(key: key);

  @override
  _SignupCountryStatesState createState() => _SignupCountryStatesState();
}

class _SignupCountryStatesState extends State<SignupCountryStates> {
  @override
  void initState() {
    super.initState();
  }

  bool termsAgree = false;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(color: cc.greyFive),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.01),
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
                                        .map<DropdownMenuItem<String>>((value) {
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(color: cc.greyFive),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.01),
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
                                        .map<DropdownMenuItem<String>>((value) {
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  border: Border.all(color: cc.greyFive),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.01),
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
                                        .map<DropdownMenuItem<String>>((value) {
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

//Agreement checkbox ===========>
                        const SizedBox(
                          height: 17,
                        ),
                        CheckboxListTile(
                          checkColor: Colors.white,
                          activeColor: ConstantColors().primaryColor,
                          contentPadding: const EdgeInsets.all(0),
                          title: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(
                              "I agree with the terms and conditons",
                              style: TextStyle(
                                  color: ConstantColors().greyFour,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                          value: termsAgree,
                          onChanged: (newValue) {
                            setState(() {
                              termsAgree = !termsAgree;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                      ],
                    )),
            //Login button ==================>
            const SizedBox(
              height: 17,
            ),
            Consumer<SignupService>(
              builder: (context, provider, child) => InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const LandingPage(),
                    ),
                  );
                },
                child: CommonHelper().buttonOrange('Sign Up'),
              ),
            ),

            const SizedBox(
              height: 25,
            ),
            SignupHelper().haveAccount(context),

            const SizedBox(
              height: 30,
            ),
          ],
        ));
  }
}
