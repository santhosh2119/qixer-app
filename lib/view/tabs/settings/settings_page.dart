import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutterzilla_fixed_grid/flutterzilla_fixed_grid.dart';
import 'package:qixer/view/home/components/search_bar.dart';
import 'package:qixer/view/home/components/service_card.dart';
import 'package:qixer/view/services/service_details_page.dart';
import 'package:qixer/view/tabs/settings/components/settings_page_grid.dart';
import 'package:qixer/view/tabs/settings/settings_helper.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';

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
            child: Column(
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
                SettingsHelper().borderBold(),
              ],
            ),
          ),
        ));
  }
}
