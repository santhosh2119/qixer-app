import 'package:flutter/material.dart';
import 'package:qixer/view/auth/reset_password/reset_pass_otp_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_styles.dart';

import '../../utils/constant_colors.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late bool _newpasswordVisible;
  late bool _repeatnewpasswordVisible;

  @override
  void initState() {
    super.initState();
    _newpasswordVisible = false;
    _repeatnewpasswordVisible = false;
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController repeatNewPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  bool keepLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      appBar: CommonHelper().appbarCommon('Change password', context, () {
        Navigator.pop(context);
      }),
      backgroundColor: Colors.white,
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: SingleChildScrollView(
          physics: physicsCommon,
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
                      CommonHelper().titleCommon("Enter new password"),
                      const SizedBox(
                        height: 13,
                      ),
                      CommonHelper().paragraphCommon(
                          "Your new password be different from previously used passwords",
                          TextAlign.start),

                      const SizedBox(
                        height: 33,
                      ),

//New password =========================>
                      CommonHelper().labelCommon("Enter new password"),

                      Container(
                          margin: const EdgeInsets.only(bottom: 19),
                          decoration: BoxDecoration(
                              // color: const Color(0xfff2f2f2),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller: newPasswordController,
                            textInputAction: TextInputAction.next,
                            obscureText: !_newpasswordVisible,
                            style: const TextStyle(fontSize: 14),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 22.0,
                                      width: 40.0,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/icons/lock.png'),
                                            fit: BoxFit.fitHeight),
                                      ),
                                    ),
                                  ],
                                ),
                                suffixIcon: IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _newpasswordVisible
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.grey,
                                    size: 22,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _newpasswordVisible =
                                          !_newpasswordVisible;
                                    });
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstantColors().greyFive),
                                    borderRadius: BorderRadius.circular(9)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstantColors().primaryColor)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstantColors().warningColor)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstantColors().primaryColor)),
                                hintText: 'New password',
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 18)),
                          )),

                      //Repeat New password =========================>
                      CommonHelper().labelCommon("Repeat new password"),

                      Container(
                          margin: const EdgeInsets.only(bottom: 19),
                          decoration: BoxDecoration(
                              // color: const Color(0xfff2f2f2),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextFormField(
                            controller: repeatNewPasswordController,
                            textInputAction: TextInputAction.next,
                            obscureText: !_repeatnewpasswordVisible,
                            style: const TextStyle(fontSize: 14),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please retype your password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 22.0,
                                      width: 40.0,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/icons/lock.png'),
                                            fit: BoxFit.fitHeight),
                                      ),
                                    ),
                                  ],
                                ),
                                suffixIcon: IconButton(
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _repeatnewpasswordVisible
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    color: Colors.grey,
                                    size: 22,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _repeatnewpasswordVisible =
                                          !_repeatnewpasswordVisible;
                                    });
                                  },
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstantColors().greyFive),
                                    borderRadius: BorderRadius.circular(9)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstantColors().primaryColor)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstantColors().warningColor)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: ConstantColors().primaryColor)),
                                hintText: 'Retype new password',
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 18)),
                          )),

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
                        child: CommonHelper()
                            .buttonOrange("Change password", () {}),
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
