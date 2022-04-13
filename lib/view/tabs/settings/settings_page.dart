import 'package:flutter/material.dart';
import 'package:qixer/view/tabs/settings/components/settings_page_grid.dart';
import 'package:qixer/view/tabs/settings/settings_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

import '../../booking/booking_helper.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: physicsCommon,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenPadding),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //profile image, name ,desc
                        Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            CommonHelper().profileImage(
                                "https://cdn.pixabay.com/photo/2021/09/14/11/33/tree-6623764__340.jpg",
                                62,
                                62),

                            const SizedBox(
                              height: 12,
                            ),

                            //user name
                            CommonHelper().titleCommon('Leslie Alexander'),
                            const SizedBox(
                              height: 5,
                            ),
//phone
                            CommonHelper().paragraphCommon(
                                '(208) 555-0112', TextAlign.center),
                            const SizedBox(
                              height: 10,
                            ),
                            CommonHelper().paragraphCommon(
                                'It is a long established fact that a reader will be distracted by the readable content of a page when',
                                TextAlign.center),

                            //Grid cards
                            SettingsPageGrid(cc: cc),
                          ],
                        ),

                        //
                      ]),
                ),
                SettingsHelper().borderBold(30, 20),

                // Personal information ==========>
                Container(
                  padding: EdgeInsets.symmetric(horizontal: screenPadding),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonHelper().titleCommon('Personal informations'),
                        const SizedBox(
                          height: 25,
                        ),
                        BookingHelper()
                            .bRow('null', 'Email', 'leslialex@example.com'),
                        BookingHelper().bRow('null', 'City', 'Dhaka'),
                        BookingHelper().bRow('null', 'Area', 'Dhanmondi'),
                        BookingHelper().bRow('null', 'Country', 'Bangladesh'),
                        BookingHelper().bRow('null', 'Post Code', '1230'),
                        BookingHelper().bRow('null', 'Address',
                            'Dhanmondi 1230, Dhaka Bangladesh'),
                      ]),
                ),

                SettingsHelper().borderBold(20, 10),

//Other settings options ========>
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(children: [
                    SettingsHelper().settingOption(
                        'assets/svg/message-circle.svg',
                        'Support Ticket',
                        () {}),
                    CommonHelper().dividerCommon(),
                    SettingsHelper().settingOption(
                        'assets/svg/lock-circle.svg', 'Change Password', () {}),
                    SettingsHelper().borderBold(12, 5),
                    SettingsHelper().settingOption(
                        'assets/svg/logout-circle.svg', 'Logout', () {}),
                    sizedBox20()
                  ]),
                )
              ],
            ),
          ),
        ));
  }
}
