import 'package:flutter/material.dart';

import 'constant_colors.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validation;
  final TextInputAction textInputAction;
  final bool isPasswordField;
  final FocusNode? focusNode;
  final bool isNumberField;
  final String icon;
  TextEditingController? controller;

  CustomInput(
      {Key? key,
      required this.hintText,
      this.onChanged,
      this.textInputAction = TextInputAction.next,
      this.isPasswordField = false,
      this.focusNode,
      this.isNumberField = false,
      this.controller,
      this.validation,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        margin: const EdgeInsets.only(bottom: 19),
        decoration: BoxDecoration(
            // color: const Color(0xfff2f2f2),
            borderRadius: BorderRadius.circular(10)),
        child: TextFormField(
          controller: controller,
          keyboardType:
              isNumberField ? TextInputType.number : TextInputType.text,
          focusNode: focusNode,
          onChanged: onChanged,
          validator: validation,
          textInputAction: textInputAction,
          obscureText: isPasswordField,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
              prefixIcon: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 22.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(icon), fit: BoxFit.fitHeight),
                    ),
                  ),
                ],
              ),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstantColors().greyThree),
                  borderRadius: BorderRadius.circular(9)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstantColors().primaryColor)),
              errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstantColors().redColor)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: ConstantColors().primaryColor)),
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 15)),
        ));
  }
}
