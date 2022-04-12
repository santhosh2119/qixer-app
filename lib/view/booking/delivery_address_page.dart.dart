import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:qixer/view/booking/book_confirmation_page.dart';
import 'package:qixer/view/booking/booking_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

import '../auth/login/login_helper.dart';
import '../utils/custom_input.dart';
import 'components/steps.dart';

class DeliveryAddressPage extends StatefulWidget {
  const DeliveryAddressPage({Key? key}) : super(key: key);

  @override
  _DeliveryAddressPageState createState() => _DeliveryAddressPageState();
}

class _DeliveryAddressPageState extends State<DeliveryAddressPage> {
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Listener(
      onPointerDown: (_) {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild?.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonHelper().appbarCommon('Address', context),
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

                  CommonHelper().titleCommon('Booking Information'),

                  const SizedBox(
                    height: 22,
                  ),

                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // name ============>
                        CommonHelper().labelCommon("Name"),

                        CustomInput(
                          controller: userNameController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          hintText: "Enter your name",
                          icon: 'assets/icons/user.png',
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(
                          height: 2,
                        ),

                        //Email ============>
                        CommonHelper().labelCommon("Email"),

                        CustomInput(
                          controller: emailController,
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
                          height: 2,
                        ),

                        //Phone number field
                        CommonHelper().labelCommon("Phone"),
                        IntlPhoneField(
                          decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle:
                                  TextStyle(color: cc.greyFour, fontSize: 14),
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
                              hintText: 'Enter password',
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 18)),
                          initialCountryCode: 'IN',
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                        ),

                        CommonHelper().labelCommon("Post code"),

                        CustomInput(
                          controller: postCodeController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter post code';
                            }
                            return null;
                          },
                          isNumberField: true,
                          hintText: "Enter your post code",
                          icon: 'assets/icons/user.png',
                          textInputAction: TextInputAction.next,
                        ),

                        //Address ============>

                        const SizedBox(
                          height: 2,
                        ),
                        CommonHelper().labelCommon("Your address"),

                        CustomInput(
                          controller: addressController,
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                          hintText: "Enter your address",
                          icon: 'assets/icons/email-grey.png',
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        CommonHelper().labelCommon("Order note"),

                        TextField(
                            controller: notesController,
                            maxLines: 6,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
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
                                hintText: 'e.g. come with ideal brushes...',
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 18, vertical: 18))),
                        const SizedBox(
                          height: 19,
                        ),

                        //button ======>
                        CommonHelper().buttonOrange("Next", () {
                          if (_formKey.currentState!.validate()) {}
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const BookConfirmationPage(),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
