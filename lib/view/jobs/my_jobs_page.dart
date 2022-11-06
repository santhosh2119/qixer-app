import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qixer/service/app_string_service.dart';
import 'package:qixer/service/jobs_service/my_jobs_service.dart';
import 'package:qixer/service/rtl_service.dart';
import 'package:qixer/view/jobs/components/my_jobs_card.dart';
import 'package:qixer/view/jobs/components/my_jobs_page_appbar.dart';
import 'package:qixer/view/jobs/components/my_jobs_popup_menu.dart';
import 'package:qixer/view/utils/common_helper.dart';
import 'package:qixer/view/utils/constant_colors.dart';
import 'package:qixer/view/utils/constant_styles.dart';
import 'package:qixer/view/utils/others_helper.dart';

class MyJobsPage extends StatefulWidget {
  const MyJobsPage({Key? key}) : super(key: key);

  @override
  _MyJobsPageState createState() => _MyJobsPageState();
}

class _MyJobsPageState extends State<MyJobsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ConstantColors cc = ConstantColors();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: MyJobsPageAppbar(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenPadding),
              clipBehavior: Clip.none,
              child: Consumer<AppStringService>(
                builder: (context, asProvider, child) =>
                    Consumer<MyJobsService>(
                  builder: (context, provider, child) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sizedBoxCustom(10),
                        Column(
                          children: [
                            for (int i = 0;
                                i < provider.myJobsListMap.length;
                                i++)
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(bottom: 20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(color: cc.borderColor),
                                    borderRadius: BorderRadius.circular(9)),
                                padding:
                                    const EdgeInsets.fromLTRB(13, 0, 13, 4),
                                child: Column(
                                  children: [
                                    //popup button
                                    //==============>
                                    const MyJobsPopupMenu(),

                                    MyJobsCardContents(
                                      cc: cc,
                                      imageLink: placeHolderUrl,
                                      title: provider.myJobsListMap[i]['title'],
                                      viewCount: '173',
                                      price: 100,
                                    ),
                                    const SizedBox(
                                      height: 18,
                                    ),
                                    CommonHelper().dividerCommon(),
                                    sizedBoxCustom(3),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              AutoSizeText(
                                                '${asProvider.getString('Starts from')}:',
                                                textAlign: TextAlign.start,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: cc.greyFour
                                                      .withOpacity(.6),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              Consumer<RtlService>(
                                                builder:
                                                    (context, rtlP, child) =>
                                                        Expanded(
                                                  child: AutoSizeText(
                                                    rtlP.currencyDirection ==
                                                            'left'
                                                        ? '${rtlP.currency} ${provider.myJobsListMap[i]['price']}'
                                                        : '${provider.myJobsListMap[i]['price']}${rtlP.currency}',
                                                    textAlign: TextAlign.start,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: cc.greyFour,
                                                      fontSize: 19,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        //on off button
                                        Switch(
                                          // This bool value toggles the switch.
                                          value: provider.myJobsListMap[i]
                                              ['isActive'],
                                          activeColor: cc.successColor,
                                          onChanged: (bool value) {
                                            provider.setActiveStatus(value, i);
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                          ],
                        )

                        //
                      ]),
                ),
              )),
        ),
      ),
    );
  }
}

// class SwitchButton extends StatefulWidget {
//   const SwitchButton({Key? key, required this.switchOn}) : super(key: key);

//   final bool switchOn;

//   @override
//   State<SwitchButton> createState() => _SwitchButtonState();
// }

// class _SwitchButtonState extends State<SwitchButton> {
//   @override
//   Widget build(BuildContext context) {
//     final cc = ConstantColors();
//     return Switch(
//       // This bool value toggles the switch.
//       value: widget.switchOn,
//       activeColor: cc.successColor,
//       onChanged: (bool value) {},
//     );
//   }
// }
