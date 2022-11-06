import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/live_chat/chat_list_service.dart';
import 'package:qixer/service/profile_service.dart';
import 'package:qixer/view/jobs/my_jobs_page.dart';
import 'package:qixer/view/live_chat/chat_list_page.dart';
import 'package:qixer/view/tabs/settings/components/settings_page_grid.dart';
import 'package:qixer/view/tabs/settings/password/change_password_page.dart';
import 'package:qixer/view/tabs/settings/profile_edit.dart';
import 'package:qixer/view/tabs/settings/settings_helper.dart';
import 'package:qixer/view/tabs/settings/supports/my_tickets_page.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';

import '../../booking/booking_helper.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: physicsCommon,
                child: Consumer<AppStringService>(
                  builder: (context, asProvider, child) =>
                      Consumer<ProfileService>(
                    builder: (context, profileProvider, child) =>
                        profileProvider.profileDetails != null
                            ? profileProvider.profileDetails != 'error'
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenPadding),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //profile image, name ,desc
                                              Column(
                                                children: [
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                  //Profile image section =======>
                                                  InkWell(
                                                    highlightColor:
                                                        Colors.transparent,
                                                    splashColor:
                                                        Colors.transparent,
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute<void>(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              const ProfileEditPage(),
                                                        ),
                                                      );
                                                    },
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        profileProvider
                                                                    .profileImage !=
                                                                null
                                                            ? CommonHelper()
                                                                .profileImage(
                                                                    profileProvider
                                                                        .profileImage,
                                                                    62,
                                                                    62)
                                                            : ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/avatar.png',
                                                                  height: 62,
                                                                  width: 62,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),

                                                        const SizedBox(
                                                          height: 12,
                                                        ),

                                                        //user name
                                                        CommonHelper().titleCommon(
                                                            profileProvider
                                                                    .profileDetails
                                                                    .userDetails
                                                                    .name ??
                                                                ''),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        //phone
                                                        CommonHelper().paragraphCommon(
                                                            profileProvider
                                                                    .profileDetails
                                                                    .userDetails
                                                                    .phone ??
                                                                '',
                                                            TextAlign.center),
                                                        // const SizedBox(
                                                        //   height: 10,
                                                        // ),
                                                        profileProvider
                                                                    .profileDetails
                                                                    .userDetails
                                                                    .about !=
                                                                null
                                                            ? CommonHelper()
                                                                .paragraphCommon(
                                                                    profileProvider
                                                                        .profileDetails
                                                                        .userDetails
                                                                        .about,
                                                                    TextAlign
                                                                        .center)
                                                            : Container(),
                                                      ],
                                                    ),
                                                  ),

                                                  //Grid cards
                                                  SettingsPageGrid(
                                                    cc: cc,
                                                    asProvider: asProvider,
                                                  ),
                                                ],
                                              ),

                                              //
                                            ]),
                                      ),
                                      SettingsHelper().borderBold(30, 20),

                                      // Personal information ==========>
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenPadding),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CommonHelper().titleCommon(
                                                  asProvider.getString(
                                                      "Personal informations")),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              BookingHelper().bRow(
                                                  'null',
                                                  asProvider.getString("Email"),
                                                  profileProvider.profileDetails
                                                          .userDetails.email ??
                                                      ''),
                                              BookingHelper().bRow(
                                                  'null',
                                                  asProvider.getString("City"),
                                                  profileProvider
                                                          .profileDetails
                                                          .userDetails
                                                          .city
                                                          .serviceCity ??
                                                      ''),
                                              BookingHelper().bRow(
                                                  'null',
                                                  asProvider.getString("Area"),
                                                  profileProvider
                                                          .profileDetails
                                                          .userDetails
                                                          .area
                                                          .serviceArea ??
                                                      ''),
                                              BookingHelper().bRow(
                                                  'null',
                                                  asProvider
                                                      .getString("Country"),
                                                  profileProvider
                                                          .profileDetails
                                                          .userDetails
                                                          .country
                                                          .country ??
                                                      ''),
                                              BookingHelper().bRow(
                                                  'null',
                                                  asProvider
                                                      .getString("Post Code"),
                                                  profileProvider
                                                          .profileDetails
                                                          .userDetails
                                                          .postCode ??
                                                      ''),
                                              BookingHelper().bRow(
                                                  'null',
                                                  asProvider
                                                      .getString("Address"),
                                                  profileProvider
                                                          .profileDetails
                                                          .userDetails
                                                          .address ??
                                                      '',
                                                  lastBorder: false),
                                            ]),
                                      ),

                                      SettingsHelper().borderBold(35, 8),

                                      //Other settings options ========>
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(children: [
                                          SettingsHelper().settingOption(
                                              'assets/svg/message-circle.svg',
                                              asProvider.getString("My jobs"),
                                              () {
                                            //=====>
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        const MyJobsPage(),
                                              ),
                                            );
                                          }),
                                          CommonHelper().dividerCommon(),
                                          SettingsHelper().settingOption(
                                              'assets/svg/message-circle.svg',
                                              asProvider.getString(
                                                  "Support Ticket"), () {
                                            //=====>
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        const MyTicketsPage(),
                                              ),
                                            );
                                          }),
                                          CommonHelper().dividerCommon(),
                                          SettingsHelper().settingOption(
                                              'assets/svg/profile-edit.svg',
                                              asProvider.getString(
                                                  "Edit Profile"), () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder:
                                                    (BuildContext context) =>
                                                        const ProfileEditPage(),
                                              ),
                                            );
                                          }),
                                          CommonHelper().dividerCommon(),
                                          SettingsHelper().settingOption(
                                              'assets/svg/lock-circle.svg',
                                              asProvider.getString(
                                                  "Change Password"), () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute<void>(
                                                builder: (BuildContext
                                                        context) =>
                                                    const ChangePasswordPage(),
                                              ),
                                            );
                                          }),
                                        ]),
                                      ),

                                      // logout
                                      SettingsHelper().borderBold(12, 5),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(children: [
                                          SettingsHelper().settingOption(
                                              'assets/svg/logout-circle.svg',
                                              asProvider.getString("Logout"),
                                              () {
                                            SettingsHelper()
                                                .logoutPopup(context);
                                          }),
                                          sizedBox20()
                                        ]),
                                      )
                                    ],
                                  )
                                : OthersHelper().showError(context)
                            : Container(
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height - 150,
                                child:
                                    OthersHelper().showLoading(cc.primaryColor),
                              ),
                  ),
                ),
              ),

              //chat icon ========>
              Positioned(
                right: 20,
                bottom: 20,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    //=====>
                    Provider.of<ChatListService>(context, listen: false)
                        .fetchChatList(context);

                    //======>
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const ChatListPage(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 12,
                          offset:
                              const Offset(0, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      'assets/svg/message-green.svg',
                      height: 48,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
