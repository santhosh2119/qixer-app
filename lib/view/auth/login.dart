import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/auth/login_helper.dart';

import '../utils/constant_colors.dart';
import '../utils/custom_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {}

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool keepLoggedIn = true;

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.focusedChild?.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 230.0,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/login-slider.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 30,
                      left: 10,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: cc.greyPrimary,
                            size: 20,
                          ),
                        ),
                      )),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 33,
                      ),
                      Text(
                        "Welcome back! Login",
                        style: TextStyle(
                            color: cc.greyPrimary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(
                        height: 33,
                      ),

                      //Name
                      Text(
                        "Username",
                        style: TextStyle(
                          color: cc.greyPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      CustomInput(
                        controller: emailController,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                        hintText: "User Name",
                        icon: 'assets/icons/user.png',
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 8,
                      ),

                      //password
                      Text(
                        "Password",
                        style: TextStyle(
                          color: cc.greyPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 13,
                      ),
                      CustomInput(
                        controller: passwordController,
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        hintText: "Enter Password",
                        icon: 'assets/icons/lock.png',
                        textInputAction: TextInputAction.next,
                        isPasswordField: true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          //keep logged in checkbox
                          Expanded(
                            child: CheckboxListTile(
                              checkColor: Colors.white,
                              activeColor: ConstantColors().primaryColor,
                              contentPadding: const EdgeInsets.all(0),
                              title: Text(
                                "Remember me",
                                style: TextStyle(
                                    color: ConstantColors().greyPrimary,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                              value: keepLoggedIn,
                              onChanged: (newValue) {
                                setState(() {
                                  keepLoggedIn = !keepLoggedIn;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                          SizedBox(
                            width: 122,
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  color: cc.primaryColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),

                      //Login button
                      const SizedBox(
                        height: 13,
                      ),
                      InkWell(
                        onTap: () {
                          if (_formKey.currentState!.validate()) {}

                          // Navigator.pushReplacement<void, void>(
                          //   context,
                          //   MaterialPageRoute<void>(
                          //     builder: (BuildContext context) =>
                          //         const LandingPage(),
                          //   ),
                          // );
                        },
                        child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                                color: cc.primaryColor,
                                borderRadius: BorderRadius.circular(9)),
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),

                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Don\'t have account?  ',
                              style: const TextStyle(
                                  color: Color(0xff646464), fontSize: 15),
                              children: <TextSpan>[
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const SignUpPage()));
                                      },
                                    text: 'Register',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: cc.primaryColor,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),

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
                            color: cc.greyThree,
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
                            color: cc.greyThree,
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
                              'assets/icons/facebook.png',
                              "Login with Facebook")),

                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
