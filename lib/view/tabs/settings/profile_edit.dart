import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/country_states_service.dart';
import 'package:qixer/service/profile_edit_service.dart';
import 'package:qixer/view/auth/signup/components/country_states_dropdowns.dart';
import 'package:qixer/view/auth/signup/components/email_name_fields.dart';
import 'package:qixer/view/auth/signup/signup_helper.dart';
import 'package:qixer/view/booking/components/textarea_field.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../utils/custom_input.dart';

class ProfileEditPage extends StatefulWidget {
  ProfileEditPage({Key? key}) : super(key: key);

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  TextEditingController postCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  late AnimationController localAnimationController;
  XFile? pickedImage;
  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonHelper().appbarCommon('Edit profile', context, () {
        Navigator.pop(context);
      }),
      body: SingleChildScrollView(
        physics: physicsCommon,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: screenPadding),
          child: Consumer<ProfileEditService>(
            builder: (context, provider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //pick profile image
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    pickedImage = await provider.pickImage();
                    setState(() {});
                  },
                  child: SizedBox(
                    width: 105,
                    height: 105,
                    child: Stack(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: pickedImage == null
                                  ? Image.asset(
                                      'assets/images/avatar.png',
                                      height: 85,
                                      width: 85,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(pickedImage!.path),
                                      height: 85,
                                      width: 85,
                                      fit: BoxFit.cover,
                                    )),
                        ),
                        Positioned(
                          bottom: 9,
                          right: 12,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                                child: Icon(
                              Icons.camera,
                              color: cc.greyPrimary,
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                //Email, name
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
                  height: 8,
                ),

                //phone
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonHelper().labelCommon("Phone"),
                    IntlPhoneField(
                      controller: phoneController,
                      decoration: SignupHelper().phoneFieldDecoration(),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        // Provider.of<SignupService>(context, listen: false)
                        //     .setPhone(phone.completeNumber);
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
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),

                //dropdowns
                const CountryStatesDropdowns(),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    CommonHelper().labelCommon("Your Address"),
                    TextareaField(
                      hintText: 'Address',
                      notesController: addressController,
                    ),
                  ],
                ),

                //About
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    CommonHelper().labelCommon("About"),
                    TextareaField(
                      hintText: 'About',
                      notesController: aboutController,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),
                CommonHelper().buttonOrange('Save', () async {
                  if (provider.isloading == false) {
                    showTopSnackBar(
                        context,
                        const CustomSnackBar.success(
                          message: "Updating profile...",
                        ),
                        persistent: true,
                        onAnimationControllerInit: (controller) =>
                            localAnimationController = controller,
                        onTap: () {
                          // localAnimationController.reverse();
                        });

                    //update profile
                    var result = await provider.updateProfile(
                      fullNameController.text,
                      emailController.text,
                      phoneController.text,
                      Provider.of<CountryStatesService>(context, listen: false)
                          .selectedStateId,
                      Provider.of<CountryStatesService>(context, listen: false)
                          .selectedAreaId,
                      Provider.of<CountryStatesService>(context, listen: false)
                          .selectedCountryId,
                      postCodeController.text,
                      addressController.text,
                      aboutController.text,
                      pickedImage!.path,
                      context,
                    );
                    if (result == true || result == false) {
                      localAnimationController.reverse();
                    }
                  }
                }, isloading: provider.isloading == false ? false : true),

                const SizedBox(
                  height: 38,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
