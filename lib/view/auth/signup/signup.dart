import 'package:flutter/material.dart';
import 'package:qixer/view/auth/signup/pages/signup_country_states.dart';
import 'package:qixer/view/auth/signup/pages/signup_email_name.dart';
import 'package:qixer/view/auth/signup/pages/signup_phone_pass.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  ConstantColors cc = ConstantColors();
  int _selectedSlide = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('', context),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(
            height: 5,
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: CommonHelper().titleCommon('Register to join us'),
          ),

          const SizedBox(
            height: 35,
          ),

          //Page steps show =======>
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < 3; i++)
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: _selectedSlide == i
                              ? cc.primaryColor
                              : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: _selectedSlide == i
                                  ? Colors.transparent
                                  : cc.greyFive)),
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                            color: _selectedSlide == i
                                ? Colors.white
                                : cc.greyPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //line
                    i > 1
                        ? Container()
                        : Container(
                            height: 3,
                            width: screenWidth / 2 - 85,
                            color: _selectedSlide == i
                                ? cc.primaryColor
                                : cc.greyFive,
                          )
                  ],
                ),
            ],
          ),

          const SizedBox(
            height: 35,
          ),

          //Slider =============>
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SizedBox(
                height: 700,
                child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) {
                      setState(() {
                        _selectedSlide = value;
                      });
                    },
                    itemCount: 3,
                    itemBuilder: (context, i) {
                      if (i == 0) {
                        return const SignupEmailName();
                      } else if (i == 1) {
                        return const SignupPhonePass();
                      } else {
                        return const SignupCountryStates();
                      }
                    }),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
