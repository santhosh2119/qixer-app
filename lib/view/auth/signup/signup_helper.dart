import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:qixer/view/auth/login/login.dart';
import 'package:qixer/view/utils/constant_colors.dart';

class SignupHelper {
  ConstantColors cc = ConstantColors();
  haveAccount(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            text: 'Have an account?  ',
            style: const TextStyle(color: Color(0xff646464), fontSize: 14),
            children: <TextSpan>[
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                  text: 'Sign in',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: cc.primaryColor,
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
