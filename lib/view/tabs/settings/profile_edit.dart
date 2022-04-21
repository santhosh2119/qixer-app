import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/profile_edit_service.dart';
import 'package:qixer/view/auth/signup/components/country_states_dropdowns.dart';
import 'package:qixer/view/auth/signup/components/email_name_fields.dart';
import 'package:qixer/view/auth/signup/signup_helper.dart';
import 'package:qixer/view/booking/components/textarea_field.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

import '../../utils/custom_input.dart';

class ProfileEditPage extends StatefulWidget {
  ProfileEditPage({Key? key}) : super(key: key);

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
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
                                  ? CommonHelper().profileImage(
                                      "https://cdn.pixabay.com/photo/2022/03/23/10/50/sea-7086932__340.jpg",
                                      82,
                                      82)
                                  : Image.file(
                                      File(pickedImage!.path),
                                      height: 90,
                                      width: 90,
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
                EmailNameFields(
                  emailController: widget.emailController,
                  fullNameController: widget.fullNameController,
                  userNameController: widget.userNameController,
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
                      decoration: SignupHelper().phoneFieldDecoration(),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {
                        // Provider.of<SignupService>(context, listen: false)
                        //     .setPhone(phone.completeNumber);
                      },
                    ),
                    CommonHelper().labelCommon("Post code"),
                    CustomInput(
                      controller: widget.postCodeController,
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
                      height: 22,
                    ),
                    CommonHelper().labelCommon("Your Address"),
                    TextareaField(
                      hintText: 'Address',
                      notesController: widget.notesController,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),
                CommonHelper().buttonOrange('Save', () {}),

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
