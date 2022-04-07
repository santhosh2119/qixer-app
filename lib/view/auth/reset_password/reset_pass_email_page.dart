import 'package:flutter/material.dart';
import 'package:qixer/view/auth/reset_password/reset_pass_otp_pass.dart';
import 'package:qixer/view/utils/common_helper.dart';

import '../../utils/constant_colors.dart';
import '../../utils/custom_input.dart';

class ResetPassEmailPage extends StatefulWidget {
  const ResetPassEmailPage({Key? key}) : super(key: key);

  @override
  _ResetPassEmailPageState createState() => _ResetPassEmailPageState();
}

class _ResetPassEmailPageState extends State<ResetPassEmailPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool keepLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      appBar: CommonHelper().appbarCommon('Reset password', context),
      backgroundColor: Colors.white,
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            height: MediaQuery.of(context).size.height - 120,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 33,
                      ),
                      Text(
                        "Reset password",
                        style: TextStyle(
                            color: cc.greyPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      CommonHelper().paragraphCommon(
                          "Enter the email you used to creat account and we’ll send instruction for restting password",
                          TextAlign.start),

                      const SizedBox(
                        height: 33,
                      ),

                      //Name ============>
                      CommonHelper().labelCommon("Enter Email"),

                      CustomInput(
                        controller: emailController,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                        hintText: "Email",
                        icon: 'assets/icons/email.png',
                        textInputAction: TextInputAction.next,
                      ),

                      //Login button ==================>
                      const SizedBox(
                        height: 13,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {}
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const ResetPassOtpPage(),
                            ),
                          );
                        },
                        child: CommonHelper().buttonOrange('Send Instructions'),
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
