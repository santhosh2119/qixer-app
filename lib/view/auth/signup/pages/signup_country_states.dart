import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/service/signup_service.dart';
import 'package:qixer/view/auth/signup/components/country_states_dropdowns.dart';
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
            const CountryStatesDropdowns(),
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
            //Login button ==================>
            const SizedBox(
              height: 17,
            ),
            Consumer<SignupService>(
              builder: (context, provider, child) =>
                  CommonHelper().buttonOrange("Sign Up", () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const LandingPage(),
                  ),
                );
              }),
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
