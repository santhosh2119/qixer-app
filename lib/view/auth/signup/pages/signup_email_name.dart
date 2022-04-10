import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/signup_service.dart';
import 'package:qixer/view/auth/login/login_helper.dart';
import 'package:qixer/view/auth/signup/signup_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/custom_input.dart';

import '../../../utils/constant_colors.dart';

class SignupEmailName extends StatefulWidget {
  const SignupEmailName({Key? key}) : super(key: key);

  @override
  _SignupEmailNameState createState() => _SignupEmailNameState();
}

class _SignupEmailNameState extends State<SignupEmailName> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  bool keepLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Name ============>
            CommonHelper().labelCommon("Full name"),

            CustomInput(
              controller: fullNameController,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your full name';
                }
                return null;
              },
              hintText: "Enter your full name",
              icon: 'assets/icons/user.png',
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 8,
            ),

            //User name ============>
            CommonHelper().labelCommon("Username"),

            CustomInput(
              controller: userNameController,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
              hintText: "Enter your username",
              icon: 'assets/icons/user.png',
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 8,
            ),

            //Email ============>
            CommonHelper().labelCommon("Email"),

            CustomInput(
              controller: userNameController,
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              hintText: "Enter your email",
              icon: 'assets/icons/email-grey.png',
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(
              height: 8,
            ),

            //Login button ==================>
            const SizedBox(
              height: 13,
            ),
            Consumer<SignupService>(
              builder: (context, provider, child) => InkWell(
                onTap: () {
                  // if (_formKey.currentState!.validate()) {
                  //   provider.pagecontroller.animateToPage(
                  //       provider.selectedPage + 1,
                  //       duration: const Duration(milliseconds: 300),
                  //       curve: Curves.ease);
                  // }
                  provider.pagecontroller.animateToPage(
                      provider.selectedPage + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.ease);
                },
                child: CommonHelper().buttonOrange("Continue", () {}),
              ),
            ),

            const SizedBox(
              height: 25,
            ),
            SignupHelper().haveAccount(context),

            //Divider (or)
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  height: 1,
                  color: cc.greyFive,
                )),
                Container(
                  width: 40,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 25),
                  child: Text(
                    "OR",
                    style: TextStyle(
                        color: cc.greyPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                    child: Container(
                  height: 1,
                  color: cc.greyFive,
                )),
              ],
            ),

//login with google, facebook button ===========>
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {},
                child: LoginHelper().commonButton(
                    'assets/icons/google.png', "Login with Google")),
            const SizedBox(
              height: 20,
            ),
            InkWell(
                onTap: () {},
                child: LoginHelper().commonButton(
                    'assets/icons/facebook.png', "Login with Facebook")),

            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
